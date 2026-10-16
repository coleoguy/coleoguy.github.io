args <- commandArgs(trailingOnly = TRUE)
out_dir <- if (length(args)) args[1] else "generated"
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

# Simulate and save the observations
set.seed(240507)
d <- data.frame(colony=1:40, biomass_mg=rlnorm(40, log(12), .45))
write.csv(d, file.path(out_dir, "data.csv"), row.names = FALSE)
d <- read.csv(file.path(out_dir, "data.csv"))

# Analysis from the saved CSV
B <- 4999
boot_mean <- numeric(B)
for (i in 1:B) boot_mean[i] <- mean(sample(d$biomass_mg, replace=TRUE))
ci <- quantile(boot_mean, c(.025,.975))
result <- data.frame(mean=mean(d$biomass_mg), lower=ci[1], upper=ci[2])
summary_lines <- c(sprintf("Sample mean = %.2f mg",mean(d$biomass_mg)),sprintf("Percentile 95%% CI = %.2f to %.2f mg",ci[1],ci[2]),"4999 resamples of independent colonies")
report <- sprintf("Mean colony biomass is %.2f mg, with a percentile bootstrap 95%% interval of %.2f to %.2f mg. The interval estimates uncertainty in the mean, not the spread of individual colonies.",mean(d$biomass_mg),ci[1],ci[2])

# Plot
ragg::agg_png(file.path(out_dir, "plot.png"), width=1600, height=1000, res=160, background="white")
par(mar=c(5,5,2,1), las=1, bty="l", cex=1.15)
stripchart(d$biomass_mg, method="stack", pch=21, bg="#146A85",
           xlab="Colony biomass (mg)", main="Independent bacterial colonies")
abline(v=mean(d$biomass_mg), col="#C56B3B", lwd=2)
dev.off()

preview <- capture.output(print(head(d, 4), row.names = FALSE))
full_output <- paste(capture.output(print(result)), collapse = "\n")
jsonlite::write_json(list(preview = preview, summary = summary_lines, report = report, full_output = full_output), file.path(out_dir, "results.json"), auto_unbox = TRUE, pretty = TRUE, digits = 12)
