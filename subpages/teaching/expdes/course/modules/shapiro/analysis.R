# Run: Rscript analysis.R /absolute/output/folder
args <- commandArgs(trailingOnly = TRUE)
output_dir <- if (length(args)) args[1] else "."
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

# Simulate and save before analysis.
set.seed(1111)
d <- data.frame(culture = 1:36,
                lysis_minutes = rlnorm(36, log(45), .5))
write.csv(d, file.path(output_dir, "data.csv"), row.names = FALSE)
d <- read.csv(file.path(output_dir, "data.csv"))

# Analysis
fit <- shapiro.test(d$lysis_minutes)

# Primary figure
ragg::agg_png(file.path(output_dir, "plot.png"), width = 1600, height = 1000, res = 170)
par(mar = c(5, 5, 2, 1), las = 1, bty = "l", cex = 1.15)
qqnorm(d$lysis_minutes, pch = 21, bg = "#246A73", col = "white",
       main = "", xlab = "Theoretical normal quantiles", ylab = "Lysis time (minutes)")
qqline(d$lysis_minutes, col = "#B7663E", lwd = 2)
dev.off()

# Results are computed from the saved dataset.
summary_lines <- c(sprintf("Shapiro–Wilk W = %.3f; p = %.4g; n = %d", fit$statistic, fit$p.value, nrow(d)),
 "Curvature in the Q–Q plot indicates a shape mismatch.",
 "A nonsignificant result would not establish normality.")
report <- sprintf("For the %d lysis times, Shapiro–Wilk W = %.3f, p = %.4g. Use the Q–Q plot to understand the mismatch; this diagnostic alone does not choose the scientific test or show that a mean comparison is invalid.", nrow(d), fit$statistic, fit$p.value)
preview <- head(capture.output(print(head(d, 4), row.names = FALSE)), 5)
full_output <- paste(capture.output(print(fit)), collapse = "\n")
jsonlite::write_json(list(preview = preview, summary = summary_lines, report = report, full_output = full_output),
 file.path(output_dir, "results.json"), auto_unbox = TRUE, pretty = TRUE, digits = 8)
cat(report, "\n")
