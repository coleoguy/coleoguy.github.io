# Run: Rscript analysis.R /absolute/output/folder
args <- commandArgs(trailingOnly = TRUE)
output_dir <- if (length(args)) args[1] else "."
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
library(ggplot2)
# Simulate and save before analysis.
set.seed(2101)
d <- expand.grid(replicate = 1:22, genotype = c("A", "B"),
                 heat = c("Cool", "Warm"))
d$growth <- with(d, 14 + 1.4 * (genotype == "B") +
  2 * (heat == "Warm") + 2.3 * (genotype == "B" & heat == "Warm") +
  rnorm(nrow(d), 0, 2.1))
write.csv(d, file.path(output_dir, "data.csv"), row.names = FALSE)
d <- read.csv(file.path(output_dir, "data.csv"))
d$genotype <- factor(d$genotype, levels = c("A", "B"))
d$heat <- factor(d$heat, levels = c("Cool", "Warm"))
# Analysis
fit <- lm(growth ~ genotype * heat, data = d)
summary(fit)
interaction_ci <- confint(fit)["genotypeB:heatWarm", ]

# Primary figure
ragg::agg_png(file.path(output_dir, "plot.png"), width = 1600, height = 1000, res = 160, background = "white")
p <- ggplot(d, aes(heat, growth, color = genotype)) +
  geom_point(position = position_jitterdodge(jitter.width = .13,
    dodge.width = .35, seed = 21), alpha = .42, size = 2) +
  stat_summary(fun = mean, geom = "point",
    position = position_dodge(.35), size = 4, shape = 18) +
  scale_color_manual(values = c("#246A73", "#B7663E")) +
  labs(x = "Rearing temperature", y = "Larval growth (mg/week)",
       color = "Genotype", caption = "Small points: individuals; diamonds: group means") +
  theme_classic(base_size = 16)
print(p)
dev.off()

# Results computed from the saved data.
b <- coef(summary(fit))["genotypeB:heatWarm", ]
summary_lines <- c(sprintf("Interaction = %.2f mg/week", b[1]),
 sprintf("95%% CI %.2f to %.2f", interaction_ci[1], interaction_ci[2]),
 sprintf("t(%d) = %.2f; p = %.4g", df.residual(fit), b[3], b[4]))
report <- sprintf("The warm-minus-cool growth effect was %.2f mg/week greater in genotype B than A (95%% CI %.2f to %.2f; p = %.4g). The interaction asks whether the temperature effect depends on genotype; a single average temperature effect would hide this difference.", b[1], interaction_ci[1], interaction_ci[2], b[4])
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
