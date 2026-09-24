# Run: Rscript analysis.R path/to/output-folder
args <- commandArgs(trailingOnly = TRUE)
out_dir <- if (length(args)) args[1] else "."
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

# Simulate and save the data before analyzing them.
set.seed(3103)
d <- data.frame(group = rep(c("Evolved", "Ancestral"), each = 110))
d$survived <- rbinom(220, 1, rep(c(.72, .52), each = 110))
write.csv(d, file.path(out_dir, "data.csv"), row.names = FALSE)

# Analyze the saved data.
d <- read.csv(file.path(out_dir, "data.csv"))

groups <- c("Evolved", "Ancestral")
x <- sapply(groups, function(g) sum(d$survived[d$group == g]))
n <- sapply(groups, function(g) sum(d$group == g))
fit <- prop.test(x, n, correct = FALSE)
estimate <- x / n
difference <- estimate[1] - estimate[2]
ci <- fit$conf.int
group_ci <- sapply(1:2, function(i) prop.test(x[i], n[i],
                                            correct = FALSE)$conf.int)

# One primary plot.
ragg::agg_png(file.path(out_dir, "plot.png"),
              width = 1600, height = 1000, res = 160, background = "white")
par(mar = c(4, 5, 2, 1), las = 1)
plot(1:2, estimate, xlim = c(.5, 2.5), ylim = c(0, 1),
     xaxt = "n", xlab = "", ylab = "Survival probability", bty = "n",
     pch = 21, bg = c("#126887", "#b96735"), cex = 2.2)
arrows(1:2, group_ci[1, ], 1:2, group_ci[2, ],
       code = 3, angle = 90, length = .1, lwd = 2)
axis(1, 1:2, groups)
mtext("Intervals describe each probability; test the difference directly.", 3,
      cex = .85, col = "#555555")
dev.off()

# Numerical output is generated from this analysis.
results <- list(
  preview = head(apply(d, 1, paste, collapse = " | "), 5),
  summary = c(sprintf("Evolved: %d / %d; ancestral: %d / %d", x[1], n[1], x[2], n[2]), sprintf("Difference (evolved − ancestral): %.3f", difference), sprintf("95%% CI for difference: %.3f to %.3f", ci[1], ci[2]), sprintf("Two-sided p = %.4g", fit$p.value)),
  report = sprintf("Evolved minus ancestral survival was %.1f percentage points (95%% CI %.1f to %.1f; p = %.3g). The interval for this difference answers the comparison directly.", 100*difference, 100*ci[1], 100*ci[2], fit$p.value),
  full_output = paste(capture.output(print(fit)), collapse = "\n")
)
jsonlite::write_json(results, file.path(out_dir, "results.json"),
                     pretty = TRUE, auto_unbox = TRUE, digits = 6)
