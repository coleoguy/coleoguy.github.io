# Run: Rscript analysis.R path/to/output-folder
args <- commandArgs(trailingOnly = TRUE)
out_dir <- if (length(args)) args[1] else "."
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

# Simulate and save the data before analyzing them.
set.seed(3109)
d <- data.frame(lineage = 1:60, megabases = runif(60, 8, 20))
d$mutations <- rpois(60, .40 * d$megabases)
write.csv(d, file.path(out_dir, "data.csv"), row.names = FALSE)

# Analyze the saved data.
d <- read.csv(file.path(out_dir, "data.csv"))

fit <- poisson.test(sum(d$mutations), T = sum(d$megabases),
                    r = .25, alternative = "two.sided")
rate <- sum(d$mutations) / sum(d$megabases)
ci <- fit$conf.int

# One primary plot.
ragg::agg_png(file.path(out_dir, "plot.png"),
              width = 1600, height = 1000, res = 160, background = "white")
par(mar = c(5, 5, 2, 1), las = 1)
plot(d$megabases, d$mutations, pch = 16, col = "#126887AA", bty = "n",
     xlab = "Callable sequence (megabases)", ylab = "Mutation count",
     xlim = c(0, max(d$megabases)), ylim = c(0, max(d$mutations) + 1))
abline(a = 0, b = .25, lty = 2, col = "#777777", lwd = 2)
abline(a = 0, b = rate, col = "#126887", lwd = 3)
legend("topleft", c("Null rate = 0.25", "Estimated rate"),
       lty = c(2, 1), lwd = c(2, 3), col = c("#777777", "#126887"), bty = "n")
dev.off()

# Numerical output is generated from this analysis.
results <- list(
  preview = head(apply(d, 1, paste, collapse = " | "), 5),
  summary = c(sprintf("Events: %d; exposure: %.1f Mb", sum(d$mutations), sum(d$megabases)), sprintf("Rate: %.3f mutations/Mb", rate), sprintf("95%% exact CI: %.3f to %.3f", ci[1], ci[2]), sprintf("Exact p = %.4g", fit$p.value)),
  report = sprintf("The mutation rate was %.3f per callable Mb (95%% exact CI %.3f–%.3f; p = %.3g against 0.25/Mb). Pooling counts is justified here by the common-rate Poisson model.", rate, ci[1], ci[2], fit$p.value),
  full_output = paste(capture.output(print(fit)), collapse = "\n")
)
jsonlite::write_json(results, file.path(out_dir, "results.json"),
                     pretty = TRUE, auto_unbox = TRUE, digits = 6)
