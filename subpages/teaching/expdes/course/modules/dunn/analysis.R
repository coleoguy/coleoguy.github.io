# Run: Rscript analysis.R /absolute/output/folder
args <- commandArgs(trailingOnly = TRUE)
output_dir <- if (length(args)) args[1] else "."
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

# Simulate and save before analysis.
set.seed(2105)
d <- data.frame(leaf = 1:84,
                treatment = rep(c("A", "B", "C", "D"), each = 21))
d$damage <- rlnorm(84, rep(c(1.2, 1.3, 1.7, 1.9), each = 21), .48)
write.csv(d, file.path(output_dir, "data.csv"), row.names = FALSE)
d <- read.csv(file.path(output_dir, "data.csv"))
d$treatment <- factor(d$treatment)
# Analysis
overall <- kruskal.test(damage ~ treatment, data = d)
comparisons <- dunn.test::dunn.test(d$damage, d$treatment,
  method = "holm", altp = TRUE, kw = FALSE, list = FALSE)

# Primary figure
ragg::agg_png(file.path(output_dir, "plot.png"), width = 1600, height = 1000, res = 160, background = "white")
par(mar = c(5, 5, 2, 1), las = 1, bty = "l", cex = 1.15)
beeswarm::beeswarm(damage ~ treatment, data = d,
  pch = 21, bg = c("#246A73", "#73969B", "#D7A583", "#B7663E"),
  col = "white", cex = 1.25, xlab = "Treatment",
  ylab = "Leaf area removed (mm²)")
points(1:4, tapply(d$damage, d$treatment, median),
       pch = 18, cex = 2, col = "#172D34")
legend("topleft", "Diamonds = sample medians", pch = 18, bty = "n")
dev.off()

# Results computed from the saved data.
i <- which.min(comparisons$altP.adjusted)
summary_lines <- c(sprintf("Kruskal–Wallis p = %.4g", overall$p.value),
 sprintf("Highlighted pair: %s", comparisons$comparisons[i]),
 sprintf("Dunn z = %.2f", comparisons$Z[i]),
 sprintf("Two-sided Holm-adjusted p = %.4g", comparisons$altP.adjusted[i]))
report <- sprintf("Across the six rank comparisons, the highlighted %s comparison had Dunn z = %.2f and two-sided Holm-adjusted p = %.4g. This compares pooled rank tendencies; with unequal distribution shapes, it is not simply a test of equal medians. The smallest adjusted p-value is highlighted after protecting the full six-pair family.", comparisons$comparisons[i], comparisons$Z[i], comparisons$altP.adjusted[i])
full_output <- paste(capture.output({
  if (exists("fit", inherits = FALSE)) print(summary(fit))
  if (exists("test", inherits = FALSE)) print(test)
  if (exists("overall", inherits = FALSE)) print(overall)
  if (exists("comparisons", inherits = FALSE)) print(comparisons)
  if (exists("comparison", inherits = FALSE)) print(comparison)
  if (exists("ph_check", inherits = FALSE)) print(ph_check)
  if (exists("poisson_fit", inherits = FALSE)) print(summary(poisson_fit))
}), collapse = "\n")

preview <- head(capture.output(print(head(d, 4), row.names = FALSE)), 5)
jsonlite::write_json(list(preview = preview, summary = summary_lines,
                         report = report, full_output = full_output),
  file.path(output_dir, "results.json"), auto_unbox = TRUE,
  pretty = TRUE, digits = 8)
cat(report, "\n")
