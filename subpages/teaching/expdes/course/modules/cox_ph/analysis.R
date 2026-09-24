# Run: Rscript analysis.R /absolute/output/folder
args <- commandArgs(trailingOnly = TRUE)
output_dir <- if (length(args)) args[1] else "."
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

# Simulate and save before analysis.
set.seed(2112)
d <- data.frame(seedling = 1:180, dose = runif(180, 0, 3),
                temperature = rnorm(180, 25, 2))
rate <- exp(log(.035) - .45 * d$dose + .12 * (d$temperature - 25))
event_time <- rexp(180, rate = rate)
follow_up <- runif(180, 45, 100)
d$days <- pmin(event_time, follow_up)
d$event <- as.integer(event_time <= follow_up)
write.csv(d, file.path(output_dir, "data.csv"), row.names = FALSE)
d <- read.csv(file.path(output_dir, "data.csv"))
# Analysis
fit <- survival::coxph(survival::Surv(days, event) ~ dose + temperature,
                       data = d, x = TRUE)
summary(fit)
ph_check <- survival::cox.zph(fit)
hazard_ci <- exp(confint(fit)["dose", ])
curves <- survival::survfit(fit,
  newdata = data.frame(dose = c(0, 1.5, 3), temperature = 25))
# Primary figure
ragg::agg_png(file.path(output_dir, "plot.png"), width = 1600, height = 1000, res = 160, background = "white")
par(mar = c(5, 5, 2, 1), las = 1, bty = "l", cex = 1.15)
plot(curves, col = c("#246A73", "#73969B", "#B7663E"), lwd = 2.5,
     conf.int = FALSE, xlab = "Days since exposure",
     ylab = "Fitted survival probability")
legend("topright", c("Dose 0", "Dose 1.5", "Dose 3"), lty = 1, lwd = 2.5,
       col = c("#246A73", "#73969B", "#B7663E"), bty = "n")
mtext("Fitted curves at 25°C", side = 3, line = .1, adj = 0)
dev.off()

# Results computed from the saved data.
b <- coef(summary(fit))["dose", ]
summary_lines <- c(sprintf("Dose hazard ratio per unit = %.2f", exp(b[1])),
 sprintf("95%% CI %.2f to %.2f", hazard_ci[1], hazard_ci[2]),
 sprintf("Wald z = %.2f; p = %.4g", b[4], b[5]),
 sprintf("PH diagnostic global p = %.4g", ph_check$table["GLOBAL", "p"]))
report <- sprintf("Each dose unit multiplied the death hazard by %.2f at the same temperature (95%% CI %.2f to %.2f; Wald p = %.4g). This is an instantaneous-risk comparison among seedlings still alive, not a survival probability ratio. The fitted constant hazard ratio must be checked over time.", exp(b[1]), hazard_ci[1], hazard_ci[2], b[5])
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
