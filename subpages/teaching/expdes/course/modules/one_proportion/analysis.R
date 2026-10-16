# Run: Rscript analysis.R path/to/output-folder
args <- commandArgs(trailingOnly = TRUE)
out_dir <- if (length(args)) args[1] else "."
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

# Simulate and save the data before analyzing them.
set.seed(3102)
d <- data.frame(seed = 1:120,
                germinated = rbinom(120, 1, 0.67))
write.csv(d, file.path(out_dir, "data.csv"), row.names = FALSE)

# Analyze the saved data.
d <- read.csv(file.path(out_dir, "data.csv"))

x <- sum(d$germinated)
fit <- prop.test(x, nrow(d), p = 0.5,
                 alternative = "two.sided", correct = FALSE)
estimate <- x / nrow(d)
ci <- fit$conf.int

# One primary plot.
ragg::agg_png(file.path(out_dir, "plot.png"),
              width = 1600, height = 1000, res = 160, background = "white")
par(mar = c(5, 3, 2, 1), las = 1)
plot(estimate, 1, xlim = c(0, 1), ylim = c(.7, 1.3), yaxt = "n",
     xlab = "Germination probability", ylab = "", bty = "n", type = "n")
abline(v = 0.5, lty = 2, col = "#777777")
segments(ci[1], 1, ci[2], 1, lwd = 4, col = "#126887")
points(estimate, 1, pch = 15, cex = 2.2)
text(estimate, 1.12, paste(x, "of", nrow(d), "seeds germinated"))
dev.off()

# Numerical output is generated from this analysis.
results <- list(
  preview = head(apply(d, 1, paste, collapse = " | "), 5),
  summary = c(sprintf("Germination: %d / %d", x, nrow(d)), sprintf("Estimated probability: %.3f", estimate), sprintf("95%% score CI: %.3f to %.3f", ci[1], ci[2]), sprintf("Two-sided p = %.4g", fit$p.value)),
  report = sprintf("Germination was %.1f%% (95%% score CI %.1f–%.1f%%; p = %.3g against 50%%). The test concerns this germination probability, not the mean of arbitrary continuous percentages.", 100*estimate, 100*ci[1], 100*ci[2], fit$p.value),
  full_output = paste(capture.output(print(fit)), collapse = "\n")
)
jsonlite::write_json(results, file.path(out_dir, "results.json"),
                     pretty = TRUE, auto_unbox = TRUE, digits = 6)
