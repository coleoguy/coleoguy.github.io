# Run: Rscript analysis.R /absolute/output/folder
args <- commandArgs(trailingOnly = TRUE)
output_dir <- if (length(args)) args[1] else "."
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
library(ggplot2)
# Simulate and save before analysis.
set.seed(2102)
d <- data.frame(plant = 1:90, treatment = rep(c("Control", "Nutrient"), each = 45),
                initial = runif(90, 3, 9))
d$biomass <- with(d, 2 + 1.5 * initial +
  2.4 * (treatment == "Nutrient") + rnorm(90, 0, 1.8))
write.csv(d, file.path(output_dir, "data.csv"), row.names = FALSE)
d <- read.csv(file.path(output_dir, "data.csv"))
d$treatment <- factor(d$treatment, levels = c("Control", "Nutrient"))
# Analysis
fit <- lm(biomass ~ treatment + initial, data = d)
summary(fit)
adjusted_ci <- confint(fit)["treatmentNutrient", ]
predictions <- expand.grid(initial = seq(3, 9, length.out = 80),
                           treatment = levels(d$treatment))
predictions$fit <- predict(fit, newdata = predictions)
# Primary figure
ragg::agg_png(file.path(output_dir, "plot.png"), width = 1600, height = 1000, res = 160, background = "white")
p <- ggplot(d, aes(initial, biomass, color = treatment)) +
  geom_point(size = 2.5, alpha = .7) +
  geom_line(data = predictions, aes(y = fit), linewidth = 1.1) +
  scale_color_manual(values = c("#246A73", "#B7663E")) +
  labs(x = "Initial plant height (cm)", y = "Final dry biomass (g)",
       color = "Treatment", caption = "Lines: fitted common-slope ANCOVA model") +
  theme_classic(base_size = 16)
print(p)
dev.off()

# Results computed from the saved data.
b <- coef(summary(fit))["treatmentNutrient", ]
summary_lines <- c(sprintf("Adjusted nutrient minus control = %.2f g", b[1]),
 sprintf("95%% CI %.2f to %.2f", adjusted_ci[1], adjusted_ci[2]),
 sprintf("t(%d) = %.2f; p = %.4g", df.residual(fit), b[3], b[4]))
report <- sprintf("At the same initial height, nutrient-treated plants had %.2f g greater mean biomass (95%% CI %.2f to %.2f; p = %.4g). This fitted model assumes a common height slope; the adjusted treatment comparison is supported by overlapping height ranges.", b[1], adjusted_ci[1], adjusted_ci[2], b[4])
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
