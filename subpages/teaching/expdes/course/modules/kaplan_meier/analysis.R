# Run: Rscript analysis.R /absolute/output/folder
args <- commandArgs(trailingOnly = TRUE)
output_dir <- if (length(args)) args[1] else "."
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

# Simulate and save before analysis.
set.seed(2110)
d <- data.frame(seedling = 1:120)
event_time <- rexp(120, rate = .018)
follow_up <- runif(120, 35, 100)
d$days <- pmin(event_time, follow_up)
d$event <- as.integer(event_time <= follow_up)
write.csv(d, file.path(output_dir, "data.csv"), row.names = FALSE)
d <- read.csv(file.path(output_dir, "data.csv"))
# Analysis
fit <- survival::survfit(survival::Surv(days, event) ~ 1,
                         data = d, conf.type = "log-log")
at_day40 <- summary(fit, times = 40)
print(at_day40)

# Primary figure
ragg::agg_png(file.path(output_dir, "plot.png"), width = 1600, height = 1000, res = 160, background = "white")
par(mar = c(5, 5, 2, 1), las = 1, bty = "l", cex = 1.15)
plot(fit, col = "#246A73", lwd = 2.5, conf.int = TRUE,
     mark.time = TRUE, xlab = "Days since establishment",
     ylab = "Estimated survival probability", xlim = c(0, 100))
abline(v = 40, lty = 3, col = "#B7663E")
legend("topright", c("Survival estimate", "95% confidence limits", "Censored observation"),
       col = c("#246A73", "#246A73", "#246A73"),
       lty = c(1, 2, NA), pch = c(NA, NA, 3), bty = "n")
dev.off()

# Results computed from the saved data.
summary_lines <- c(sprintf("120 seedlings; %d events; %d censored", sum(d$event), sum(d$event == 0)),
 sprintf("Estimated survival at day 40 = %.3f", at_day40$surv),
 sprintf("95%% CI %.3f to %.3f", at_day40$lower, at_day40$upper),
 sprintf("Still at risk at day 40: %d", at_day40$n.risk))
report <- sprintf("Estimated day-40 survival was %.1f%% (95%% CI %.1f%% to %.1f%%), with %d seedlings still at risk. Kaplan–Meier estimates survival rather than testing a null. Censored seedlings contribute information until their final follow-up; they are not assumed to survive forever.", 100 * at_day40$surv, 100 * at_day40$lower, 100 * at_day40$upper, at_day40$n.risk)
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
