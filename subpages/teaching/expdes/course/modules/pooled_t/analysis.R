# Run: Rscript analysis.R /absolute/output/folder
args <- commandArgs(trailingOnly = TRUE)
output_dir <- if (length(args)) args[1] else "."
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
library(beeswarm)

# Simulate and save before analysis.
set.seed(1118)
d <- data.frame(environment = rep(c("Cool", "Warm"), c(26, 30)),
                length_mm = c(rnorm(26, 10, .65), rnorm(30, 10.7, .65)))
write.csv(d, file.path(output_dir, "data.csv"), row.names = FALSE)
d <- read.csv(file.path(output_dir, "data.csv"))
# Analysis
d$environment <- factor(d$environment, levels = c("Cool", "Warm"))
fit <- t.test(length_mm ~ environment, data = d,
              var.equal = TRUE, conf.level = .95)
difference <- mean(d$length_mm[d$environment == "Cool"]) -
              mean(d$length_mm[d$environment == "Warm"])

# Primary figure
ragg::agg_png(file.path(output_dir, "plot.png"), width = 1600, height = 1000, res = 170)
par(mar = c(5, 5, 2, 1), las = 1, bty = "l", cex = 1.15)
beeswarm(length_mm ~ environment, data = d, pch = 21,
         bg = c("#246A73", "#B7663E"), col = "white", cex = 1.3,
         xlab = "Rearing environment", ylab = "Adult body length (mm)")
points(1:2, tapply(d$length_mm, d$environment, mean), pch = 18, cex = 2)
legend("topleft", "Group mean", pch = 18, bty = "n")
dev.off()

# Results are computed from the saved dataset.
summary_lines <- c(sprintf("Cool - Warm mean difference = %.2f mm", difference),
 sprintf("95%% CI: %.2f to %.2f mm", fit$conf.int[1], fit$conf.int[2]),
 sprintf("Pooled t = %.2f; df = %.2f; p = %.4g", fit$statistic, fit$parameter, fit$p.value))
report <- sprintf("Mean body length differed by %.2f mm (Cool minus Warm; 95%% CI %.2f to %.2f). Pooled t = %.2f, df = %.2f, p = %.4g. This analysis assumes equal population variances. Welch tests the same null without that assumption.", difference, fit$conf.int[1], fit$conf.int[2], fit$statistic, fit$parameter, fit$p.value)
preview <- head(capture.output(print(head(d, 4), row.names = FALSE)), 5)
full_output <- paste(capture.output(print(fit)), collapse = "\n")
jsonlite::write_json(list(preview = preview, summary = summary_lines, report = report, full_output = full_output),
 file.path(output_dir, "results.json"), auto_unbox = TRUE, pretty = TRUE, digits = 8)
cat(report, "\n")
