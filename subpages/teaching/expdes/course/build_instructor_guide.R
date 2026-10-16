# Build the instructor reference from saved course module outputs.
# This function deliberately does not execute module scripts or resimulate data.
# Run after the course has generated every module's data.csv and results.json.
# CLI: Rscript build_instructor_guide.R /absolute/path/to/course

build_instructor_guide <- function(course_dir, output_dir = course_dir,
                                   module_ids = NULL) {
  if (!requireNamespace("jsonlite", quietly = TRUE)) {
    stop("Install the jsonlite package before building the instructor guide.")
  }
  course_dir <- normalizePath(course_dir, winslash = "/", mustWork = TRUE)
  dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
  output_dir <- normalizePath(output_dir, winslash = "/", mustWork = TRUE)
  module_dir <- file.path(course_dir, "modules")
  paths <- list.files(module_dir, pattern = "^module\\.json$",
                      recursive = TRUE, full.names = TRUE)
  if (!length(paths)) stop("No modules/*/module.json files were found.")
  all_ids <- basename(dirname(paths))
  is_subset <- !is.null(module_ids)
  if (is_subset) {
    absent <- setdiff(module_ids, all_ids)
    if (length(absent)) stop("Unknown module IDs: ", paste(absent, collapse = ", "))
    paths <- paths[match(module_ids, all_ids)]
  }

  text_value <- function(x, sep = " ") {
    if (is.null(x) || !length(x)) return("")
    paste(as.character(unlist(x, use.names = FALSE)), collapse = sep)
  }
  esc <- function(x) {
    x <- as.character(x)
    x <- gsub("&", "&amp;", x, fixed = TRUE)
    x <- gsub("<", "&lt;", x, fixed = TRUE)
    x <- gsub(">", "&gt;", x, fixed = TRUE)
    x <- gsub('"', "&quot;", x, fixed = TRUE)
    gsub("'", "&#39;", x, fixed = TRUE)
  }
  md_cell <- function(x) {
    x <- gsub("|", "\\|", text_value(x), fixed = TRUE)
    gsub("[\r\n]+", " ", x)
  }
  index_result <- function(x) {
    lines <- as.character(unlist(x, use.names = FALSE))
    if (length(lines) <= 1L) return(lines)
    evidence <- grep("\\bp(?:[ -]?value)?\\s*[=<]", lines, value = TRUE,
                     perl = TRUE, ignore.case = TRUE)
    evidence <- setdiff(evidence, lines[1])
    unique(c(lines[1], if (length(evidence)) evidence[1] else lines[2]))
  }
  recreation_code <- function(m) {
    code <- text_value(m$code_simulate, "\n")
    output_name <- if (grepl("file.path(out_dir", code, fixed = TRUE)) "out_dir" else "output_dir"
    paste0(output_name, ' <- "modules/', m$id, '/generated"\n',
           'dir.create(', output_name, ', recursive = TRUE, showWarnings = FALSE)\n', code)
  }
  relative_path <- function(from, to) {
    a <- strsplit(from, "/", fixed = TRUE)[[1]]
    b <- strsplit(to, "/", fixed = TRUE)[[1]]
    common <- 0L
    while (common < min(length(a), length(b)) && a[common + 1L] == b[common + 1L]) {
      common <- common + 1L
    }
    up <- rep("..", length(a) - common)
    down <- if (common < length(b)) b[(common + 1L):length(b)] else character()
    answer <- paste(c(up, down), collapse = "/")
    if (nzchar(answer)) answer else "."
  }
  course_relative <- relative_path(output_dir, course_dir)
  link_to <- function(id, suffix) {
    prefix <- if (course_relative == ".") "" else paste0(course_relative, "/")
    paste0(prefix, "modules/", id, "/", suffix)
  }
  required_metadata <- c("id", "title", "family", "biology", "design", "question",
                         "null", "seed", "generating_model", "generating_truth",
                         "columns", "teaching_point", "code_simulate", "code_analysis")
  problems <- character()
  modules <- lapply(paths, function(path) {
    m <- jsonlite::fromJSON(path, simplifyVector = FALSE)
    id <- basename(dirname(path))
    missing_fields <- required_metadata[!vapply(required_metadata, function(k) {
      !is.null(m[[k]]) && length(m[[k]]) > 0L && nzchar(text_value(m[[k]]))
    }, logical(1))]
    if (length(missing_fields)) {
      problems <<- c(problems, paste0(id, ": missing metadata: ", paste(missing_fields, collapse = ", ")))
    }
    if (!identical(text_value(m$id), id)) problems <<- c(problems, paste0(id, ": directory and metadata ID differ"))
    files <- file.path(dirname(path), c("generated/data.csv", "generated/results.json",
                                       "generated/plot.png", "analysis.R"))
    missing_files <- files[!file.exists(files)]
    if (length(missing_files)) {
      problems <<- c(problems, paste0(id, ": missing files: ", paste(basename(missing_files), collapse = ", ")))
      return(NULL)
    }
    d <- read.csv(files[1], stringsAsFactors = FALSE, check.names = FALSE)
    result <- jsonlite::fromJSON(files[2], simplifyVector = FALSE)
    if (!nzchar(text_value(result$full_output, "\n"))) {
      problems <<- c(problems, paste0(id, ": results.json is missing full_output"))
    }
    if (!nzchar(text_value(result$report))) problems <<- c(problems, paste0(id, ": results.json is missing report"))
    declared_columns <- vapply(m$columns, function(x) text_value(x$name), character(1))
    if (!identical(names(d), declared_columns)) {
      problems <<- c(problems, paste0(id, ": column dictionary does not match the saved CSV columns"))
    }
    list(meta = m, data = d, results = result, files = files,
         csv = link_to(id, "generated/data.csv"),
         script = link_to(id, "analysis.R"), plot = link_to(id, "generated/plot.png"))
  })
  if (length(problems)) {
    stop("Instructor guide was not built. Finish or repair the following modules:\n- ",
         paste(problems, collapse = "\n- "), call. = FALSE)
  }

  # A stable teaching order, followed by any newly added modules automatically.
  preferred <- c("one_sample_t", "pooled_t", "welch_t", "paired_t", "f_variance",
    "levene", "shapiro", "sign_test", "signed_rank", "rank_sum", "one_way_anova",
    "welch_anova", "kruskal_wallis", "factorial_anova", "ancova", "repeated_anova",
    "friedman", "tukey", "fisher_lsd", "scheffe", "dunn", "pearson", "spearman",
    "simple_lm", "multiple_lm", "theil_sen", "binomial", "one_proportion",
    "two_proportions", "chi_gof", "chi_independence", "fisher_exact", "mcnemar",
    "cochran_q", "logistic", "poisson_exact", "poisson_glm", "quasipoisson",
    "negbin_glm", "multinomial", "ordinal_logistic", "linear_mixed", "binary_glmm",
    "count_glmm", "ordinal_mixed", "binary_gee", "kaplan_meier", "log_rank",
    "stratified_logrank", "cox_ph", "parametric_survival", "shared_frailty",
    "permutation_independent", "permutation_paired", "monte_carlo", "bootstrap",
    "sampling_coverage", "bonferroni", "fdr", "pca", "mds", "lda")
  ids <- vapply(modules, function(x) x$meta$id, character(1))
  ranks <- match(ids, preferred)
  ranks[is.na(ranks)] <- length(preferred) + rank(ids[is.na(ranks)], ties.method = "first")
  modules <- modules[order(ranks)]
  n_modules <- length(modules)
  generated_at <- format(Sys.time(), "%Y-%m-%d %H:%M %Z")
  subtitle <- if (is_subset) {
    paste0("Subset preview: ", n_modules, " of ", length(all_ids), " available modules")
  } else paste0(n_modules, " methods · simulated data · saved analysis results")

  catalogue_rows <- lapply(modules, function(x) {
    m <- x$meta; r <- x$results
    data.frame(id = m$id, method = m$title, family = m$family, scenario = m$biology,
      n_rows = nrow(x$data), seed = text_value(m$seed), design = m$design,
      scientific_question = m$question, null_or_target = m$null,
      generating_model = m$generating_model, generating_truth = m$generating_truth,
      columns = paste(vapply(m$columns, function(z) paste(text_value(z$name), text_value(z$meaning),
                         paste0("[", text_value(z$unit), "]"), sep = ": "), character(1)), collapse = "; "),
      observed_summary = text_value(r$summary, " | "), report = text_value(r$report),
      full_output = text_value(r$full_output, "\n"), teaching_point = m$teaching_point,
      data_csv = x$csv, analysis_script = x$script, plot = x$plot,
      csv_md5 = unname(tools::md5sum(x$files[1])),
      results_md5 = unname(tools::md5sum(x$files[2])), stringsAsFactors = FALSE)
  })
  catalogue <- do.call(rbind, catalogue_rows)
  write.csv(catalogue, file.path(output_dir, "dataset_catalog.csv"), row.names = FALSE, na = "")

  css <- paste0(
    ":root{--ink:#161616;--muted:#626262;--paper:#f2f2f2;--line:#d8d8d8;--teal:#246a73;--rust:#a24f2d;}",
    "*{box-sizing:border-box}html{scroll-behavior:smooth;scroll-padding-top:24px}body{margin:0;background:var(--paper);color:var(--ink);font:16px/1.55 Arial,Helvetica,sans-serif}",
    "a{color:var(--teal);text-underline-offset:3px}a:hover{color:#123e43}button,input,summary{font:inherit}a:focus-visible,input:focus-visible,summary:focus-visible{outline:3px solid #b7663e;outline-offset:3px}",
    ".sidebar{position:fixed;inset:0 auto 0 0;width:272px;background:white;border-right:1px solid var(--line);display:flex;flex-direction:column;z-index:5}.brand{background:#080808;color:white;padding:27px 24px 22px}.brand strong{display:block;font-size:23px;line-height:1.15;margin:9px 0}.eyebrow{text-transform:uppercase;font-size:11px;letter-spacing:.15em;font-weight:bold}.brand .eyebrow{color:#ccc}",
    ".sidebar-tools{padding:16px 18px 10px;border-bottom:1px solid var(--line)}.sidebar-tools label{font-size:12px;font-weight:bold;display:block;margin-bottom:6px}input[type=search]{width:100%;border:1px solid #a5a5a5;border-radius:3px;padding:9px;background:white}.search-status{color:var(--muted);font-size:12px;min-height:20px;margin-top:7px}.sidebar nav{padding:12px 14px 25px;overflow-y:auto}.sidebar nav a{display:block;padding:7px 10px;border-radius:3px;text-decoration:none;color:#292929;font-size:13px;line-height:1.25}.sidebar nav a:hover{background:#eaf2f2}.sidebar nav .static{font-weight:bold}.sidebar ol{list-style:none;padding:0;margin:12px 0 0}.sidebar .number{display:inline-block;width:24px;color:#777;font-size:11px}",
    "main{margin-left:272px;padding:36px 40px 75px;max-width:1740px}.page-band{background:#080808;color:white;padding:31px 36px;margin-bottom:26px}.page-band h1{font-size:clamp(30px,3vw,44px);font-weight:700;line-height:1.12;letter-spacing:-.025em;margin:10px 0 14px}.page-band p{color:#d1d1d1;margin:0}.intro,.index-panel,.notes{background:white;border:1px solid var(--line);padding:25px 30px;margin-bottom:26px}h2{font-size:25px;line-height:1.2;margin:0 0 17px}h3{font-size:17px;line-height:1.3;margin:24px 0 10px}p{margin:0 0 14px}p:last-child{margin-bottom:0}.intro-grid{display:grid;grid-template-columns:1.3fr 1fr;gap:28px}.quiet{color:var(--muted);font-size:14px}.notice{padding:15px 18px;background:#edf4f4;border-left:4px solid var(--teal)}.tag{display:inline-block;font-size:11px;letter-spacing:.07em;text-transform:uppercase;font-weight:bold;color:var(--muted);margin-bottom:8px}.actions{display:flex;flex-wrap:wrap;gap:9px}.actions a{display:inline-block;border:1px solid #aebfc1;padding:6px 10px;border-radius:3px;text-decoration:none;font-size:13px;background:white}.actions a:hover{background:#edf4f4}",
    ".table-wrap{overflow-x:auto}table{border-collapse:collapse;width:100%;font-size:13px}th{text-align:left;font-weight:bold;background:#eee;border-bottom:2px solid #333;padding:10px 12px;vertical-align:bottom}td{padding:12px;border-bottom:1px solid #dedede;vertical-align:top;overflow-wrap:anywhere}.index-table{min-width:970px}.index-table th:first-child{width:18%}.index-table th:nth-child(2){width:22%}.index-table th:nth-child(5){width:22%}.index-table th:nth-child(6){width:22%}.index-table .compact{white-space:nowrap}.index-table .truth{color:#414141}.result-mini{margin-top:5px;color:#555;font-size:12px}.column-table th:first-child{width:21%}.column-table th:last-child{width:20%}.preview-table{font-family:Menlo,Consolas,monospace;font-size:12px}.preview-table th,.preview-table td{padding:8px 10px}",
    ".dataset{background:white;border:1px solid var(--line);margin:32px 0;scroll-margin-top:22px}.dataset-head{background:#0a0a0a;color:white;padding:23px 30px}.dataset-head h2{font-size:29px;margin:6px 0 0}.dataset-head .tag{color:#c8c8c8;margin:0}.dataset-body{padding:26px 30px 30px}.meta-line{display:flex;flex-wrap:wrap;gap:8px 22px;font-size:13px;color:#555;margin-bottom:17px}.scenario{font-size:19px;line-height:1.4;margin:20px 0 22px}.two-col{display:grid;grid-template-columns:1fr 1fr;gap:22px}.box{background:#f5f5f5;border:1px solid #dedede;padding:18px 20px}.box h3{margin:0 0 9px}.box .label{display:block;text-transform:uppercase;font-size:11px;letter-spacing:.08em;font-weight:bold;color:#666;margin-bottom:6px}.null-box{margin-top:15px;padding-top:13px;border-top:1px solid #ccc}.truth-box{border-left:4px solid var(--rust)}.design{padding:17px 0 3px}.result-layout{display:grid;grid-template-columns:minmax(0,1.25fr) minmax(270px,.8fr);gap:24px;align-items:start}.figure{margin:0}.figure img{width:100%;height:auto;display:block;border:1px solid #e0e0e0}.figure figcaption{font-size:12px;color:#666;margin-top:8px}.summary-list{padding-left:20px;margin:0 0 17px}.summary-list li{margin:0 0 8px}.report{padding:17px 20px;background:#edf4f4;border-left:4px solid var(--teal)}.teaching{padding:14px 17px;background:#f8f2ec;margin-top:16px;border-left:4px solid #b7663e}.teaching strong{display:block;font-size:12px;text-transform:uppercase;letter-spacing:.06em;margin-bottom:5px}",
    "details{border:1px solid var(--line);margin-top:14px;background:#fafafa}summary{padding:13px 16px;cursor:pointer;font-size:14px;font-weight:bold}details[open] summary{border-bottom:1px solid var(--line)}.detail-content{padding:17px 19px}pre{background:#f4f4f4;border:1px solid #dedede;padding:16px;overflow-x:auto;font:13px/1.5 Menlo,Consolas,monospace;tab-size:2;margin:0}code{font-family:Menlo,Consolas,monospace;font-size:.93em}.detail-content pre+p{margin-top:12px}.full-output{background:#fff}.back-top{display:inline-block;font-size:12px;margin-top:21px}.footer{font-size:12px;color:#666;margin-top:30px}[hidden]{display:none!important}",
    "@media(max-width:1100px){main{padding:25px 24px 60px}.intro-grid,.two-col{grid-template-columns:1fr}.result-layout{grid-template-columns:1fr}.dataset-head,.dataset-body{padding-left:24px;padding-right:24px}}",
    "@media(max-width:760px){.sidebar{position:relative;width:auto;max-height:360px;border-right:0;border-bottom:1px solid var(--line)}.brand{padding:18px 22px}.brand strong{font-size:22px}.sidebar nav{max-height:160px}.sidebar-tools{padding-top:10px}.sidebar ol{columns:2}main{margin-left:0;padding:20px 13px 40px}.page-band{padding:25px 22px}.intro,.index-panel,.notes{padding:22px}.dataset-head h2{font-size:25px}.dataset-body{padding:22px}.scenario{font-size:17px}.two-col{gap:14px}.index-table{min-width:900px}}",
    "@media print{.sidebar,.back-top{display:none}main{margin:0;padding:0;max-width:none}.page-band,.dataset-head{background:#111!important;color:white!important;print-color-adjust:exact}.dataset{break-before:page}.dataset-head{break-after:avoid}.intro-grid,.two-col,.result-layout{display:block}.box{margin-bottom:12px}.figure{max-width:640px}.table-wrap{overflow:visible}.index-table{min-width:0;font-size:10px}details{display:block}details .detail-content{display:block}pre{white-space:pre-wrap;overflow-wrap:anywhere}.actions{display:none}a{color:#111}.dataset-head h2{font-size:25px}.footer{margin-top:15px}}"
  )
  html <- character()
  add <- function(...) html <<- c(html, paste0(...))
  add('<!doctype html><html lang="en"><head><meta charset="utf-8">',
      '<meta name="viewport" content="width=device-width,initial-scale=1">',
      '<meta name="description" content="Instructor reference for biological simulation models, generating truths, scientific questions, null hypotheses, and saved R analysis results.">',
      '<title>Instructor dataset guide · Experimental Design</title><style>', css, '</style></head><body>')
  add('<aside class="sidebar" aria-label="Guide navigation"><div class="brand"><span class="eyebrow">Experimental Design</span>',
      '<strong>Instructor<br>dataset guide</strong><span class="eyebrow">Course reference</span></div>',
      '<div class="sidebar-tools"><label for="search">Find a method or biological example</label>',
      '<input id="search" type="search" placeholder="Search datasets…" autocomplete="off">',
      '<div class="search-status" id="search-status" aria-live="polite">', n_modules, ' datasets</div></div>',
      '<nav><a class="static" href="#start">Start here</a><a class="static" href="#quick-index">Quick index</a>',
      '<a class="static" href="#reproducibility">Reproducibility notes</a><ol>')
  for (i in seq_along(modules)) {
    m <- modules[[i]]$meta
    search_text <- text_value(c(m$title, m$family, m$biology, m$question, m$null))
    add('<li data-search="', esc(search_text), '"><a href="#dataset-', esc(m$id), '">',
        '<span class="number">', sprintf("%02d", i), '</span>', esc(m$title), '</a></li>')
  }
  add('</ol></nav></aside><main><header class="page-band" id="start"><span class="eyebrow">Simulated dataset bank</span>',
      '<h1>Generating truth, models,<br>and analysis results</h1><p>', esc(subtitle), '</p></header>',
      '<section class="intro"><h2>Start here</h2><div class="intro-grid"><div><p>',
      'Use this guide to choose a biological example, see exactly how it was generated, and connect its scientific question to the null being tested. Every record is simulated.</p>',
      '<p>The quick index links to each method’s CSV, full R script, plot, and saved output. The figures and numerical results come from those module files.</p>',
      '<div class="actions"><a href="dataset_catalog.csv">Download the dataset catalog</a>',
      '<a href="Instructor-dataset-guide.md">Readable Markdown companion</a></div></div>',
      '<div class="notice"><p><strong>Generating truth and sample evidence are different.</strong></p>',
      '<p>A nonzero generating effect can yield a large p-value, and a true null can yield a small one. Read the stated model and truth separately from the observed result.</p>',
      '<p class="quiet">Rows count CSV records. For paired, repeated, clustered, or aggregated data, the design identifies the actual independent unit.</p></div></div></section>',
      '<section class="index-panel" id="quick-index"><h2>Quick index</h2>',
      '<p class="quiet">Rows and column previews are read directly from the saved CSVs. Result summaries are read from the outputs generated by each module’s R script.</p>',
      '<div class="table-wrap"><table class="index-table"><thead><tr><th scope="col">Method</th><th scope="col">Biological scenario</th>',
      '<th scope="col">Rows</th><th scope="col">Seed</th><th scope="col">Generating truth</th><th scope="col">Saved result</th><th scope="col">Data</th></tr></thead><tbody>')
  for (i in seq_along(modules)) {
    x <- modules[[i]]; m <- x$meta; r <- x$results
    search_text <- text_value(c(m$title, m$family, m$biology, m$question, m$null))
    mini <- index_result(r$summary)
    add('<tr data-search="', esc(search_text), '"><td><span class="tag">', sprintf("%02d", i), ' · ', esc(m$family),
        '</span><br><a href="#dataset-', esc(m$id), '"><strong>', esc(m$title), '</strong></a></td>',
        '<td>', esc(m$biology), '</td><td class="compact">', nrow(x$data), '</td><td class="compact">', esc(text_value(m$seed)),
        '</td><td class="truth">', esc(m$generating_truth), '</td><td>',
        paste0('<div class="result-mini">', esc(mini), '</div>', collapse = ""),
        '<div class="result-mini"><a href="#dataset-', esc(m$id), '">Full result ↓</a></div></td>',
        '<td><a href="', esc(x$csv), '">CSV</a></td></tr>')
  }
  add('</tbody></table></div></section>')
  for (i in seq_along(modules)) {
    x <- modules[[i]]; m <- x$meta; r <- x$results
    search_text <- text_value(c(m$title, m$family, m$biology, m$question, m$null))
    analysis_excerpt <- paste0('d <- read.csv("modules/', m$id, '/generated/data.csv")\n', text_value(m$code_analysis, "\n"))
    recreate <- recreation_code(m)
    add('<article class="dataset" id="dataset-', esc(m$id), '" data-search="', esc(search_text), '">',
        '<header class="dataset-head"><span class="tag">Dataset ', sprintf("%02d", i), ' · ', esc(m$family),
        '</span><h2>', esc(m$title), '</h2></header><div class="dataset-body">',
        '<div class="meta-line"><span><strong>CSV rows:</strong> ', nrow(x$data), '</span><span><strong>Seed:</strong> ',
        esc(text_value(m$seed)), '</span><span><strong>Module:</strong> <code>', esc(m$id), '</code></span></div>',
        '<div class="actions"><a href="', esc(x$csv), '">Saved CSV</a><a href="', esc(x$script), '">Full runnable R script</a>',
        '<a href="', esc(x$plot), '">Full-size plot</a></div><p class="scenario">', esc(m$biology), '</p>',
        '<div class="two-col"><section class="box"><h3>Question and null</h3><span class="label">Scientific question</span><p>',
        esc(m$question), '</p><div class="null-box"><span class="label">Null being tested / estimation target</span><p>',
        esc(m$null), '</p></div></section><section class="box truth-box"><h3>Generating truth</h3><p>',
        esc(m$generating_truth), '</p><span class="label">Exact generating model</span><p>', esc(m$generating_model),
        '</p></section></div><p class="design"><strong>Design and independent unit:</strong> ', esc(m$design), '</p>',
        '<h3>Columns in the saved CSV</h3><div class="table-wrap"><table class="column-table"><thead><tr>',
        '<th scope="col">Column</th><th scope="col">Meaning</th><th scope="col">Unit / type</th></tr></thead><tbody>')
    for (column in m$columns) {
      add('<tr><td><code>', esc(text_value(column$name)), '</code></td><td>', esc(text_value(column$meaning)),
          '</td><td>', esc(text_value(column$unit)), '</td></tr>')
    }
    add('</tbody></table></div><details><summary>Preview the actual saved observations</summary><div class="detail-content table-wrap">',
        '<table class="preview-table"><thead><tr>', paste0('<th scope="col">', esc(names(x$data)), '</th>', collapse = ""), '</tr></thead><tbody>')
    preview <- head(x$data, 5)
    for (row in seq_len(nrow(preview))) {
      values <- vapply(preview[row, , drop = FALSE], function(v) {
        if (is.na(v[1])) "NA" else as.character(v[1])
      }, character(1))
      add('<tr>', paste0('<td>', esc(values), '</td>', collapse = ""), '</tr>')
    }
    add('</tbody></table></div></details><h3>Analysis from the saved dataset</h3><div class="result-layout">',
        '<figure class="figure"><img src="', esc(x$plot), '" alt="', esc(paste(m$title, "plot.", m$biology)),
        '" loading="lazy" width="1600" height="1000"><figcaption>Simulated observations; generated by this module’s R script.</figcaption></figure>',
        '<div><ul class="summary-list">', paste0('<li>', esc(unlist(r$summary, use.names = FALSE)), '</li>', collapse = ""),
        '</ul><div class="report">', esc(text_value(r$report)), '</div><div class="teaching"><strong>Teaching point</strong>',
        esc(m$teaching_point), '</div></div></div>',
        '<details><summary>Analysis code excerpt</summary><div class="detail-content"><pre><code class="language-r">',
        esc(analysis_excerpt), '</code></pre><p class="quiet">The teaching excerpt uses paths relative to the course folder. The full script supplies package loading and any additional preparation.</p></div></details>',
        '<details><summary>Full printed R output</summary><div class="detail-content"><pre class="full-output"><code>',
        esc(text_value(r$full_output, "\n")), '</code></pre></div></details>',
        '<details><summary>Recreate the observations</summary><div class="detail-content"><p class="quiet">The fixed seed and simulation excerpt are shown below. Run the complete script to regenerate the CSV, figure, and results together.</p>',
        '<pre><code class="language-r">', esc(recreate), '</code></pre><p><strong>Run the complete module from the course folder:</strong></p><pre><code>',
        esc(paste("Rscript", paste0("modules/", m$id, "/analysis.R"), paste0("modules/", m$id, "/generated"))),
        '</code></pre></div></details><a class="back-top" href="#quick-index">↑ Back to the quick index</a></div></article>')
  }
  add('<section class="notes" id="reproducibility"><h2>Reproducibility notes</h2>',
      '<p>Each module owns its fixed seed, simulation, CSV, plot, and analysis output. Identifiers are local to a dataset; repeated IDs in different files do not imply shared organisms.</p>',
      '<p>The model descriptions state any rounding, dependence, censoring, or deliberate unusual observations. The column dictionary and design identify how each record should be interpreted.</p>',
      '<p>This guide reads saved CSVs and result files; it does not resimulate or refit analyses. Run the course builder or the relevant module scripts first after changing a model, then regenerate this guide.</p>',
      '<p>Run <code>source("build_instructor_guide.R")</code> followed by <code>build_instructor_guide(".")</code> from the course folder, or knit <code>Instructor-dataset-guide.Rmd</code> in RStudio. Missing module outputs cause a build error rather than an incomplete guide.</p>',
      '<p>The catalog records the generating model, truth, observed result, file links, and checksums of the CSV and result files used for this build.</p></section>',
      '<footer class="footer">Built ', esc(generated_at), ' from ', n_modules, ' saved module datasets. ',
      if (is_subset) 'This is an explicitly selected subset preview.' else 'All discovered modules are included.',
      ' All records are simulated.</footer></main>')
  add('<script>(function(){const field=document.getElementById("search"),status=document.getElementById("search-status");',
      'const items=Array.from(document.querySelectorAll("[data-search]"));const cards=Array.from(document.querySelectorAll("article.dataset"));',
      'field.addEventListener("input",function(){const q=this.value.trim().toLocaleLowerCase();items.forEach(function(el){el.hidden=q!==""&&!el.dataset.search.toLocaleLowerCase().includes(q)});',
      'const visible=cards.filter(function(el){return !el.hidden}).length;status.textContent=visible+" of "+cards.length+" datasets";});',
      'document.querySelectorAll("a[href^=\\\"#dataset-\\\"]").forEach(function(a){a.addEventListener("click",function(){const el=document.getElementById(this.hash.slice(1));if(el)el.hidden=false;});});',
      '})();</script></body></html>')
  writeLines(html, file.path(output_dir, "Instructor-dataset-guide.html"), useBytes = TRUE)

  markdown <- c("# Instructor dataset guide", "", "## Generating truth, models, and analysis results", "", subtitle, "",
    "All records are simulated. Generating truth is stated from the model, independently of the sample p-value. A true effect can yield a large p-value; a true null can yield a small one.", "",
    "CSV rows are not automatically the independent sample size. Use each dataset's design to identify pairing, repeated observations, clustering, or aggregation.", "",
    "[Dataset catalog](dataset_catalog.csv)", "", "## Quick index", "",
    "| Method | Biological scenario | Rows | Seed | Generating truth | Saved result | CSV |",
    "|---|---|---:|---:|---|---|---|")
  for (i in seq_along(modules)) {
    x <- modules[[i]]; m <- x$meta
    markdown <- c(markdown, paste0("| [", md_cell(m$title), "](#dataset-", m$id, ") | ", md_cell(m$biology), " | ",
      nrow(x$data), " | ", text_value(m$seed), " | ", md_cell(m$generating_truth), " | ",
      md_cell(index_result(x$results$summary)), " | [CSV](", x$csv, ") |"))
  }
  for (i in seq_along(modules)) {
    x <- modules[[i]]; m <- x$meta; r <- x$results
    markdown <- c(markdown, "", paste0('<a id="dataset-', m$id, '"></a>'), "",
      paste0("## Dataset ", sprintf("%02d", i), ": ", m$title), "", m$biology, "",
      paste0("**Family:** ", m$family, " · **Rows:** ", nrow(x$data), " · **Seed:** ", text_value(m$seed)), "",
      paste0("[Saved CSV](", x$csv, ") · [Full runnable R script](", x$script, ") · [Full-size plot](", x$plot, ")"), "",
      paste0("**Generating truth:** ", m$generating_truth), "", paste0("**Exact generating model:** ", m$generating_model), "",
      paste0("**Scientific question:** ", m$question), "", paste0("**Null being tested / estimation target:** ", m$null), "",
      paste0("**Design and independent unit:** ", m$design), "", "### Columns", "",
      "| Column | Meaning | Unit / type |", "|---|---|---|")
    for (column in m$columns) markdown <- c(markdown, paste0("| ", md_cell(column$name), " | ", md_cell(column$meaning), " | ", md_cell(column$unit), " |"))
    markdown <- c(markdown, "", "### Analysis from the saved dataset", "",
      paste0("![", m$title, " plot. ", m$biology, "](", x$plot, ")"), "",
      paste0("- ", unlist(r$summary, use.names = FALSE)), "", text_value(r$report), "",
      paste0("**Teaching point:** ", m$teaching_point), "", "### Analysis code excerpt", "", "```r",
      paste0('d <- read.csv("modules/', m$id, '/generated/data.csv")'), text_value(m$code_analysis, "\n"), "```", "",
      "The full script supplies package loading and any additional preparation.", "", "### Full printed R output", "", "```text",
      text_value(r$full_output, "\n"), "```", "", "### Recreate the observations", "", "```r",
      recreation_code(m), "```", "", "Run the complete module from the course folder:", "", "```sh",
      paste("Rscript", paste0("modules/", m$id, "/analysis.R"), paste0("modules/", m$id, "/generated")), "```", "")
  }
  markdown <- c(markdown, "## Reproducibility notes", "",
    "Each module owns its fixed seed, simulation, saved CSV, plot, and actual analysis output. Identifiers are local to the module. Generating-model descriptions state rounding, dependence, censoring, or deliberate unusual observations.", "",
    "The guide reads saved data and result files without rerunning simulations or analyses. Run the course builder or changed module scripts before refreshing the guide. The catalog includes file checksums for this build.", "",
    "```r", 'source("build_instructor_guide.R")', 'build_instructor_guide(".")', "```", "",
    paste0("Built ", generated_at, " from ", n_modules, " saved module datasets. ",
           if (is_subset) "This is a selected subset preview." else "All discovered modules are included."))
  writeLines(markdown, file.path(output_dir, "Instructor-dataset-guide.md"), useBytes = TRUE)
  answer <- list(modules = vapply(modules, function(x) x$meta$id, character(1)),
                 count = n_modules, subset_preview = is_subset,
                 html = file.path(output_dir, "Instructor-dataset-guide.html"),
                 markdown = file.path(output_dir, "Instructor-dataset-guide.md"),
                 catalog = file.path(output_dir, "dataset_catalog.csv"))
  message("Built instructor guide for ", n_modules, " modules", if (is_subset) " (subset preview)" else "", ".")
  invisible(answer)
}

if (sys.nframe() == 0L) {
  args <- commandArgs(trailingOnly = TRUE)
  if (!length(args)) stop("Usage: Rscript build_instructor_guide.R /absolute/path/to/course [output_dir]")
  build_instructor_guide(args[1], if (length(args) >= 2) args[2] else args[1])
}
