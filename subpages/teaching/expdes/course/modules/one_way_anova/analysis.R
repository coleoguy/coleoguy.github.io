# Run: Rscript analysis.R /absolute/output/folder
args <- commandArgs(trailingOnly = TRUE)
output_dir <- if (length(args)) args[1] else "."
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
library(beeswarm)

# Simulate and save before analysis.
set.seed(1117)
d <- data.frame(soil = rep(c("Sand", "Loam", "Clay"), each = 25),
                biomass_g = c(rnorm(25, 4.5, .85), rnorm(25, 5.4, .85),
                              rnorm(25, 5.1, .85)))
write.csv(d, file.path(output_dir, "data.csv"), row.names = FALSE)
d <- read.csv(file.path(output_dir, "data.csv"))
# Analysis
d$soil <- factor(d$soil, levels = c("Sand", "Loam", "Clay"))
fit <- aov(biomass_g ~ soil, data = d)
anova_table <- summary(fit)[[1]]
welch <- oneway.test(biomass_g ~ soil, data = d,
                    var.equal = FALSE)

# Primary figure
ragg::agg_png(file.path(output_dir, "plot.png"), width = 1600, height = 1000, res = 170)
par(mar = c(5, 5, 2, 1), las = 1, bty = "l", cex = 1.15)
beeswarm(biomass_g ~ soil, data = d, pch = 21,
         bg = c("#246A73", "#B7663E", "#73649A"), col = "white", cex = 1.2,
         xlab = "Soil treatment", ylab = "Seedling biomass (g)")
means <- tapply(d$biomass_g, d$soil, mean)
se <- tapply(d$biomass_g, d$soil, sd) / sqrt(table(d$soil))
half <- qt(.975, df = table(d$soil) - 1) * se
segments(1:3, means - half, 1:3, means + half, lwd = 3)
points(1:3, means, pch = 18, cex = 2)
legend("topleft", "Mean and 95% CI", pch = 18, bty = "n")
dev.off()

# Results are computed from the saved dataset.
summary_lines <- c(sprintf("Ordinary ANOVA F(%d, %d) = %.2f; p = %.4g", anova_table[1,"Df"], anova_table[2,"Df"], anova_table[1,"F value"], anova_table[1,"Pr(>F)"]),
 sprintf("Welch ANOVA F = %.2f; denominator df = %.2f; p = %.4g", welch$statistic, welch$parameter[2], welch$p.value),
 paste("Observed means (g):", paste(names(means), round(means,2), collapse = "; ")),
 "Neither omnibus test identifies a specific differing pair.")
report <- sprintf("Mean seedling biomass was compared across soils with ordinary ANOVA: F(%d, %d) = %.2f, p = %.4g. Welch ANOVA, which relaxes equal variances, gave p = %.4g. Use a planned contrast or adjusted pairwise comparisons to answer which means differ.", anova_table[1,"Df"], anova_table[2,"Df"], anova_table[1,"F value"], anova_table[1,"Pr(>F)"], welch$p.value)
preview <- head(capture.output(print(head(d, 4), row.names = FALSE)), 5)
full_output <- paste(capture.output({ print(summary(fit)); print(welch) }), collapse = "\n")
jsonlite::write_json(list(preview = preview, summary = summary_lines, report = report, full_output = full_output),
 file.path(output_dir, "results.json"), auto_unbox = TRUE, pretty = TRUE, digits = 8)
cat(report, "\n")
