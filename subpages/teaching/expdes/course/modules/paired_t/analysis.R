# Run: Rscript analysis.R /absolute/output/folder
args <- commandArgs(trailingOnly = TRUE)
output_dir <- if (length(args)) args[1] else "."
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

# Simulate and save before analysis.
set.seed(1103)
before <- rnorm(20, 18, 2.2)
after <- before + rnorm(20, -1.3, 1.7)
d <- data.frame(plant = 1:20, before = before, after = after)
write.csv(d, file.path(output_dir, "data.csv"), row.names = FALSE)
d <- read.csv(file.path(output_dir, "data.csv"))

# Analysis
change <- d$after - d$before
fit <- t.test(d$after, d$before, paired = TRUE,
              alternative = "two.sided")

# Primary figure
ragg::agg_png(file.path(output_dir, "plot.png"), width = 1600, height = 1000, res = 170)
par(mar = c(5, 5, 2, 1), las = 1, bty = "l", cex = 1.15)
matplot(1:2, t(as.matrix(d[c("before", "after")])), type = "l",
        lty = 1, col = "#00000033", xaxt = "n", xlab = "",
        ylab = expression(Photosynthesis~(mu*mol~CO[2]~m^{-2}~s^{-1})))
axis(1, 1:2, c("Before heat", "After heat"))
points(rep(1, nrow(d)), d$before, pch = 19, col = "#246A73")
points(rep(2, nrow(d)), d$after, pch = 19, col = "#B7663E")
dev.off()

# Results are computed from the saved dataset.
summary_lines <- c(sprintf("Mean change (after - before) = %.2f", mean(change)),
 sprintf("95%% CI for mean change: %.2f to %.2f", fit$conf.int[1], fit$conf.int[2]),
 sprintf("Paired t = %.2f; df = %.0f; p = %.4g", fit$statistic, fit$parameter, fit$p.value))
report <- sprintf("Photosynthesis changed by a mean of %.2f units after heat stress (95%% CI %.2f to %.2f); paired t(%.0f) = %.2f, p = %.4g. Pairing makes the biological unit the plant and the analyzed response its change.", mean(change), fit$conf.int[1], fit$conf.int[2], fit$parameter, fit$statistic, fit$p.value)
preview <- head(capture.output(print(head(d, 4), row.names = FALSE)), 5)
full_output <- paste(capture.output(print(fit)), collapse = "\n")
jsonlite::write_json(list(preview = preview, summary = summary_lines, report = report, full_output = full_output),
 file.path(output_dir, "results.json"), auto_unbox = TRUE, pretty = TRUE, digits = 8)
cat(report, "\n")
