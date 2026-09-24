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
  for (package in c("xml2", "zip")) {
    if (!requireNamespace(package, quietly = TRUE))
      stop("Missing ", package, "; run install_dependencies.R first.")
  }
  pptx_file <- normalizePath(pptx_file, winslash = "/", mustWork = TRUE)
  markdown_file <- normalizePath(markdown_file, winslash = "/", mustWork = TRUE)
  anchors <- course_slide_anchors(markdown_file, has_title = has_title)
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
