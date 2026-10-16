# Run: Rscript analysis.R path/to/output-folder
args <- commandArgs(trailingOnly = TRUE)
out_dir <- if (length(args)) args[1] else "."
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

# Simulate and save the data before analyzing them.
set.seed(3108)
bee_effect <- rnorm(60, 0, .8)
d <- data.frame(bee = rep(1:60, each = 3),
                odor = rep(c("A", "B", "C"), 60))
d$visit <- rbinom(180, 1,
  plogis(-.7 + rep(bee_effect, each = 3) + rep(c(0, .5, 1), 60)))
write.csv(d, file.path(out_dir, "data.csv"), row.names = FALSE)

# Analyze the saved data.
d <- read.csv(file.path(out_dir, "data.csv"))

wide <- xtabs(visit ~ bee + odor, data = d)
k <- ncol(wide)
C <- colSums(wide)
R <- rowSums(wide)
Q <- (k - 1) * (k * sum(C^2) - sum(C)^2) /
     (k * sum(R) - sum(R^2))
p_value <- pchisq(Q, df = k - 1, lower.tail = FALSE)
rates <- C / nrow(wide)
ci <- sapply(1:k, function(j) binom.test(C[j], nrow(wide))$conf.int)

# One primary plot.
ragg::agg_png(file.path(out_dir, "plot.png"),
              width = 1600, height = 1000, res = 160, background = "white")
par(mar = c(4, 5, 3, 1), las = 1)
plot(1:k, rates, xlim = c(.5, k + .5), ylim = c(0, 1),
     xaxt = "n", xlab = "Floral odor", ylab = "Visit probability", bty = "n",
     pch = 21, bg = "#126887", cex = 2)
arrows(1:k, ci[1, ], 1:k, ci[2, ], code = 3, angle = 90, length = .1)
axis(1, 1:k, colnames(wide))
mtext("Same 60 bees in every condition; intervals describe each probability",
      side = 3, cex = .85)
dev.off()

# Numerical output is generated from this analysis.
results <- list(
  preview = head(apply(d, 1, paste, collapse = " | "), 5),
  summary = c(sprintf("Matched bees: %d; conditions: %d", nrow(wide), k), sprintf("Visit probabilities: %s", paste(sprintf("%.3f",rates), collapse = ", ")), sprintf("Q = %.3f; df = %d", Q, k-1), sprintf("Omnibus p = %.4g", p_value)),
  report = sprintf("Visit probabilities were %s. Cochran Q(%d) = %.2f, p = %.3g tests equality across all odors while retaining matching. It does not identify which odor pairs differ.", paste(sprintf("%.1f%%",100*rates), collapse = ", "), k-1, Q, p_value),
  full_output = paste(capture.output(print(list(statistic = Q, df = k - 1, p.value = p_value, visit_probabilities = rates))), collapse = "\n")
)
jsonlite::write_json(results, file.path(out_dir, "results.json"),
                     pretty = TRUE, auto_unbox = TRUE, digits = 6)
