# Run: Rscript analysis.R /absolute/output/folder
args <- commandArgs(trailingOnly = TRUE)
output_dir <- if (length(args)) args[1] else "."
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
library(ggplot2)

# Simulate and save before analysis.
set.seed(1106)
d <- data.frame(lake = rep(c("Clear", "Reedy"), each = 32),
                parasites = c(rnbinom(32, mu = 5, size = 1.5),
                              rnbinom(32, mu = 10, size = 1.5)))
write.csv(d, file.path(output_dir, "data.csv"), row.names = FALSE)
d <- read.csv(file.path(output_dir, "data.csv"))

# Analysis
fit <- wilcox.test(parasites ~ lake, data = d,
                   exact = FALSE, correct = TRUE)

# Primary figure
ragg::agg_png(file.path(output_dir, "plot.png"), width = 1600, height = 1000, res = 170)
par(mar = c(5, 5, 2, 1), las = 1, bty = "l", cex = 1.15)
p <- ggplot(d, aes(lake, parasites, color = lake)) +
  geom_jitter(width = .12, height = 0, size = 2.7, alpha = .75) +
  stat_summary(fun = median, geom = "point", shape = 18, size = 5, color = "black") +
  scale_color_manual(values = c("#246A73", "#B7663E")) +
  labs(x = "Lake", y = "Parasites per fish", caption = "Black diamonds: group medians") +
  theme_classic(base_size = 18) + theme(legend.position = "none")
print(p)
dev.off()

# Results are computed from the saved dataset.
med <- tapply(d$parasites, d$lake, median)
summary_lines <- c(sprintf("Observed medians: Clear %.1f; Reedy %.1f parasites", med["Clear"], med["Reedy"]),
 sprintf("W = %.1f; asymptotic p = %.4g", fit$statistic, fit$p.value),
 "Medians describe these data; the general null concerns distributions.")
report <- sprintf("Parasite burdens had observed medians %.1f (Clear) and %.1f (Reedy). The rank-sum comparison gave W = %.1f, p = %.4g. This is evidence about the distributions; calling it a median test requires additional shape assumptions.", med["Clear"], med["Reedy"], fit$statistic, fit$p.value)
preview <- head(capture.output(print(head(d, 4), row.names = FALSE)), 5)
full_output <- paste(capture.output(print(fit)), collapse = "\n")
jsonlite::write_json(list(preview = preview, summary = summary_lines, report = report, full_output = full_output),
 file.path(output_dir, "results.json"), auto_unbox = TRUE, pretty = TRUE, digits = 8)
cat(report, "\n")
