# Run: Rscript analysis.R /absolute/output/folder
args <- commandArgs(trailingOnly = TRUE)
output_dir <- if (length(args)) args[1] else "."
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
library(ggplot2)
# Simulate and save before analysis.
set.seed(2109)
d <- expand.grid(visit = 1:3, fish = 1:70)
d$treatment <- rep(rep(c("Control", "Stress"), each = 35), each = 3)
individual <- rnorm(70, 0, .8)
latent <- .8 * (d$treatment == "Stress") + .15 * d$visit +
  individual[d$fish] + rlogis(nrow(d))
d$score <- cut(latent, c(-Inf, -.8, .3, 1.3, Inf),
               labels = c("None", "Mild", "Moderate", "High"))
write.csv(d, file.path(output_dir, "data.csv"), row.names = FALSE)
d <- read.csv(file.path(output_dir, "data.csv"))
d$fish <- factor(d$fish)
d$treatment <- factor(d$treatment, levels = c("Control", "Stress"))
d$score <- ordered(d$score, levels = c("None", "Mild", "Moderate", "High"))
# Analysis
fit <- ordinal::clmm(score ~ treatment + visit + (1 | fish),
                     data = d, link = "logit", Hess = TRUE)
summary(fit)
b <- coef(summary(fit))["treatmentStress", ]
log_or_ci <- b[1] + c(-1, 1) * qnorm(.975) * b[2]

# Primary figure
ragg::agg_png(file.path(output_dir, "plot.png"), width = 1600, height = 1000, res = 160, background = "white")
p <- ggplot(d, aes(treatment, fill = score)) +
  geom_bar(position = "fill", width = .7) +
  facet_wrap(~ visit, labeller = label_both) +
  scale_fill_manual(values = c("#D9E8E7", "#73969B", "#D7A583", "#B7663E"),
                    drop = FALSE) +
  labs(x = "Treatment", y = "Observed fraction", fill = "Stress score",
       caption = "Ordered categories retain their order; distances between labels are not assumed equal") +
  theme_classic(base_size = 16) + theme(legend.position = "bottom")
print(p)
dev.off()

# Results computed from the saved data.
summary_lines <- c(sprintf("Conditional higher-score odds ratio = %.2f", exp(b[1])),
 sprintf("Approximate 95%% CI %.2f to %.2f", exp(log_or_ci[1]), exp(log_or_ci[2])),
 sprintf("Wald z = %.2f; p = %.4g", b[3], b[4]),
 "70 fish; three repeated ordinal scores each")
report <- sprintf("At the same visit and fish random effect, stress treatment multiplied the odds of being above any score threshold by %.2f (approximate 95%% Wald CI %.2f to %.2f; p = %.4g). The proportional-odds model uses a common effect across thresholds; category labels are ordered, not equally spaced measurements.", exp(b[1]), exp(log_or_ci[1]), exp(log_or_ci[2]), b[4])
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
