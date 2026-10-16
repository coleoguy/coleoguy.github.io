# Rebuild each module from its own seed, then read the generated results.
# Command line: Rscript generate_data.R /path/to/course-folder
# From R: source("generate_data.R"); generate_course_data("/path/to/course-folder")

generate_course_data <- function(course_root = getwd(), order = NULL, quiet = FALSE) {
  course_root <- normalizePath(course_root, winslash = "/", mustWork = TRUE)
  if (!requireNamespace("jsonlite", quietly = TRUE))
    stop("Install dependencies first: Rscript install_dependencies.R")
  if (is.null(order)) {
    order <- jsonlite::fromJSON(file.path(course_root, "course-order.json"))
  }
  if (!is.character(order) || !length(order) || anyDuplicated(order))
    stop("course-order.json must contain unique module IDs.")
  module_root <- file.path(course_root, "modules")
  discovered <- basename(dirname(list.files(module_root, pattern = "^module\\.json$",
                                             recursive = TRUE, full.names = TRUE)))
  if (!setequal(order, discovered))
    stop("course-order.json and the module folders must contain the same IDs.")
  metadata <- setNames(lapply(order, function(id) {
    path <- file.path(module_root, id, "module.json")
    m <- jsonlite::fromJSON(path, simplifyVector = FALSE)
    if (!identical(m$id, id)) stop("Module ID disagrees with folder: ", id)
    m
  }), order)
  packages <- sort(unique(c("jsonlite", unlist(lapply(metadata, `[[`, "packages")))))
  missing <- packages[!vapply(packages, requireNamespace, logical(1), quietly = TRUE)]
  if (length(missing))
    stop("Missing packages: ", paste(missing, collapse = ", "),
         ". Run install_dependencies.R before knitting.")
  rscript <- file.path(R.home("bin"), "Rscript")
  status <- vector("list", length(order))
  for (i in seq_along(order)) {
    id <- order[i]
    module_dir <- file.path(module_root, id)
    output_dir <- file.path(module_dir, "generated")
    dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
    script <- normalizePath(file.path(module_dir, "analysis.R"), winslash = "/", mustWork = TRUE)
    output_dir <- normalizePath(output_dir, winslash = "/", mustWork = TRUE)
    log_file <- file.path(output_dir, "run.log")
    if (!quiet) message(sprintf("[%d/%d] %s", i, length(order), id))
    # Each standalone script saves data.csv before reading it for analysis.
    exit_code <- system2(rscript, c("--vanilla", shQuote(script), shQuote(output_dir)),
                         stdout = log_file, stderr = log_file)
    if (!identical(as.integer(exit_code), 0L)) {
      details <- tail(readLines(log_file, warn = FALSE), 15)
      stop("Module failed: ", id, "\n", paste(details, collapse = "\n"))
    }
    expected <- file.path(output_dir, c("data.csv", "plot.png", "results.json"))
    if (!all(file.exists(expected))) stop("Module did not create all artifacts: ", id)
    result <- jsonlite::fromJSON(expected[3], simplifyVector = FALSE)
    if (!all(c("preview", "summary", "report", "full_output") %in% names(result)))
      stop("Incomplete result fields: ", id)
    status[[i]] <- data.frame(module = id, seed = metadata[[id]]$seed,
                              rows = nrow(read.csv(expected[1])), status = "passed")
  }
  status <- do.call(rbind, status)
  write.csv(status, file.path(course_root, "generation-status.csv"), row.names = FALSE)
  versions <- data.frame(package = packages,
                         version = vapply(packages, function(p) as.character(utils::packageVersion(p)), ""))
  write.csv(versions, file.path(course_root, "package-versions.csv"), row.names = FALSE)
  writeLines(capture.output(sessionInfo()), file.path(course_root, "session-info.txt"))
  invisible(status)
}

if (sys.nframe() == 0L) {
  args <- commandArgs(trailingOnly = TRUE)
  file_arg <- grep("^--file=", commandArgs(FALSE), value = TRUE)
  here <- if (length(args)) args[1] else dirname(normalizePath(sub("^--file=", "", file_arg[1])))
  generate_course_data(here)
}
