# Run: Rscript analysis.R /absolute/output/folder
args <- commandArgs(trailingOnly = TRUE)
output_dir <- if (length(args)) args[1] else "."
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

# Simulate and save before analysis.
set.seed(1108)
insect <- rep(1:18, each = 3)
condition <- rep(c("Dim", "Moderate", "Bright"), 18)
score <- pmax(0, pmin(10, round(rep(rnorm(18, 5, 1.3), each = 3) +
             rep(c(0, .8, 1.6), 18) + rnorm(54, 0, 1))))
d <- data.frame(insect, condition, activity_score = score)
write.csv(d, file.path(output_dir, "data.csv"), row.names = FALSE)
d <- read.csv(file.path(output_dir, "data.csv"))
# Analysis
d$condition <- factor(d$condition, levels = c("Dim", "Moderate", "Bright"))
d$insect <- factor(d$insect)
fit <- friedman.test(activity_score ~ condition | insect, data = d)

# Primary figure
ragg::agg_png(file.path(output_dir, "plot.png"), width = 1600, height = 1000, res = 170)
par(mar = c(5, 5, 2, 1), las = 1, bty = "l", cex = 1.15)
wide <- xtabs(activity_score ~ insect + condition, data = d)
matplot(1:3, t(wide), type = "b", pch = 19, lty = 1, col = "#246A7338",
        xaxt = "n", xlab = "Light condition", ylab = "Activity score")
axis(1, 1:3, levels(d$condition))
points(1:3, apply(wide, 2, median), type = "b", pch = 18,
       col = "#B7663E", lwd = 3, cex = 1.6)
legend("topleft", "Condition median", pch = 18, col = "#B7663E", bty = "n")
dev.off()

# Results are computed from the saved dataset.
summary_lines <- c(sprintf("Independent blocks = %d; conditions = %d", nrow(wide), ncol(wide)),
 sprintf("Friedman chi-square = %.2f; df = %.0f; p = %.4g", fit$statistic, fit$parameter, fit$p.value),
 paste("Condition medians:", paste(colnames(wide), apply(wide, 2, median), collapse = "; ")))
report <- sprintf("For %d insects measured under all three conditions, the Friedman comparison gave chi-square(%.0f) = %.2f, p = %.4g. This tests a systematic condition effect within insects; it does not identify which conditions differ.", nrow(wide), fit$parameter, fit$statistic, fit$p.value)
preview <- head(capture.output(print(head(d, 4), row.names = FALSE)), 5)
full_output <- paste(capture.output(print(fit)), collapse = "\n")
jsonlite::write_json(list(preview = preview, summary = summary_lines, report = report, full_output = full_output),
 file.path(output_dir, "results.json"), auto_unbox = TRUE, pretty = TRUE, digits = 8)
cat(report, "\n")
