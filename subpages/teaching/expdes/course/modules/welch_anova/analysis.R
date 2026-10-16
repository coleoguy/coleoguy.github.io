# Run: Rscript analysis.R /absolute/output/folder
args <- commandArgs(trailingOnly = TRUE)
output_dir <- if (length(args)) args[1] else "."
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
library(beeswarm)

# Simulate and save before analysis.
set.seed(1119)
d <- data.frame(soil = rep(c("Sand", "Loam", "Clay"), c(20, 26, 32)),
                biomass_g = c(rnorm(20, 4.5, .6), rnorm(26, 5.4, 1.1),
                              rnorm(32, 5.1, 1.5)))
write.csv(d, file.path(output_dir, "data.csv"), row.names = FALSE)
d <- read.csv(file.path(output_dir, "data.csv"))
# Analysis
d$soil <- factor(d$soil, levels = c("Sand", "Loam", "Clay"))
fit <- oneway.test(biomass_g ~ soil, data = d,
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
summary_lines <- c(sprintf("Welch ANOVA F = %.2f; df = %.0f, %.2f; p = %.4g", fit$statistic, fit$parameter[1], fit$parameter[2], fit$p.value),
 paste("Group sample sizes:", paste(names(table(d$soil)), table(d$soil), collapse = "; ")),
 paste("Observed means (g):", paste(names(means), round(means,2), collapse = "; ")),
 "Unequal variance is modeled; the omnibus test does not select a pair.")
report <- sprintf("Welch ANOVA compared mean biomass across soils while allowing unequal variances: F(%.0f, %.2f) = %.2f, p = %.4g. This answers the same equal-means question as ordinary ANOVA; a specific pair requires an appropriate adjusted follow-up.", fit$parameter[1], fit$parameter[2], fit$statistic, fit$p.value)
preview <- head(capture.output(print(head(d, 4), row.names = FALSE)), 5)
full_output <- paste(capture.output(print(fit)), collapse = "\n")
jsonlite::write_json(list(preview = preview, summary = summary_lines, report = report, full_output = full_output),
 file.path(output_dir, "results.json"), auto_unbox = TRUE, pretty = TRUE, digits = 8)
cat(report, "\n")
