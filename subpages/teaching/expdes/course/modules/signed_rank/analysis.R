# Run: Rscript analysis.R /absolute/output/folder
args <- commandArgs(trailingOnly = TRUE)
output_dir <- if (length(args)) args[1] else "."
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
library(beeswarm)

# Simulate and save before analysis.
set.seed(1105)
before <- rnorm(28, 6, .4)
after <- before + .28 + .28 * rt(28, df = 4)
d <- data.frame(culture = 1:28, before = before, after = after)
write.csv(d, file.path(output_dir, "data.csv"), row.names = FALSE)
d <- read.csv(file.path(output_dir, "data.csv"))

# Analysis
change <- d$after - d$before
fit <- wilcox.test(d$after, d$before, paired = TRUE,
                   exact = FALSE, conf.int = TRUE)

# Primary figure
ragg::agg_png(file.path(output_dir, "plot.png"), width = 1600, height = 1000, res = 170)
par(mar = c(5, 5, 2, 1), las = 1, bty = "l", cex = 1.15)
beeswarm(change, horizontal = TRUE, pch = 21, bg = "#73649A",
         col = "white", cex = 1.5, yaxt = "n", ylab = "",
         xlab = "After - before: log10 bacterial density (CFU/mL)")
abline(v = 0, lty = 2, col = "#B7663E", lwd = 2)
dev.off()

# Results are computed from the saved dataset.
summary_lines <- c(sprintf("Pseudomedian change estimate = %.3f", fit$estimate),
 sprintf("95%% CI: %.3f to %.3f", fit$conf.int[1], fit$conf.int[2]),
 sprintf("V = %.1f; p = %.4g", fit$statistic, fit$p.value))
report <- sprintf("The estimated pseudomedian log10 density change was %.3f (95%% CI %.3f to %.3f); signed-rank V = %.1f, p = %.4g. Under a symmetric location-shift model this describes the common center of the differences; the procedure does not generally test a mean.", fit$estimate, fit$conf.int[1], fit$conf.int[2], fit$statistic, fit$p.value)
preview <- head(capture.output(print(head(d, 4), row.names = FALSE)), 5)
full_output <- paste(capture.output(print(fit)), collapse = "\n")
jsonlite::write_json(list(preview = preview, summary = summary_lines, report = report, full_output = full_output),
 file.path(output_dir, "results.json"), auto_unbox = TRUE, pretty = TRUE, digits = 8)
cat(report, "\n")
