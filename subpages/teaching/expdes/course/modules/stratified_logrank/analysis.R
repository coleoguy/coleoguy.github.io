args <- commandArgs(trailingOnly = TRUE)
out_dir <- if (length(args)) args[1] else "generated"
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

# Simulate and save the observations
set.seed(240501)
stratum <- rep(1:12, each=10)
treatment <- rep(rep(c("Control", "Stress"), each=5), 12)
rate <- rep(seq(.025, .08, length.out=12), each=10)
event_time <- rexp(120, rate * ifelse(treatment=="Stress", 1.6, 1))
d <- data.frame(stratum, treatment, time=pmin(event_time, 30), event=event_time<=30)
write.csv(d, file.path(out_dir, "data.csv"), row.names = FALSE)
d <- read.csv(file.path(out_dir, "data.csv"))

# Analysis from the saved CSV
result <- survival::survdiff(survival::Surv(time, event) ~ treatment + strata(stratum), data=d)
p_value <- pchisq(result$chisq, df=1, lower.tail=FALSE)
summary_lines <- c(sprintf("Stratified chi-square = %.3f", result$chisq), sprintf("p = %.4g", p_value), "12 rearing blocks; 120 larvae")
report <- sprintf("After comparison within rearing blocks, chi-square = %.2f (1 df), p = %.3g. The test compares survival; estimate the direction and magnitude with survival curves or a suitable model.", result$chisq, p_value)

# Plot
ragg::agg_png(file.path(out_dir, "plot.png"), width=1600, height=1000, res=160, background="white")
par(mar=c(5,5,2,1), las=1, bty="l", cex=1.15)
fit <- survival::survfit(survival::Surv(time, event) ~ treatment, data=d)
plot(fit, col=c("#146A85", "#C56B3B"), lwd=3, conf.int=FALSE,
     xlab="Days since exposure", ylab="Probability still alive", mark.time=TRUE)
legend("topright", c("Control", "Stress"), col=c("#146A85", "#C56B3B"), lwd=3, bty="n")
dev.off()

preview <- capture.output(print(head(d, 4), row.names = FALSE))
full_output <- paste(capture.output(print(result)), collapse = "\n")
jsonlite::write_json(list(preview = preview, summary = summary_lines, report = report, full_output = full_output), file.path(out_dir, "results.json"), auto_unbox = TRUE, pretty = TRUE, digits = 12)
