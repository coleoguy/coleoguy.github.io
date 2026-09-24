# Run: Rscript analysis.R /absolute/output/folder
args <- commandArgs(trailingOnly = TRUE)
output_dir <- if (length(args)) args[1] else "."
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
library(car)
library(ggplot2)

# Simulate and save before analysis.
set.seed(1110)
d <- data.frame(medium = rep(c("Low", "Medium", "High"), each = 28),
                diameter_mm = c(rlnorm(28, log(4), .12),
                rlnorm(28, log(4), .20), rlnorm(28, log(4), .35)))
write.csv(d, file.path(output_dir, "data.csv"), row.names = FALSE)
d <- read.csv(file.path(output_dir, "data.csv"))
# Analysis
d$medium <- factor(d$medium, levels = c("Low", "Medium", "High"))
brown_forsythe <- leveneTest(diameter_mm ~ medium, data = d,
                            center = median)
original_levene <- leveneTest(diameter_mm ~ medium, data = d,
                              center = mean)

# Primary figure
ragg::agg_png(file.path(output_dir, "plot.png"), width = 1600, height = 1000, res = 170)
par(mar = c(5, 5, 2, 1), las = 1, bty = "l", cex = 1.15)
p <- ggplot(d, aes(medium, diameter_mm, fill = medium)) +
  geom_boxplot(width = .45, alpha = .28, outlier.shape = NA) +
  geom_jitter(width = .12, height = 0, shape = 21, size = 2.5, alpha = .8) +
  scale_fill_manual(values = c("#246A73", "#73649A", "#B7663E")) +
  labs(x = "Nutrient medium", y = "Colony diameter (mm)") +
  theme_classic(base_size = 18) + theme(legend.position = "none")
print(p)
dev.off()

# Results are computed from the saved dataset.
bf_f <- brown_forsythe[1, "F value"]
bf_p <- brown_forsythe[1, "Pr(>F)"]
summary_lines <- c(sprintf("Brown–Forsythe F = %.2f; df = %d, %d; p = %.4g", bf_f, brown_forsythe[1,"Df"], brown_forsythe[2,"Df"], bf_p),
 sprintf("Original Levene F = %.2f; p = %.4g", original_levene[1,"F value"], original_levene[1,"Pr(>F)"]),
 paste("Observed group SDs:", paste(names(tapply(d$diameter_mm, d$medium, sd)), round(tapply(d$diameter_mm, d$medium, sd), 2), collapse = "; ")))
report <- sprintf("The median-centered Brown–Forsythe comparison gave F(%d, %d) = %.2f, p = %.4g. Inspect the distributions as well as the p-value: the procedure compares absolute deviations, which can reflect both spread and shape.", brown_forsythe[1,"Df"], brown_forsythe[2,"Df"], bf_f, bf_p)
preview <- head(capture.output(print(head(d, 4), row.names = FALSE)), 5)
full_output <- paste(capture.output({ print(brown_forsythe); print(original_levene) }), collapse = "\n")
jsonlite::write_json(list(preview = preview, summary = summary_lines, report = report, full_output = full_output),
 file.path(output_dir, "results.json"), auto_unbox = TRUE, pretty = TRUE, digits = 8)
cat(report, "\n")
