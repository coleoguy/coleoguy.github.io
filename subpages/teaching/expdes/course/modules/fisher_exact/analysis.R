# Run: Rscript analysis.R path/to/output-folder
args <- commandArgs(trailingOnly = TRUE)
out_dir <- if (length(args)) args[1] else "."
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

# Simulate and save the data before analyzing them.
set.seed(3106)
d <- data.frame(clone = 1:24,
  type = rep(c("Susceptible", "Resistant"), each = 12))
d$survived <- rbinom(24, 1, rep(c(.20, .65), each = 12))
write.csv(d, file.path(out_dir, "data.csv"), row.names = FALSE)

# Analyze the saved data.
d <- read.csv(file.path(out_dir, "data.csv"))

tab <- table(factor(d$type, levels = c("Susceptible", "Resistant")),
             factor(d$survived, levels = c(0, 1)))
fit <- fisher.test(tab, alternative = "two.sided")
odds_ratio <- unname(fit$estimate)
ci <- fit$conf.int

# One primary plot.
ragg::agg_png(file.path(out_dir, "plot.png"),
              width = 1600, height = 1000, res = 160, background = "white")
par(mar = c(4, 5, 2, 1), las = 1)
bars <- barplot(t(tab), beside = TRUE, border = NA,
  col = c("#d5d5d5", "#126887"), ylim = c(0, max(tab) + 3),
  names.arg = rownames(tab), ylab = "Clones")
text(bars, t(tab), labels = c(t(tab)), pos = 3)
legend("topright", c("Died", "Survived"),
       fill = c("#d5d5d5", "#126887"), bty = "n")
dev.off()

# Numerical output is generated from this analysis.
results <- list(
  preview = head(apply(d, 1, paste, collapse = " | "), 5),
  summary = c(sprintf("Survivors: susceptible %d/12; resistant %d/12", tab[1,2], tab[2,2]), sprintf("Survival odds ratio (resistant / susceptible): %.3f", odds_ratio), sprintf("95%% exact CI: %.3f to %.3f", ci[1], ci[2]), sprintf("Two-sided exact p = %.4g", fit$p.value)),
  report = sprintf("The resistant-to-susceptible survival odds ratio was %.2f (95%% exact CI %.2f–%.2f; p = %.3g). A wide interval reflects limited information from these small groups; odds are not probabilities.", odds_ratio, ci[1], ci[2], fit$p.value),
  full_output = paste(capture.output(print(fit)), collapse = "\n")
)
jsonlite::write_json(results, file.path(out_dir, "results.json"),
                     pretty = TRUE, auto_unbox = TRUE, digits = 6)
