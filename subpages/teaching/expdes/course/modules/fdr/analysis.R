args <- commandArgs(trailingOnly = TRUE)
out_dir <- if (length(args)) args[1] else "generated"
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

# Simulate and save the observations
set.seed(240509)
gene <- rep(1:40, each=24)
treated <- rep(rep(0:1, each=12), 40)
effect <- rep(c(rep(1.1,8), rep(0,32)), each=24)
d <- data.frame(gene, treated, expression=rnorm(960, 6+effect*treated, 1))
write.csv(d, file.path(out_dir, "data.csv"), row.names = FALSE)
d <- read.csv(file.path(out_dir, "data.csv"))

# Analysis from the saved CSV
p_value <- difference <- numeric(40)
for (i in 1:40) {
  x <- d$expression[d$gene==i & d$treated==1]
  y <- d$expression[d$gene==i & d$treated==0]
  p_value[i] <- t.test(x,y)$p.value
  difference[i] <- mean(x)-mean(y)
}
adjusted <- p.adjust(p_value, method="BH")
result <- data.frame(gene=1:40, difference, p_value, adjusted)
summary_lines <- c(sprintf("Unadjusted p<.05: %d genes",sum(p_value<.05)),sprintf("Adjusted p<.05: %d genes",sum(adjusted<.05)),"One declared family of 40 gene comparisons")
report <- sprintf("Of 40 gene comparisons, %d have BH-adjusted p-values below 0.05. Under its assumptions, this rule controls the expected false-discovery proportion among selected genes at 5%%. Interpret the gene effect sizes alongside the adjusted evidence.",sum(adjusted<.05))

# Plot
ragg::agg_png(file.path(out_dir, "plot.png"), width=1600, height=1000, res=160, background="white")
par(mar=c(5,5,2,1), las=1, bty="l", cex=1.15)
plot(difference, -log10(p_value), pch=21,
     bg=ifelse(adjusted<.05, "#C56B3B", "#A7B6BD"),
     xlab="Treatment − control (log2 expression)", ylab="−log10(unadjusted p)")
abline(v=0, lty=2, col="gray60")
legend("topleft", c("Passes adjustment", "Does not pass"),
       pch=21, pt.bg=c("#C56B3B", "#A7B6BD"), bty="n")
dev.off()

preview <- capture.output(print(head(d, 4), row.names = FALSE))
full_output <- paste(capture.output(print(result)), collapse = "\n")
jsonlite::write_json(list(preview = preview, summary = summary_lines, report = report, full_output = full_output), file.path(out_dir, "results.json"), auto_unbox = TRUE, pretty = TRUE, digits = 12)
