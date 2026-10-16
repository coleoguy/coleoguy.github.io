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
omnibus_p <- anova(fit)$`Pr(>F)`[1]
means <- emmeans::emmeans(fit, ~ nutrient)
comparisons <- NULL
if (omnibus_p < .05) {
  comparisons <- summary(emmeans::contrast(means, "pairwise"),
                         infer = c(TRUE, TRUE), adjust = "none")
}

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
if (is.null(comparisons)) {
  summary_lines <- sprintf("Omnibus p = %.4g; protected LSD gate not passed", omnibus_p)
  report <- paste(summary_lines, "No protected-LSD pairwise decisions are made.")
} else {
selected <- as.data.frame(comparisons)[1, ]
summary_lines <- c(sprintf("Omnibus p = %.4g", omnibus_p),
 sprintf("%s = %.2f g", selected$contrast, selected$estimate),
 sprintf("Individual 95%% CI %.2f to %.2f", selected$lower.CL, selected$upper.CL),
 sprintf("Unadjusted p = %.4g", selected$p.value),
 "Protected LSD first requires a significant omnibus test.")
report <- sprintf("The omnibus test had p = %.4g, so the protected LSD gate is passed in this example. The %s difference was %.2f g (individual 95%% CI %.2f to %.2f; unadjusted p = %.4g). This gate does not generally protect all pairwise decisions when some of four or more means differ; use Tukey for the all-pairs family.", omnibus_p, selected$contrast, selected$estimate, selected$lower.CL, selected$upper.CL, selected$p.value)
}
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
