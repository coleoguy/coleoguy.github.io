# Run: Rscript analysis.R /absolute/output/folder
args <- commandArgs(trailingOnly = TRUE)
output_dir <- if (length(args)) args[1] else "."
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
library(ggplot2)
# Simulate and save before analysis.
set.seed(2114)
d <- expand.grid(day = 1:4, plant = 1:48)
d$habitat <- rep(rep(c("Open", "Sheltered"), each = 24), each = 4)
d$minutes <- sample(20:60, nrow(d), replace = TRUE)
individual <- rnorm(48, 0, .45)
rate <- exp(-2.0 + .55 * (d$habitat == "Sheltered") +
              .06 * d$day + individual[d$plant])
d$visits <- rnbinom(nrow(d), mu = d$minutes * rate, size = 5)
write.csv(d, file.path(output_dir, "data.csv"), row.names = FALSE)
d <- read.csv(file.path(output_dir, "data.csv"))
d$plant <- factor(d$plant)
d$habitat <- factor(d$habitat, levels = c("Open", "Sheltered"))
# Analysis
poisson_fit <- lme4::glmer(visits ~ habitat + day +
  offset(log(minutes)) + (1 | plant), family = poisson, data = d,
  control = lme4::glmerControl(optimizer = "bobyqa"))
fit <- lme4::glmer.nb(visits ~ habitat + day +
  offset(log(minutes)) + (1 | plant), data = d,
  control = lme4::glmerControl(optimizer = "bobyqa"))
summary(fit)
log_ratio_ci <- confint(fit, parm = "habitatSheltered", method = "Wald")

# Primary figure
ragg::agg_png(file.path(output_dir, "plot.png"), width = 1600, height = 1000, res = 160, background = "white")
p <- ggplot(d, aes(day, visits / minutes, color = habitat)) +
  geom_line(aes(group = plant), alpha = .18) +
  geom_point(alpha = .35, size = 1.6) +
  stat_summary(fun = mean, geom = "line", linewidth = 1.7) +
  scale_color_manual(values = c("#246A73", "#B7663E")) +
  scale_x_continuous(breaks = 1:4) +
  labs(x = "Observation day", y = "Observed visits per minute", color = "Habitat",
       caption = "Rates display unequal effort; the model analyzes counts with an exposure offset") +
  theme_classic(base_size = 16)
print(p)
dev.off()

# Results computed from the saved data.
b <- coef(summary(fit))["habitatSheltered", ]
summary_lines <- c(sprintf("Conditional sheltered/open rate ratio = %.2f", exp(b[1])),
 sprintf("Approximate 95%% CI %.2f to %.2f", exp(log_ratio_ci[1]), exp(log_ratio_ci[2])),
 sprintf("Wald z = %.2f; p = %.4g", b[3], b[4]),
 sprintf("Poisson AIC %.1f; negative-binomial AIC %.1f", AIC(poisson_fit), AIC(fit)))
report <- sprintf("In the negative-binomial mixed model, sheltered plants had %.2f times the visit rate of open plants at the same day and random effect (approximate 95%% Wald CI %.2f to %.2f; p = %.4g). Minutes are an exposure offset; plant intercepts model repeated observations. Extra conditional variation motivates checking the negative-binomial variant, not automatically selecting it from a single cutoff.", exp(b[1]), exp(log_ratio_ci[1]), exp(log_ratio_ci[2]), b[4])
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
