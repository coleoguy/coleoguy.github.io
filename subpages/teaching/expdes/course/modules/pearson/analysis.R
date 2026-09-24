# Run: Rscript analysis.R /absolute/output/folder
args <- commandArgs(trailingOnly = TRUE)
output_dir <- if (length(args)) args[1] else "."
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
library(ggplot2)

# Simulate and save before analysis.
set.seed(1112)
wing <- rnorm(45, 75, 5)
tail <- 15 + .55 * wing + rnorm(45, 0, 3.5)
d <- data.frame(bird = 1:45, wing_mm = wing, tail_mm = tail)
write.csv(d, file.path(output_dir, "data.csv"), row.names = FALSE)
d <- read.csv(file.path(output_dir, "data.csv"))

# Analysis
fit <- cor.test(d$wing_mm, d$tail_mm, method = "pearson",
                alternative = "two.sided", conf.level = .95)

# Primary figure
ragg::agg_png(file.path(output_dir, "plot.png"), width = 1600, height = 1000, res = 170)
par(mar = c(5, 5, 2, 1), las = 1, bty = "l", cex = 1.15)
p <- ggplot(d, aes(wing_mm, tail_mm)) +
  geom_point(shape = 21, fill = "#246A73", color = "white", size = 3.5, alpha = .85) +
  labs(x = "Wing length (mm)", y = "Tail length (mm)") +
  theme_classic(base_size = 18)
print(p)
dev.off()

# Results are computed from the saved dataset.
summary_lines <- c(sprintf("Pearson r = %.3f", fit$estimate),
 sprintf("95%% CI for population correlation: %.3f to %.3f", fit$conf.int[1], fit$conf.int[2]),
 sprintf("t = %.2f; df = %.0f; p = %.4g", fit$statistic, fit$parameter, fit$p.value))
report <- sprintf("Wing and tail lengths had Pearson r = %.3f (95%% CI %.3f to %.3f), p = %.4g. This describes linear association within the sampled population; it does not establish that one trait causes the other.", fit$estimate, fit$conf.int[1], fit$conf.int[2], fit$p.value)
preview <- head(capture.output(print(head(d, 4), row.names = FALSE)), 5)
full_output <- paste(capture.output(print(fit)), collapse = "\n")
jsonlite::write_json(list(preview = preview, summary = summary_lines, report = report, full_output = full_output),
 file.path(output_dir, "results.json"), auto_unbox = TRUE, pretty = TRUE, digits = 8)
cat(report, "\n")
