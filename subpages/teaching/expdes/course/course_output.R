# Portable PowerPoint output with real internal slide navigation.
# This wraps rmarkdown's standard powerpoint_presentation format.

course_slide_anchors <- function(markdown_file, has_title = TRUE) {
  text <- readLines(markdown_file, warn = FALSE, encoding = "UTF-8")
  slide_number <- if (has_title) 1L else 0L
  anchors <- integer()
  in_code <- FALSE
  fence <- ""
  for (line in text) {
    if (grepl("^\\s*(`{3,}|~{3,})", line)) {
      marker <- sub("^\\s*(`{3,}|~{3,}).*$", "\\1", line)
      if (!in_code) {
        in_code <- TRUE
        fence <- substr(marker, 1, 1)
      } else if (substr(marker, 1, 1) == fence) {
        in_code <- FALSE
      }
      next
    }
    if (!in_code && grepl("^##[[:space:]]+", line)) {
      slide_number <- slide_number + 1L
      if (grepl("\\{#[^ }]+", line)) {
        id <- sub("^.*\\{#([^ }]+).*$", "\\1", line)
        if (id %in% names(anchors)) stop("Duplicate slide anchor: ", id)
        anchors[id] <- slide_number
      }
    }
  }
  attr(anchors, "slide_count") <- slide_number
  anchors
}

course_fix_slide_links <- function(pptx_file, markdown_file, has_title = TRUE) {
  for (package in c("xml2", "zip", "jsonlite")) {
    if (!requireNamespace(package, quietly = TRUE))
      stop("Missing ", package, "; run install_dependencies.R first.")
  }
  pptx_file <- normalizePath(pptx_file, winslash = "/", mustWork = TRUE)
  markdown_file <- normalizePath(markdown_file, winslash = "/", mustWork = TRUE)
  anchors <- course_slide_anchors(markdown_file, has_title = has_title)
  # Maroon edge marks the first slide of each teaching section.
  section_ids <- c("course-route", "picker-independent-continuous", "midterm-plan",
                   jsonlite::fromJSON(file.path(dirname(markdown_file), "course-order.json")))
  section_slides <- unname(anchors[names(anchors) %in% section_ids])
  comics <- jsonlite::fromJSON(file.path(dirname(markdown_file), "comics.json"),
                               simplifyVector = FALSE)
  comic_ids <- vapply(comics, function(x) x$id, "")
  comic_slides <- unname(anchors[names(anchors) %in% comic_ids])
  marker_xml <- '<p:sp xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" xmlns:p="http://schemas.openxmlformats.org/presentationml/2006/main"><p:nvSpPr><p:cNvPr id="999" name="Section start marker" /><p:cNvSpPr><a:spLocks noGrp="1" /></p:cNvSpPr><p:nvPr /></p:nvSpPr><p:spPr><a:xfrm><a:off x="0" y="0" /><a:ext cx="228600" cy="6858000" /></a:xfrm><a:prstGeom prst="rect"><a:avLst /></a:prstGeom><a:solidFill><a:srgbClr val="500000" /></a:solidFill><a:ln w="0"><a:noFill /></a:ln></p:spPr></p:sp>'
  scratch <- tempfile("course-pptx-links-")
  dir.create(scratch)
  on.exit(unlink(scratch, recursive = TRUE), add = TRUE)
  utils::unzip(pptx_file, exdir = scratch)
  slide_dir <- file.path(scratch, "ppt", "slides")
  slide_files <- list.files(slide_dir, pattern = "^slide[0-9]+\\.xml$", full.names = TRUE)
  if (length(slide_files) != attr(anchors, "slide_count"))
    stop("Slide count and Markdown headings disagree; internal links were not changed.")
  rel_files <- list.files(file.path(slide_dir, "_rels"),
                         pattern = "^slide[0-9]+\\.xml\\.rels$", full.names = TRUE)
  relationship_ns <- "http://schemas.openxmlformats.org/officeDocument/2006/relationships"
  drawing_ns <- "http://schemas.openxmlformats.org/drawingml/2006/main"
  changed <- 0L
  code_runs_changed <- 0L
  package_changed <- FALSE
  for (rel_file in rel_files) {
    relationships <- xml2::read_xml(rel_file)
    slide_file <- file.path(slide_dir, sub("\\.rels$", "", basename(rel_file)))
    slide <- xml2::read_xml(slide_file)
    updated <- FALSE
    slide_number <- as.integer(sub("^slide([0-9]+)\\.xml$", "\\1", basename(slide_file)))
    if (slide_number %in% section_slides) {
      p_ns <- "http://schemas.openxmlformats.org/presentationml/2006/main"
      tree <- xml2::xml_find_first(slide, ".//p:spTree", ns = c(p = p_ns))
      previous <- xml2::xml_find_all(tree,
        "p:sp[p:nvSpPr/p:cNvPr[@name='Section start marker']]", ns = c(p = p_ns))
      xml2::xml_remove(previous)
      ids <- as.integer(xml2::xml_attr(xml2::xml_find_all(tree, ".//p:cNvPr", ns = c(p = p_ns)), "id"))
      marker <- xml2::read_xml(marker_xml)
      xml2::xml_set_attr(xml2::xml_find_first(marker, ".//p:cNvPr", ns = c(p = p_ns)),
                        "id", as.character(max(ids, 0L, na.rm = TRUE) + 1L))
      xml2::xml_add_child(tree, xml2::xml_root(marker))
      updated <- TRUE
    }
    # Comic interludes use the whole slide so the original artwork remains readable.
    if (slide_number %in% comic_slides) {
      p_ns <- "http://schemas.openxmlformats.org/presentationml/2006/main"
      ns <- c(p = p_ns, a = drawing_ns)
      xml2::xml_set_attr(xml2::xml_root(slide), "showMasterSp", "0")
      canvas <- xml2::xml_find_first(slide, "p:cSld", ns = ns)
      xml2::xml_remove(xml2::xml_find_all(canvas, "p:bg", ns = ns))
      background <- xml2::read_xml(paste0('<p:bg xmlns:p="', p_ns,
        '" xmlns:a="', drawing_ns, '"><p:bgPr><a:solidFill><a:srgbClr val="FFFFFF"/>',
        '</a:solidFill><a:effectLst/></p:bgPr></p:bg>'))
      xml2::xml_add_child(canvas, xml2::xml_root(background), .where = 0)
      shapes <- xml2::xml_find_all(slide, ".//p:spTree/p:sp", ns = ns)
      for (shape in shapes) {
        words <- paste(xml2::xml_text(xml2::xml_find_all(shape, ".//a:t", ns = ns)), collapse = "")
        if (!grepl("Randall Munroe", words, fixed = TRUE)) {
          xml2::xml_remove(shape)
        } else {
          properties <- xml2::xml_find_first(shape, "p:spPr", ns = ns)
          xml2::xml_remove(xml2::xml_find_all(properties, "a:xfrm", ns = ns))
          transform <- xml2::read_xml(paste0('<a:xfrm xmlns:a="', drawing_ns,
            '"><a:off x="457200" y="6540500"/><a:ext cx="11277600" cy="228600"/></a:xfrm>'))
          xml2::xml_add_child(properties, xml2::xml_root(transform), .where = 0)
          bodies <- xml2::xml_find_all(shape, ".//a:bodyPr", ns = ns)
          for (attribute in c("lIns", "rIns", "tIns", "bIns")) xml2::xml_set_attr(bodies, attribute, "0")
          xml2::xml_set_attr(bodies, "anchor", "ctr")
          for (paragraph in xml2::xml_find_all(shape, ".//a:p", ns = ns)) {
            props <- xml2::xml_find_first(paragraph, "a:pPr", ns = ns)
            if (inherits(props, "xml_missing")) props <- xml2::xml_add_child(paragraph, "a:pPr", .where = 0)
            xml2::xml_set_attr(props, "algn", "ctr")
            defaults <- xml2::xml_find_first(props, "a:defRPr", ns = ns)
            if (inherits(defaults, "xml_missing")) defaults <- xml2::xml_add_child(props, "a:defRPr")
            xml2::xml_set_attr(defaults, "sz", "1100")
          }
          xml2::xml_set_attr(xml2::xml_find_all(shape, ".//a:rPr | .//a:endParaRPr", ns = ns), "sz", "1100")
        }
      }
      comic <- comics[[match(names(anchors)[anchors == slide_number], comic_ids)]]
      ratio <- min(1184 / comic$width_px, 650 / comic$height_px)
      width <- comic$width_px * ratio; height <- comic$height_px * ratio
      for (picture in xml2::xml_find_all(slide, ".//p:spTree/p:pic", ns = ns)) {
        offset <- xml2::xml_find_first(picture, "p:spPr/a:xfrm/a:off", ns = ns)
        extent <- xml2::xml_find_first(picture, "p:spPr/a:xfrm/a:ext", ns = ns)
        xml2::xml_set_attr(offset, "x", as.character(round((1280 - width) / 2 * 9525)))
        xml2::xml_set_attr(offset, "y", as.character(round((20 + (650 - height) / 2) * 9525)))
        xml2::xml_set_attr(extent, "cx", as.character(round(width * 9525)))
        xml2::xml_set_attr(extent, "cy", as.character(round(height * 9525)))
      }
      updated <- TRUE
    }
    # Pandoc emits native Courier runs for code; leave prose at the reference size.
    code_style <- "@typeface='Courier' or @typeface='Courier New' or @typeface='CourierNew'"
    code_runs <- xml2::xml_find_all(slide,
      paste0(".//a:rPr[a:latin[", code_style, "]]"), ns = c(a = drawing_ns))
    if (length(code_runs)) {
      xml2::xml_set_attr(code_runs, "sz", "1600")
      code_runs_changed <- code_runs_changed + length(code_runs)
      code_paragraphs <- xml2::xml_find_all(slide,
        paste0(".//a:p[a:r/a:rPr/a:latin[", code_style, "]]"), ns = c(a = drawing_ns))
      for (paragraph in code_paragraphs) {
        properties <- xml2::xml_find_first(paragraph, "a:pPr", ns = c(a = drawing_ns))
        if (inherits(properties, "xml_missing"))
          properties <- xml2::xml_add_child(paragraph, "a:pPr", .where = 0)
        defaults <- xml2::xml_find_first(properties, "a:defRPr", ns = c(a = drawing_ns))
        if (inherits(defaults, "xml_missing"))
          defaults <- xml2::xml_add_child(properties, "a:defRPr")
        xml2::xml_set_attr(defaults, "sz", "1600")
        endings <- xml2::xml_find_all(paragraph, "a:endParaRPr", ns = c(a = drawing_ns))
        xml2::xml_set_attr(endings, "sz", "1600")
      }
      updated <- TRUE
    }
    for (rel in xml2::xml_children(relationships)) {
      target <- xml2::xml_attr(rel, "Target")
      type <- xml2::xml_attr(rel, "Type")
      # Normalize any existing internal relationship too (safe on a second run).
      if (!is.na(type) && endsWith(type, "/slide") &&
          "TargetMode" %in% names(xml2::xml_attrs(rel))) {
        attributes <- xml2::xml_attrs(rel)
        xml2::xml_attrs(rel) <- attributes[names(attributes) != "TargetMode"]
        updated <- TRUE
      }
      if (!is.na(target) && startsWith(target, "#") &&
          !is.na(type) && endsWith(type, "/hyperlink")) {
        anchor <- utils::URLdecode(sub("^#", "", target))
        if (!(anchor %in% names(anchors))) stop("Unresolved slide link: ", target)
        target_part <- paste0("slide", anchors[[anchor]], ".xml")
        if (!file.exists(file.path(slide_dir, target_part)))
          stop("Missing target slide: ", target_part)
        rid <- xml2::xml_attr(rel, "Id")
        xml2::xml_set_attr(rel, "Type", paste0(relationship_ns, "/slide"))
        xml2::xml_set_attr(rel, "Target", target_part)
        attributes <- xml2::xml_attrs(rel)
        xml2::xml_attrs(rel) <- attributes[names(attributes) != "TargetMode"]
        links <- xml2::xml_find_all(slide,
          paste0(".//a:hlinkClick[@r:id='", rid, "']"),
          ns = c(a = drawing_ns, r = relationship_ns))
        if (!length(links)) stop("Slide link relationship has no matching text link: ", rid)
        xml2::xml_set_attr(links, "action", "ppaction://hlinksldjump")
        changed <- changed + length(links)
        updated <- TRUE
      }
    }
    if (updated) {
      package_changed <- TRUE
      xml2::write_xml(relationships, rel_file)
      xml2::write_xml(slide, slide_file)
    }
  }
  if (package_changed) {
    rebuilt <- tempfile("course-linked-", fileext = ".pptx")
    on.exit(unlink(rebuilt), add = TRUE)
    files <- list.files(scratch, recursive = TRUE, all.files = TRUE, no.. = TRUE)
    zip::zipr(rebuilt, files = files, root = scratch, include_directories = FALSE,
              mode = "mirror")
    check <- utils::unzip(rebuilt, list = TRUE)$Name
    if (!all(c("[Content_Types].xml", "ppt/presentation.xml") %in% check))
      stop("Internal-link rebuild did not preserve the PowerPoint package.")
    if (!file.copy(rebuilt, pptx_file, overwrite = TRUE))
      stop("Unable to replace the PowerPoint with its linked version.")
  }
  attr(changed, "code_runs") <- code_runs_changed
  invisible(changed)
}

course_powerpoint <- function(reference_doc = "course-reference.pptx", ...) {
  output <- rmarkdown::powerpoint_presentation(reference_doc = reference_doc,
                                               slide_level = 2, keep_md = TRUE, ...)
  original_post_processor <- output$post_processor
  output$post_processor <- function(metadata, input_file, output_file, clean, verbose) {
    if (!is.null(original_post_processor)) {
      output_file <- original_post_processor(metadata, input_file, output_file, clean, verbose)
    }
    has_title <- !is.null(metadata$title) && length(metadata$title) > 0L
    count <- course_fix_slide_links(output_file, input_file, has_title = has_title)
    if (verbose) message("Created ", as.integer(count), " internal slide links; set ",
                         attr(count, "code_runs"), " code runs to 16 pt.")
    output_file
  }
  output
}
