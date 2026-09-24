# Run: Rscript analysis.R /absolute/output/folder
args <- commandArgs(trailingOnly = TRUE)
output_dir <- if (length(args)) args[1] else "."
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
library(ggplot2)

# Simulate and save before analysis.
set.seed(1115)
body <- runif(60, 7, 12)
nutrition <- runif(60, 2, 10)
horn <- .4 + .35 * body + .16 * nutrition + rnorm(60, 0, .65)
d <- data.frame(beetle = 1:60, body_mm = body, nutrition_mg = nutrition, horn_mm = horn)
write.csv(d, file.path(output_dir, "data.csv"), row.names = FALSE)
d <- read.csv(file.path(output_dir, "data.csv"))

# Analysis
fit <- lm(horn_mm ~ body_mm + nutrition_mg, data = d)
reduced <- lm(horn_mm ~ nutrition_mg, data = d)
comparison <- anova(reduced, fit)
coefficients <- summary(fit)$coefficients
ci <- confint(fit)

# Primary figure
ragg::agg_png(file.path(output_dir, "plot.png"), width = 1600, height = 1000, res = 170)
par(mar = c(5, 5, 2, 1), las = 1, bty = "l", cex = 1.15)
p <- ggplot(d, aes(body_mm, horn_mm, color = nutrition_mg)) +
  geom_point(size = 3.8, alpha = .9) +
  scale_color_gradient(low = "#C8DCE0", high = "#174D58") +
  labs(x = "Adult body length (mm)", y = "Horn length (mm)", color = "Larval nutrition
(mg)") +
  theme_classic(base_size = 18)
print(p)
dev.off()

# Results are computed from the saved dataset.
summary_lines <- c(sprintf("Body slope, adjusted for nutrition = %.3f mm/mm", coef(fit)["body_mm"]),
 sprintf("95%% CI: %.3f to %.3f", ci["body_mm",1], ci["body_mm",2]),
 sprintf("Body coefficient p = %.4g; nested-model F = %.2f", coefficients["body_mm",4], comparison[2,"F"]),
 sprintf("Nutrition slope = %.3f mm/mg; p = %.4g", coef(fit)["nutrition_mg"], coefficients["nutrition_mg",4]),
 sprintf("Adjusted R-squared = %.3f", summary(fit)$adj.r.squared))
report <- sprintf("Holding larval nutrition fixed in the additive model, each additional mm of body length was associated with %.3f mm higher mean horn length (95%% CI %.3f to %.3f; p = %.4g). This conditional association is not the same as the unadjusted relationship or proof of causation.", coef(fit)["body_mm"], ci["body_mm",1], ci["body_mm",2], coefficients["body_mm",4])
preview <- head(capture.output(print(head(d, 4), row.names = FALSE)), 5)
full_output <- paste(capture.output({ print(summary(fit)); print(confint(fit)) }), collapse = "\n")
jsonlite::write_json(list(preview = preview, summary = summary_lines, report = report, full_output = full_output),
 file.path(output_dir, "results.json"), auto_unbox = TRUE, pretty = TRUE, digits = 8)
cat(report, "\n")
