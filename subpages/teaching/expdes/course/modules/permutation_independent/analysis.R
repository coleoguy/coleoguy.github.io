args <- commandArgs(trailingOnly = TRUE)
out_dir <- if (length(args)) args[1] else "generated"
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

# Simulate and save the observations
set.seed(240503)
group <- rep(c("Control", "Warm"), each=25)
d <- data.frame(group, growth_mm=rnorm(50, 8+1.1*(group=="Warm"), 1.8))
write.csv(d, file.path(out_dir, "data.csv"), row.names = FALSE)
d <- read.csv(file.path(out_dir, "data.csv"))

# Analysis from the saved CSV
observed <- mean(d$growth_mm[d$group=="Warm"])-mean(d$growth_mm[d$group=="Control"])
B <- 4999
null <- numeric(B)
for (i in 1:B) {
  shuffled <- sample(d$group)
  null[i] <- mean(d$growth_mm[shuffled=="Warm"])-mean(d$growth_mm[shuffled=="Control"])
}
p_value <- (1+sum(abs(null)>=abs(observed)))/(B+1)
result <- data.frame(mean_difference=observed, permutations=B, p=p_value)
summary_lines <- c(sprintf("Warm − control = %.2f mm", observed), sprintf("Two-sided Monte Carlo p = %.4g", p_value), sprintf("%d permitted label shuffles", B))
report <- sprintf("Mean growth was %.2f mm higher under warming; the two-sided permutation p-value is %.3g from %d random assignments. The shuffle must match the design.", observed, p_value, B)

# Plot
ragg::agg_png(file.path(out_dir, "plot.png"), width=1600, height=1000, res=160, background="white")
par(mar=c(5,5,2,1), las=1, bty="l", cex=1.15)
beeswarm::beeswarm(growth_mm ~ group, data=d, pch=21,
  bg=c("#146A85", "#C56B3B"), cex=1.1,
  xlab="Randomized condition", ylab="Growth (mm)")
points(1:2, tapply(d$growth_mm, d$group, mean), pch=18, cex=1.6)
dev.off()

preview <- capture.output(print(head(d, 4), row.names = FALSE))
full_output <- paste(capture.output(print(result)), collapse = "\n")
jsonlite::write_json(list(preview = preview, summary = summary_lines, report = report, full_output = full_output), file.path(out_dir, "results.json"), auto_unbox = TRUE, pretty = TRUE, digits = 12)
