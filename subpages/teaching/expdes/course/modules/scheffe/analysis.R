# Run: Rscript analysis.R /absolute/output/folder
args <- commandArgs(trailingOnly = TRUE)
output_dir <- if (length(args)) args[1] else "."
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

# Simulate and save before analysis.
set.seed(2104)
d <- data.frame(plant = 1:80,
                nutrient = rep(c("A", "B", "C", "D"), each = 20))
d$biomass <- rnorm(80, rep(c(8, 9, 11.3, 12.1), each = 20), 1.7)
write.csv(d, file.path(output_dir, "data.csv"), row.names = FALSE)
d <- read.csv(file.path(output_dir, "data.csv"))
d$nutrient <- factor(d$nutrient, levels = c("A", "B", "C", "D"))
# Analysis
fit <- lm(biomass ~ nutrient, data = d)
means <- emmeans::emmeans(fit, ~ nutrient)
contrast <- emmeans::contrast(means,
  list("CD average minus AB average" = c(-.5, -.5, .5, .5)))
comparison <- summary(contrast, infer = c(TRUE, TRUE),
                      adjust = "scheffe", scheffe.rank = 3)

# Primary figure
ragg::agg_png(file.path(output_dir, "plot.png"), width = 1600, height = 1000, res = 160, background = "white")
par(mar = c(5, 5, 2, 1), las = 1, bty = "l", cex = 1.15)
beeswarm::beeswarm(biomass ~ nutrient, data = d,
  pch = 21, bg = c("#246A73", "#73969B", "#D7A583", "#B7663E"),
  col = "white", cex = 1.25, xlab = "Nutrient regime",
  ylab = "Dry biomass (g)")
points(1:4, tapply(d$biomass, d$nutrient, mean),
       pch = 18, cex = 2, col = "#172D34")
legend("topleft", "Diamonds = means", pch = 18, bty = "n")
dev.off()

# Results computed from the saved data.
selected <- as.data.frame(comparison)[1, ]
summary_lines <- c("Contrast: (C + D)/2 − (A + B)/2",
 sprintf("Estimated difference = %.2f g", selected$estimate),
 sprintf("Scheffé 95%% CI %.2f to %.2f", selected$lower.CL, selected$upper.CL),
 sprintf("Scheffé-adjusted p = %.4g", selected$p.value))
report <- sprintf("The average of regimes C and D exceeded the average of A and B by %.2f g (Scheffé simultaneous 95%% CI %.2f to %.2f; adjusted p = %.4g). Using rank 3 protects all mean contrasts among these four groups, a larger family than the pairwise comparisons protected by Tukey.", selected$estimate, selected$lower.CL, selected$upper.CL, selected$p.value)
full_output <- paste(capture.output({
  if (exists("fit", inherits = FALSE)) print(summary(fit))
  if (exists("test", inherits = FALSE)) print(test)
  if (exists("overall", inherits = FALSE)) print(overall)
  if (exists("comparisons", inherits = FALSE)) print(comparisons)
  if (exists("comparison", inherits = FALSE)) print(comparison)
  if (exists("ph_check", inherits = FALSE)) print(ph_check)
  if (exists("poisson_fit", inherits = FALSE)) print(summary(poisson_fit))
}), collapse = "\n")

preview <- head(capture.output(print(head(d, 4), row.names = FALSE)), 5)
jsonlite::write_json(list(preview = preview, summary = summary_lines,
                         report = report, full_output = full_output),
  file.path(output_dir, "results.json"), auto_unbox = TRUE,
  pretty = TRUE, digits = 8)
cat(report, "\n")
