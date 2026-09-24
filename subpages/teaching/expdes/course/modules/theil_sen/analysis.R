# Run: Rscript analysis.R /absolute/output/folder
args <- commandArgs(trailingOnly = TRUE)
output_dir <- if (length(args)) args[1] else "."
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

# Simulate and save before analysis.
set.seed(1116)
temperature <- runif(40, 16, 30)
activity <- 8 + 1.4 * temperature + rt(40, df = 4) * 2
activity[c(5, 18)] <- activity[c(5, 18)] + 25
d <- data.frame(assay = 1:40, temp_c = temperature, activity = activity)
write.csv(d, file.path(output_dir, "data.csv"), row.names = FALSE)
d <- read.csv(file.path(output_dir, "data.csv"))

# Analysis
pairs <- combn(seq_len(nrow(d)), 2)
slopes <- (d$activity[pairs[2, ]] - d$activity[pairs[1, ]]) /
          (d$temp_c[pairs[2, ]] - d$temp_c[pairs[1, ]])
slope <- median(slopes)
intercept <- median(d$activity - slope * d$temp_c)
# Resample whole (temperature, activity) pairs; keep the same estimand.
boot_slopes <- numeric(999)
for (b in 1:999) {
  rows <- sample(seq_len(nrow(d)), replace = TRUE)
  boot <- d[rows, ]
  dx <- boot$temp_c[pairs[2, ]] - boot$temp_c[pairs[1, ]]
  dy <- boot$activity[pairs[2, ]] - boot$activity[pairs[1, ]]
  boot_slopes[b] <- median(dy[dx != 0] / dx[dx != 0])
}
ci <- quantile(boot_slopes, c(.025, .975))

# Primary figure
ragg::agg_png(file.path(output_dir, "plot.png"), width = 1600, height = 1000, res = 170)
par(mar = c(5, 5, 2, 1), las = 1, bty = "l", cex = 1.15)
plot(d$temp_c, d$activity, pch = 21, bg = "#246A73", col = "white", cex = 1.4,
     xlab = "Assay temperature (degrees C)", ylab = "Enzyme activity (U/mL)")
abline(intercept, slope, col = "#B7663E", lwd = 3)
legend("topleft", "Theil–Sen fitted trend", lty = 1, lwd = 3,
       col = "#B7663E", bty = "n")
dev.off()

# Results are computed from the saved dataset.
summary_lines <- c(sprintf("Theil–Sen slope = %.3f U/mL per degree C", slope),
 sprintf("95%% pairs-bootstrap interval: %.3f to %.3f", ci[1], ci[2]),
 sprintf("Finite original pairwise slopes = %d; bootstrap replicates = %d", length(slopes), length(boot_slopes)),
 "The interval is approximate; no exact test p-value is reported.")
report <- sprintf("The robust slope was %.3f U/mL per degree C, with a 95%% percentile pairs-bootstrap interval of %.3f to %.3f (999 replicates). This estimates a linear location trend resistant to extreme responses; its interval is approximate and is not an exact slope test.", slope, ci[1], ci[2])
preview <- head(capture.output(print(head(d, 4), row.names = FALSE)), 5)
full_output <- paste(capture.output({ print(c(intercept = intercept, slope = slope)); print(ci); print(length(boot_slopes)) }), collapse = "\n")
jsonlite::write_json(list(preview = preview, summary = summary_lines, report = report, full_output = full_output),
 file.path(output_dir, "results.json"), auto_unbox = TRUE, pretty = TRUE, digits = 8)
cat(report, "\n")
