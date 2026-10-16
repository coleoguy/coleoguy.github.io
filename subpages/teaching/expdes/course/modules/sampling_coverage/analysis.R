args <- commandArgs(trailingOnly = TRUE)
out_dir <- if (length(args)) args[1] else "generated"
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

# Simulate and save the observations
set.seed(240506)
d <- data.frame(experiment=rep(1:1000, each=25),
                waiting_days=rexp(25000, rate=.2))
write.csv(d, file.path(out_dir, "data.csv"), row.names = FALSE)
d <- read.csv(file.path(out_dir, "data.csv"))

# Analysis from the saved CSV
low <- high <- estimate <- numeric(1000)
for (i in 1:1000) {
  x <- d$waiting_days[d$experiment==i]
  estimate[i] <- mean(x)
  margin <- qt(.975, length(x)-1)*sd(x)/sqrt(length(x))
  low[i] <- mean(x)-margin; high[i] <- mean(x)+margin
}
covered <- low<=5 & high>=5
result <- data.frame(experiment=1:1000, estimate, low, high, covered)
summary_lines <- c(sprintf("Mean estimated waiting time: %.2f days",mean(estimate)),sprintf("Observed 95%% t-interval coverage: %.1f%%",100*mean(covered)),"True population mean: 5 days")
report <- sprintf("Across 1000 experiments of 25 cells, %.1f%% of nominal 95%% t intervals contain the true mean of 5 days. Coverage is evaluated against that truth, not each interval’s own sample mean.",100*mean(covered))

# Plot
ragg::agg_png(file.path(out_dir, "plot.png"), width=1600, height=1000, res=160, background="white")
par(mar=c(5,5,2,1), las=1, bty="l", cex=1.15)
plot(NA, xlim=range(c(low[1:60], high[1:60])), ylim=c(1,60),
     xlab="Mean waiting time and 95% t interval (days)", ylab="Simulated experiment")
abline(v=5, lty=2, lwd=2)
segments(low[1:60], 1:60, high[1:60], 1:60,
         col=ifelse(covered[1:60], "#146A85", "#C56B3B"), lwd=2)
points(estimate[1:60], 1:60, pch=16, cex=.5)
dev.off()

preview <- capture.output(print(head(d, 4), row.names = FALSE))
full_output <- paste(capture.output(print(result)), collapse = "\n")
jsonlite::write_json(list(preview = preview, summary = summary_lines, report = report, full_output = full_output), file.path(out_dir, "results.json"), auto_unbox = TRUE, pretty = TRUE, digits = 12)
