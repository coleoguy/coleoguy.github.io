# Run: Rscript analysis.R /absolute/output/folder
args <- commandArgs(trailingOnly = TRUE)
output_dir <- if (length(args)) args[1] else "."
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
library(ggplot2)
# Simulate and save before analysis.
set.seed(2106)
d <- expand.grid(week = 0:3, larva = 1:36)
d$treatment <- rep(rep(c("Control", "Enriched"), each = 18), each = 4)
intercepts <- rnorm(36, 0, 2.3); slopes <- rnorm(36, 0, .7)
d$mass <- 12 + 2 * d$week + .8 * (d$treatment == "Enriched") +
  .9 * d$week * (d$treatment == "Enriched") + intercepts[d$larva] +
  slopes[d$larva] * d$week + rnorm(nrow(d), 0, 1.1)
write.csv(d, file.path(output_dir, "data.csv"), row.names = FALSE)
d <- read.csv(file.path(output_dir, "data.csv"))
d$larva <- factor(d$larva)
d$treatment <- factor(d$treatment, levels = c("Control", "Enriched"))
# Analysis
fit <- lmerTest::lmer(mass ~ treatment * week + (week | larva), data = d)
summary(fit, ddf = "Satterthwaite")
trend_ci <- confint(fit, parm = "treatmentEnriched:week", method = "Wald")

# Primary figure
ragg::agg_png(file.path(output_dir, "plot.png"), width = 1600, height = 1000, res = 160, background = "white")
p <- ggplot(d, aes(week, mass, color = treatment)) +
  geom_line(aes(group = larva), alpha = .23) +
  geom_point(alpha = .35, size = 1.6) +
  stat_summary(fun = mean, geom = "line", linewidth = 1.7) +
  scale_color_manual(values = c("#246A73", "#B7663E")) +
  scale_x_continuous(breaks = 0:3) +
  labs(x = "Week", y = "Larval mass (mg)", color = "Diet",
       caption = "Thin lines: individuals; thick lines: observed group means") +
  theme_classic(base_size = 16)
print(p)
dev.off()

# Results computed from the saved data.
b <- coef(summary(fit))["treatmentEnriched:week", ]
summary_lines <- c(sprintf("Growth-slope difference = %.2f mg/week", b[1]),
 sprintf("Approximate 95%% Wald CI %.2f to %.2f", trend_ci[1], trend_ci[2]),
 sprintf("Satterthwaite df = %.1f; t = %.2f; p = %.4g", b[3], b[4], b[5]),
 sprintf("36 larvae; 144 rows; singular fit: %s", lme4::isSingular(fit)))
report <- sprintf("Enrichment increased the fitted growth slope by %.2f mg/week (approximate 95%% Wald CI %.2f to %.2f; Satterthwaite t with %.1f df, p = %.4g). Individual intercepts and slopes model repeated larvae; 144 rows do not represent 144 independent animals.", b[1], trend_ci[1], trend_ci[2], b[3], b[5])
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
