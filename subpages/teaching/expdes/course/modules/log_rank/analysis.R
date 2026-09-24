# Run: Rscript analysis.R /absolute/output/folder
args <- commandArgs(trailingOnly = TRUE)
output_dir <- if (length(args)) args[1] else "."
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

# Simulate and save before analysis.
set.seed(2111)
d <- data.frame(plant = 1:150,
                treatment = rep(c("Control", "Low", "High"), each = 50))
event_time <- rexp(150, rate = rep(c(.045, .03, .018), each = 50))
follow_up <- runif(150, 40, 80)
d$days <- pmin(event_time, follow_up)
d$event <- as.integer(event_time <= follow_up)
write.csv(d, file.path(output_dir, "data.csv"), row.names = FALSE)
d <- read.csv(file.path(output_dir, "data.csv"))
d$treatment <- factor(d$treatment, levels = c("Control", "Low", "High"))
# Analysis
test <- survival::survdiff(survival::Surv(days, event) ~ treatment,
                           data = d, rho = 0)
fit <- survival::survfit(survival::Surv(days, event) ~ treatment, data = d)
p_value <- pchisq(test$chisq, df = length(test$n) - 1, lower.tail = FALSE)

# Primary figure
ragg::agg_png(file.path(output_dir, "plot.png"), width = 1600, height = 1000, res = 160, background = "white")
par(mar = c(5, 5, 2, 1), las = 1, bty = "l", cex = 1.15)
plot(fit, col = c("#246A73", "#73969B", "#B7663E"), lwd = 2.5,
     mark.time = TRUE, conf.int = FALSE,
     xlab = "Days since pathogen exposure", ylab = "Probability still uninfected")
legend("topright", levels(d$treatment), lty = 1, lwd = 2.5,
       col = c("#246A73", "#73969B", "#B7663E"), bty = "n")
dev.off()

# Results computed from the saved data.
at_day30 <- summary(fit, times = 30)
summary_lines <- c(sprintf("Log-rank chi-square(%d) = %.2f", length(test$n) - 1, test$chisq),
 sprintf("Omnibus p = %.4g", p_value),
 sprintf("Control day-30 survival %.2f (95%% CI %.2f–%.2f)", at_day30$surv[1], at_day30$lower[1], at_day30$upper[1]),
 sprintf("High day-30 survival %.2f (95%% CI %.2f–%.2f)", at_day30$surv[3], at_day30$lower[3], at_day30$upper[3]))
report <- sprintf("The three infection-free survival curves differed (log-rank chi-square(%d) = %.2f, p = %.4g). Estimated day-30 infection-free fractions were %.2f in control and %.2f in high treatment. The omnibus test does not identify each differing pair and does not estimate a hazard ratio.", length(test$n) - 1, test$chisq, p_value, at_day30$surv[1], at_day30$surv[3])
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
