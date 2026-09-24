# Run: Rscript analysis.R path/to/output-folder
args <- commandArgs(trailingOnly = TRUE)
out_dir <- if (length(args)) args[1] else "."
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

# Simulate and save the data before analyzing them.
set.seed(3104)
d <- data.frame(offspring = 1:240,
  genotype = sample(c("AA", "Aa", "aa"), 240, replace = TRUE,
                    prob = c(.18, .54, .28)))
write.csv(d, file.path(out_dir, "data.csv"), row.names = FALSE)

# Analyze the saved data.
d <- read.csv(file.path(out_dir, "data.csv"))

observed <- table(factor(d$genotype, levels = c("AA", "Aa", "aa")))
fit <- chisq.test(observed, p = c(.25, .50, .25))
expected <- as.numeric(fit$expected)
departures <- observed / sum(observed) - c(.25, .50, .25)

# One primary plot.
ragg::agg_png(file.path(out_dir, "plot.png"),
              width = 1600, height = 1000, res = 160, background = "white")
par(mar = c(4, 5, 2, 1), las = 1)
bars <- barplot(rbind(Observed = observed, Expected = expected),
                beside = TRUE, col = c("#126887", "#d7d7d7"), border = NA,
                ylim = c(0, max(observed, expected) * 1.22),
                names.arg = names(observed), ylab = "Offspring", xlab = "Genotype")
text(bars, rbind(observed, expected), labels = c(rbind(observed, expected)),
     pos = 3, cex = .85)
legend("topright", c("Observed", "Expected under 1:2:1"),
       fill = c("#126887", "#d7d7d7"), bty = "n")
dev.off()

# Numerical output is generated from this analysis.
results <- list(
  preview = head(apply(d, 1, paste, collapse = " | "), 5),
  summary = c(paste("Observed:", paste(observed, collapse = ", ")), paste("Expected:", paste(expected, collapse = ", ")), sprintf("Chi-square = %.3f; df = %d", fit$statistic, fit$parameter), sprintf("p = %.4g", fit$p.value)),
  report = sprintf("Observed genotype proportions were %s. The goodness-of-fit test gives chi-square(%d) = %.2f, p = %.3g against the prespecified 1:2:1 ratio; the test does not identify a biological mechanism for the departure.", paste(sprintf("%.3f", observed/sum(observed)), collapse = ", "), fit$parameter, fit$statistic, fit$p.value),
  full_output = paste(capture.output(print(fit)), collapse = "\n")
)
jsonlite::write_json(results, file.path(out_dir, "results.json"),
                     pretty = TRUE, auto_unbox = TRUE, digits = 6)
