# Run: Rscript analysis.R /absolute/output/folder
args <- commandArgs(trailingOnly = TRUE)
output_dir <- if (length(args)) args[1] else "."
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

# Simulate and save before analysis.
set.seed(1113)
salinity <- runif(45, .5, 8)
richness <- round(90 - 25 * log(salinity + 1) + rnorm(45, 0, 7))
d <- data.frame(site = 1:45, salinity_ppt = salinity, richness = richness)
write.csv(d, file.path(output_dir, "data.csv"), row.names = FALSE)
d <- read.csv(file.path(output_dir, "data.csv"))

# Analysis
fit <- cor.test(d$salinity_ppt, d$richness,
                method = "spearman", exact = FALSE,
                alternative = "two.sided")

# Primary figure
ragg::agg_png(file.path(output_dir, "plot.png"), width = 1600, height = 1000, res = 170)
par(mar = c(5, 5, 2, 1), las = 1, bty = "l", cex = 1.15)
plot(d$salinity_ppt, d$richness, pch = 21, bg = "#73649A", col = "white",
     cex = 1.4, xlab = "Soil salinity (ppt)", ylab = "Bacterial richness (taxa)")
dev.off()

# Results are computed from the saved dataset.
summary_lines <- c(sprintf("Spearman rho = %.3f; n = %d", fit$estimate, nrow(d)),
 sprintf("S = %.1f; asymptotic two-sided p = %.4g", fit$statistic, fit$p.value),
 "The coefficient describes rank association, not a change in taxa per ppt.")
report <- sprintf("Salinity and bacterial richness had Spearman rho = %.3f (two-sided p = %.4g). This quantifies their monotonic rank association. It does not estimate a change in mean richness per unit salinity.", fit$estimate, fit$p.value)
preview <- head(capture.output(print(head(d, 4), row.names = FALSE)), 5)
full_output <- paste(capture.output(print(fit)), collapse = "\n")
jsonlite::write_json(list(preview = preview, summary = summary_lines, report = report, full_output = full_output),
 file.path(output_dir, "results.json"), auto_unbox = TRUE, pretty = TRUE, digits = 8)
cat(report, "\n")
