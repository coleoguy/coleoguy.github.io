# Run: Rscript analysis.R /absolute/output/folder
args <- commandArgs(trailingOnly = TRUE)
output_dir <- if (length(args)) args[1] else "."
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
library(beeswarm)

# Simulate and save before analysis.
set.seed(1101)
d <- data.frame(culture = 1:24,
                oxygen = rnorm(24, mean = 10.8, sd = 1.5))
write.csv(d, file.path(output_dir, "data.csv"), row.names = FALSE)
d <- read.csv(file.path(output_dir, "data.csv"))

# Analysis
fit <- t.test(d$oxygen, mu = 10,
              alternative = "two.sided", conf.level = .95)

# Primary figure
ragg::agg_png(file.path(output_dir, "plot.png"), width = 1600, height = 1000, res = 170)
par(mar = c(5, 5, 2, 1), las = 1, bty = "l", cex = 1.15)
beeswarm(d$oxygen, horizontal = TRUE, method = "swarm",
         pch = 21, bg = "#246A73", col = "white", cex = 1.6,
         xlab = "Oxygen consumption (nmol/min)", ylab = "", yaxt = "n")
abline(v = 10, lty = 2, col = "#B7663E", lwd = 2)
legend("topleft", "Reference mean = 10", lty = 2,
       col = "#B7663E", bty = "n")
dev.off()

# Results are computed from the saved dataset.
summary_lines <- c(sprintf("Mean = %.2f nmol/min; n = %d", mean(d$oxygen), nrow(d)),
 sprintf("95%% CI for mean: %.2f to %.2f", fit$conf.int[1], fit$conf.int[2]),
 sprintf("t = %.2f; df = %.0f; p = %.4g", fit$statistic, fit$parameter, fit$p.value))
report <- sprintf("Mean oxygen consumption was %.2f nmol/min (95%% CI %.2f to %.2f); against the reference mean of 10, t(%.0f) = %.2f, p = %.4g. This tests a population mean, not whether every culture exceeds 10.", mean(d$oxygen), fit$conf.int[1], fit$conf.int[2], fit$parameter, fit$statistic, fit$p.value)
preview <- head(capture.output(print(head(d, 4), row.names = FALSE)), 5)
full_output <- paste(capture.output(print(fit)), collapse = "\n")
jsonlite::write_json(list(preview = preview, summary = summary_lines, report = report, full_output = full_output),
 file.path(output_dir, "results.json"), auto_unbox = TRUE, pretty = TRUE, digits = 8)
cat(report, "\n")
