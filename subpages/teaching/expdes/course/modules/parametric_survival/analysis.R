# Run: Rscript analysis.R /absolute/output/folder
args <- commandArgs(trailingOnly = TRUE)
output_dir <- if (length(args)) args[1] else "."
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

# Simulate and save before analysis.
set.seed(2113)
d <- data.frame(seed = 1:140,
                treatment = rep(c("Control", "Cold"), each = 70))
log_scale <- log(20) + .4 * (d$treatment == "Cold")
event_time <- rweibull(140, shape = 1.8, scale = exp(log_scale))
follow_up <- runif(140, 22, 50)
d$days <- pmin(event_time, follow_up)
d$event <- as.integer(event_time <= follow_up)
write.csv(d, file.path(output_dir, "data.csv"), row.names = FALSE)
d <- read.csv(file.path(output_dir, "data.csv"))
d$treatment <- factor(d$treatment, levels = c("Control", "Cold"))
# Analysis
fit <- survival::survreg(survival::Surv(days, event) ~ treatment,
                         data = d, dist = "weibull")
summary(fit)
time_ci <- exp(confint(fit)["treatmentCold", ])
km <- survival::survfit(survival::Surv(days, event) ~ treatment, data = d)
time_grid <- seq(0, 60, length.out = 150)
scales <- exp(predict(fit, newdata = data.frame(treatment = c("Control", "Cold")),
                      type = "lp"))
survival_control <- pweibull(time_grid, shape = 1 / fit$scale,
                            scale = scales[1], lower.tail = FALSE)
survival_cold <- pweibull(time_grid, shape = 1 / fit$scale,
                         scale = scales[2], lower.tail = FALSE)
# Primary figure
ragg::agg_png(file.path(output_dir, "plot.png"), width = 1600, height = 1000, res = 160, background = "white")
par(mar = c(5, 5, 2, 1), las = 1, bty = "l", cex = 1.15)
plot(km, col = c("#246A73", "#B7663E"), lty = 2, lwd = 1.4,
     conf.int = FALSE, mark.time = TRUE, xlim = c(0, 60),
     xlab = "Days since sowing", ylab = "Probability not yet germinated")
lines(time_grid, survival_control, col = "#246A73", lwd = 2.5)
lines(time_grid, survival_cold, col = "#B7663E", lwd = 2.5)
legend("topright", c("Control", "Cold", "Weibull model", "Kaplan–Meier"),
       col = c("#246A73", "#B7663E", "#172D34", "#172D34"),
       lty = c(1, 1, 1, 2), lwd = c(2.5, 2.5, 2.5, 1.4), bty = "n")
dev.off()

# Results computed from the saved data.
b <- summary(fit)$table["treatmentCold", ]
summary_lines <- c(sprintf("Cold/control time ratio = %.2f", exp(b[1])),
 sprintf("95%% CI %.2f to %.2f", time_ci[1], time_ci[2]),
 sprintf("Wald z = %.2f; p = %.4g", b[3], b[4]),
 sprintf("Fitted Weibull shape = %.2f", 1 / fit$scale))
report <- sprintf("Under the Weibull accelerated-failure-time model, cold-treated seeds had %.2f times the germination time of controls (95%% CI %.2f to %.2f; p = %.4g). This is a time ratio, not a Cox hazard ratio. The distributional fit and censoring assumptions remain part of the interpretation.", exp(b[1]), time_ci[1], time_ci[2], b[4])
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
