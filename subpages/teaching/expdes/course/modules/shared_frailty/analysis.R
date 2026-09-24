args <- commandArgs(trailingOnly = TRUE)
out_dir <- if (length(args)) args[1] else "generated"
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

# Simulate and save the observations
set.seed(240502)
population <- rep(1:24, each=10)
stress <- rep(rep(0:1, each=5), 24)
frailty <- rgamma(24, shape=2, rate=2)
event_time <- rexp(240, .04 * frailty[population] * exp(.5*stress))
d <- data.frame(population, stress, time=pmin(event_time, 35), event=event_time<=35)
write.csv(d, file.path(out_dir, "data.csv"), row.names = FALSE)
d <- read.csv(file.path(out_dir, "data.csv"))

# Analysis from the saved CSV
result <- survival::coxph(survival::Surv(time, event) ~ stress + frailty(population), data=d)
b <- coef(result)["stress"]
se <- sqrt(vcov(result)["stress", "stress"])
hr <- exp(b); ci <- exp(b+c(-1,1)*1.96*se)
p_value <- 2*pnorm(-abs(b/se))
summary_lines <- c(sprintf("Conditional hazard ratio = %.2f", hr), sprintf("Wald 95%% CI %.2f to %.2f", ci[1], ci[2]), sprintf("Wald p = %.4g", p_value))
report <- sprintf("Stress has an estimated hazard ratio of %.2f conditional on population frailty (95%% Wald CI %.2f to %.2f; p = %.3g). Population frailty represents shared differences in baseline risk.", hr, ci[1], ci[2], p_value)

# Plot
ragg::agg_png(file.path(out_dir, "plot.png"), width=1600, height=1000, res=160, background="white")
par(mar=c(5,5,2,1), las=1, bty="l", cex=1.15)
fit <- survival::survfit(survival::Surv(time, event) ~ stress, data=d)
plot(fit, col=c("#146A85", "#C56B3B"), lwd=3, conf.int=FALSE,
     xlab="Days since exposure", ylab="Probability still alive", mark.time=TRUE)
legend("topright", c("Control", "Stress"), col=c("#146A85", "#C56B3B"), lwd=3, bty="n")
dev.off()

preview <- capture.output(print(head(d, 4), row.names = FALSE))
full_output <- paste(capture.output(print(result)), collapse = "\n")
jsonlite::write_json(list(preview = preview, summary = summary_lines, report = report, full_output = full_output), file.path(out_dir, "results.json"), auto_unbox = TRUE, pretty = TRUE, digits = 12)
