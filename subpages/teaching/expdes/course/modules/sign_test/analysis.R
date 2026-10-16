# Run: Rscript analysis.R /absolute/output/folder
args <- commandArgs(trailingOnly = TRUE)
output_dir <- if (length(args)) args[1] else "."
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

# Simulate and save before analysis.
set.seed(1104)
change <- rgamma(30, shape = 1.4, scale = 5) - 3
d <- data.frame(fish = 1:30, change_seconds = round(change, 1))
write.csv(d, file.path(output_dir, "data.csv"), row.names = FALSE)
d <- read.csv(file.path(output_dir, "data.csv"))

# Analysis
nonzero <- d$change_seconds[d$change_seconds != 0]
positive <- sum(nonzero > 0)
fit <- binom.test(positive, length(nonzero), p = .5,
                 alternative = "two.sided")

# Primary figure
ragg::agg_png(file.path(output_dir, "plot.png"), width = 1600, height = 1000, res = 170)
par(mar = c(5, 5, 2, 1), las = 1, bty = "l", cex = 1.15)
values <- sort(d$change_seconds)
cols <- ifelse(values > 0, "#246A73", "#B7663E")
plot(seq_along(values), values, type = "n", xlab = "Fish ordered by change",
     ylab = "Change in refuge-use time (seconds)")
abline(h = 0, col = "gray55", lty = 2)
segments(seq_along(values), 0, seq_along(values), values, col = cols, lwd = 2)
points(seq_along(values), values, pch = 19, col = cols)
dev.off()

# Results are computed from the saved dataset.
summary_lines <- c(sprintf("Positive changes: %d of %d nonzero differences", positive, length(nonzero)),
 sprintf("Zero changes excluded: %d", sum(d$change_seconds == 0)),
 sprintf("Median observed change = %.2f seconds", median(d$change_seconds)),
 sprintf("95%% CI for positive-change probability: %.2f to %.2f", fit$conf.int[1], fit$conf.int[2]),
 sprintf("Exact two-sided p = %.4g", fit$p.value))
report <- sprintf("%d of %d nonzero changes were positive (exact sign-test p = %.4g; 95%% CI for the positive-change probability %.2f to %.2f). The test asks about direction, not mean change; %d exact zero differences were excluded.", positive, length(nonzero), fit$p.value, fit$conf.int[1], fit$conf.int[2], sum(d$change_seconds == 0))
preview <- head(capture.output(print(head(d, 4), row.names = FALSE)), 5)
full_output <- paste(capture.output(print(fit)), collapse = "\n")
jsonlite::write_json(list(preview = preview, summary = summary_lines, report = report, full_output = full_output),
 file.path(output_dir, "results.json"), auto_unbox = TRUE, pretty = TRUE, digits = 8)
cat(report, "\n")
