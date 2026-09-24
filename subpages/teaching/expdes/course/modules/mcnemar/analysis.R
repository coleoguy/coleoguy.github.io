# Run: Rscript analysis.R path/to/output-folder
args <- commandArgs(trailingOnly = TRUE)
out_dir <- if (length(args)) args[1] else "."
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

# Simulate and save the data before analyzing them.
set.seed(3107)
d <- data.frame(mouse = 1:80, before = rbinom(80, 1, .45))
d$after <- rbinom(80, 1, ifelse(d$before == 1, .85, .35))
write.csv(d, file.path(out_dir, "data.csv"), row.names = FALSE)

# Analyze the saved data.
d <- read.csv(file.path(out_dir, "data.csv"))

tab <- table(factor(d$before, levels = 0:1),
             factor(d$after, levels = 0:1))
fit <- mcnemar.test(tab, correct = FALSE)
gained <- tab[1, 2]
lost <- tab[2, 1]
exact <- binom.test(gained, gained + lost, p = .5)
change <- mean(d$after) - mean(d$before)

# One primary plot.
ragg::agg_png(file.path(out_dir, "plot.png"),
              width = 1600, height = 1000, res = 160, background = "white")
par(mar = c(5, 5, 3, 1), las = 1)
counts <- c("Positive → negative" = lost, "Negative → positive" = gained)
bars <- barplot(counts, col = c("#b96735", "#126887"), border = NA,
                ylim = c(0, max(counts) * 1.25), ylab = "Discordant mouse pairs")
text(bars, counts, labels = counts, pos = 3, cex = 1.2)
mtext(paste(sum(diag(tab)), "mice unchanged; paired measurements stay together"),
      side = 3, cex = .9)
dev.off()

# Numerical output is generated from this analysis.
results <- list(
  preview = head(apply(d, 1, paste, collapse = " | "), 5),
  summary = c(sprintf("Gained detection: %d; lost detection: %d", gained, lost), sprintf("Before: %.3f; after: %.3f", mean(d$before), mean(d$after)), sprintf("Change: %.3f", change), sprintf("McNemar p = %.4g; exact paired p = %.4g", fit$p.value, exact$p.value)),
  report = sprintf("Detection changed from %.1f%% to %.1f%% (change %.1f percentage points). There were %d gains and %d losses; McNemar p = %.3g and exact paired p = %.3g. The comparison preserves mouse identity.",100*mean(d$before),100*mean(d$after),100*change,gained,lost,fit$p.value,exact$p.value),
  full_output = paste(capture.output(print(list(McNemar = fit, exact_discordant_pairs = exact))), collapse = "\n")
)
jsonlite::write_json(results, file.path(out_dir, "results.json"),
                     pretty = TRUE, auto_unbox = TRUE, digits = 6)
