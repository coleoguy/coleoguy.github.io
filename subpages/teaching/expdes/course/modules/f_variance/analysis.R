# Run: Rscript analysis.R /absolute/output/folder
args <- commandArgs(trailingOnly = TRUE)
output_dir <- if (length(args)) args[1] else "."
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
library(beeswarm)

# Simulate and save before analysis.
set.seed(1109)
d <- data.frame(line = rep(c("Line A", "Line B"), each = 30),
                wing_mm = c(rnorm(30, 2.6, .11), rnorm(30, 2.6, .21)))
write.csv(d, file.path(output_dir, "data.csv"), row.names = FALSE)
d <- read.csv(file.path(output_dir, "data.csv"))
# Analysis
d$line <- factor(d$line, levels = c("Line A", "Line B"))
fit <- var.test(wing_mm ~ line, data = d, ratio = 1,
                alternative = "two.sided", conf.level = .95)

# Primary figure
ragg::agg_png(file.path(output_dir, "plot.png"), width = 1600, height = 1000, res = 170)
par(mar = c(5, 5, 2, 1), las = 1, bty = "l", cex = 1.15)
beeswarm(wing_mm ~ line, data = d, pch = 21,
         bg = c("#246A73", "#B7663E"), col = "white", cex = 1.3,
         xlab = "Fly line", ylab = "Wing length (mm)")
dev.off()

# Results are computed from the saved dataset.
summary_lines <- c(sprintf("Variance ratio (A / B) = %.3f", fit$estimate),
 sprintf("95%% CI for variance ratio: %.3f to %.3f", fit$conf.int[1], fit$conf.int[2]),
 sprintf("F = %.3f; df = %d, %d; p = %.4g", fit$statistic, fit$parameter[1], fit$parameter[2], fit$p.value))
report <- sprintf("Wing-length variance in Line A was %.3f times that in Line B (95%% CI %.3f to %.3f); F(%d, %d) = %.3f, p = %.4g. The target is variability, and this exact F reference relies strongly on normal populations.", fit$estimate, fit$conf.int[1], fit$conf.int[2], fit$parameter[1], fit$parameter[2], fit$statistic, fit$p.value)
preview <- head(capture.output(print(head(d, 4), row.names = FALSE)), 5)
full_output <- paste(capture.output(print(fit)), collapse = "\n")
jsonlite::write_json(list(preview = preview, summary = summary_lines, report = report, full_output = full_output),
 file.path(output_dir, "results.json"), auto_unbox = TRUE, pretty = TRUE, digits = 8)
cat(report, "\n")
