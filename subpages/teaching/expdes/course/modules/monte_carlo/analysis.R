args <- commandArgs(trailingOnly = TRUE)
out_dir <- if (length(args)) args[1] else "generated"
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

# Simulate and save the observations
set.seed(240505)
d <- data.frame(gene=1:80, on_X=rbinom(80, 1, .32))
write.csv(d, file.path(out_dir, "data.csv"), row.names = FALSE)
d <- read.csv(file.path(out_dir, "data.csv"))

# Analysis from the saved CSV
observed <- sum(d$on_X)
p0 <- .20; n <- nrow(d); B <- 9999
null <- rbinom(B, size=n, prob=p0)
p_value <- (1+sum(abs(null-n*p0)>=abs(observed-n*p0)))/(B+1)
result <- data.frame(observed_X=observed, expected_X=n*p0, monte_carlo_p=p_value)
summary_lines <- c(sprintf("Observed on X: %d of %d",observed,n), sprintf("Expected under null: %.1f",n*p0), sprintf("Two-sided Monte Carlo p = %.4g",p_value))
report <- sprintf("%d of %d genes were on X, compared with null expectation %.1f. The absolute count-deviation Monte Carlo test gives p = %.3g. Here the null assigns each independent gene probability 0.20 of being on X.",observed,n,n*p0,p_value)

# Plot
ragg::agg_png(file.path(out_dir, "plot.png"), width=1600, height=1000, res=160, background="white")
par(mar=c(5,5,2,1), las=1, bty="l", cex=1.15)
barplot(c(sum(d$on_X==0),sum(d$on_X==1)), names.arg=c("Autosomes", "X chromosome"),
        col=c("#9AA6AC","#146A85"), border=NA, ylab="Candidate genes")
dev.off()

preview <- capture.output(print(head(d, 4), row.names = FALSE))
full_output <- paste(capture.output(print(result)), collapse = "\n")
jsonlite::write_json(list(preview = preview, summary = summary_lines, report = report, full_output = full_output), file.path(out_dir, "results.json"), auto_unbox = TRUE, pretty = TRUE, digits = 12)
