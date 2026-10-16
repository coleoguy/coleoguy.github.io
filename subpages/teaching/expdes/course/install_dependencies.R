# Run once before knitting; the course never installs packages automatically.
# Rscript install_dependencies.R /path/to/course-folder
args <- commandArgs(trailingOnly = TRUE)
file_arg <- grep("^--file=", commandArgs(FALSE), value = TRUE)
course_root <- if (length(args)) args[1] else if (length(file_arg)) {
  dirname(normalizePath(sub("^--file=", "", file_arg[1])))
} else getwd()
course_root <- normalizePath(course_root, winslash = "/", mustWork = TRUE)
repos <- c(CRAN = "https://cloud.r-project.org")
if (!requireNamespace("jsonlite", quietly = TRUE))
  install.packages("jsonlite", repos = repos)
order <- jsonlite::fromJSON(file.path(course_root, "course-order.json"))
metadata <- lapply(order, function(id)
  jsonlite::fromJSON(file.path(course_root, "modules", id, "module.json")))
packages <- sort(unique(c("rmarkdown", "knitr", "jsonlite", "xml2", "zip",
                         unlist(lapply(metadata, `[[`, "packages")))))
missing <- packages[!vapply(packages, requireNamespace, logical(1), quietly = TRUE)]
if (length(missing)) install.packages(missing, repos = repos)
remaining <- packages[!vapply(packages, requireNamespace, logical(1), quietly = TRUE)]
if (length(remaining)) stop("Still unavailable: ", paste(remaining, collapse = ", "))
message("R packages are ready. PowerPoint rendering also needs Pandoc (included with RStudio).")
if (!rmarkdown::pandoc_available())
  message("Pandoc was not found. Use RStudio or install Pandoc before rendering.")
