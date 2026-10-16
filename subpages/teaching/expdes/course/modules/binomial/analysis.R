# Run: Rscript analysis.R path/to/output-folder
args <- commandArgs(trailingOnly = TRUE)
out_dir <- if (length(args)) args[1] else "."
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

# Simulate and save the data before analyzing them.
set.seed(3101)
d <- data.frame(wasp = 1:80,
                native = rbinom(80, 1, 0.68))
write.csv(d, file.path(out_dir, "data.csv"), row.names = FALSE)

# Analyze the saved data.
d <- read.csv(file.path(out_dir, "data.csv"))

x <- sum(d$native)
fit <- binom.test(x, nrow(d), p = 0.5,
                  alternative = "two.sided")
estimate <- x / nrow(d)
ci <- fit$conf.int

# One primary plot.
ragg::agg_png(file.path(out_dir, "plot.png"),
              width = 1600, height = 1000, res = 160, background = "white")
par(mar = c(4, 5, 2, 1), las = 1)
plot(1, estimate, xlim = c(0.5, 1.5), ylim = c(0, 1),
     xaxt = "n", xlab = "", ylab = "Probability of native-host choice",
     pch = 21, bg = "#126887", cex = 2.2, bty = "n")
arrows(1, ci[1], 1, ci[2], angle = 90, code = 3, length = .12, lwd = 2)
abline(h = 0.5, lty = 2, col = "#777777")
axis(1, 1, paste(nrow(d), "wasps"))
text(1.45, .53, "Null = 0.50", adj = 1, col = "#666666")
dev.off()

# Numerical output is generated from this analysis.
results <- list(
  preview = head(apply(d, 1, paste, collapse = " | "), 5),
  summary = c(sprintf("Native-host choices: %d / %d", x, nrow(d)), sprintf("Estimated probability: %.3f", estimate), sprintf("95%% exact CI: %.3f to %.3f", ci[1], ci[2]), sprintf("Exact two-sided p = %.4g", fit$p.value)),
  report = sprintf("Native-host choice was %.1f%% (95%% exact CI %.1f–%.1f%%; p = %.3g against 50%%). This estimates preference under the simulated choice conditions.", 100*estimate, 100*ci[1], 100*ci[2], fit$p.value),
  full_output = paste(capture.output(print(fit)), collapse = "\n")
)
jsonlite::write_json(results, file.path(out_dir, "results.json"),
                     pretty = TRUE, auto_unbox = TRUE, digits = 6)
