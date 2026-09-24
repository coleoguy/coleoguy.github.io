# Run: Rscript analysis.R /absolute/output/folder
args <- commandArgs(trailingOnly = TRUE)
output_dir <- if (length(args)) args[1] else "."
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
library(ggplot2)
# Simulate and save before analysis.
set.seed(2107)
d <- expand.grid(week = 0:3, host = 1:72)
d$treatment <- rep(rep(c("Control", "Vaccine"), each = 36), each = 4)
individual <- rnorm(72, 0, .8)
d$probability <- plogis(-.4 + .25 * d$week -
  1.0 * (d$treatment == "Vaccine") + individual[d$host])
d$infected <- rbinom(nrow(d), 1, d$probability)
d$probability <- NULL
write.csv(d, file.path(output_dir, "data.csv"), row.names = FALSE)
d <- read.csv(file.path(output_dir, "data.csv"))
d$host <- factor(d$host)
d$treatment <- factor(d$treatment, levels = c("Control", "Vaccine"))
# Analysis
fit <- lme4::glmer(infected ~ treatment + week + (1 | host),
                   family = binomial, data = d,
                   control = lme4::glmerControl(optimizer = "bobyqa"))
summary(fit)
log_or_ci <- confint(fit, parm = "treatmentVaccine", method = "Wald")

# Primary figure
ragg::agg_png(file.path(output_dir, "plot.png"), width = 1600, height = 1000, res = 160, background = "white")
p <- ggplot(d, aes(week, infected, color = treatment)) +
  stat_summary(fun = mean, geom = "line", linewidth = 1.2) +
  stat_summary(fun = mean, geom = "point", size = 3.5) +
  scale_color_manual(values = c("#246A73", "#B7663E")) +
  scale_x_continuous(breaks = 0:3) +
  scale_y_continuous(limits = c(0, 1), breaks = seq(0, 1, .25)) +
  labs(x = "Week", y = "Observed fraction infected", color = "Treatment",
       caption = "Observed fractions summarize repeated hosts; model effects are conditional") +
  theme_classic(base_size = 16)
print(p)
dev.off()

# Results computed from the saved data.
b <- coef(summary(fit))["treatmentVaccine", ]
summary_lines <- c(sprintf("Conditional vaccine odds ratio = %.2f", exp(b[1])),
 sprintf("Approximate 95%% CI %.2f to %.2f", exp(log_or_ci[1]), exp(log_or_ci[2])),
 sprintf("Wald z = %.2f; p = %.4g", b[3], b[4]), "72 independent hosts; four repeated observations each")
report <- sprintf("At the same week and host random effect, vaccination multiplied infection odds by %.2f (approximate 95%% Wald CI %.2f to %.2f; p = %.4g). This is a conditional odds ratio, not a probability ratio or the population-average odds ratio estimated by a GEE.", exp(b[1]), exp(log_or_ci[1]), exp(log_or_ci[2]), b[4])
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
