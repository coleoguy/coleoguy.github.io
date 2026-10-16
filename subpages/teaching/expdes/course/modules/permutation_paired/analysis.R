args <- commandArgs(trailingOnly = TRUE)
out_dir <- if (length(args)) args[1] else "generated"
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

# Simulate and save the observations
set.seed(240504)
baseline <- rnorm(28, 15, 2)
d <- data.frame(plant=1:28, control=baseline+rnorm(28,0,1),
                shaded=baseline-1.2+rnorm(28,0,1))
write.csv(d, file.path(out_dir, "data.csv"), row.names = FALSE)
d <- read.csv(file.path(out_dir, "data.csv"))

# Analysis from the saved CSV
difference <- d$shaded-d$control
observed <- mean(difference)
B <- 4999
null <- numeric(B)
for (i in 1:B) null[i] <- mean(difference * sample(c(-1,1), nrow(d), replace=TRUE))
p_value <- (1+sum(abs(null)>=abs(observed)))/(B+1)
result <- data.frame(mean_difference=observed, permutations=B, p=p_value)
summary_lines <- c(sprintf("Shaded − control = %.2f units", observed), sprintf("Two-sided permutation p = %.4g", p_value), "28 pairs; labels swap only within plants")
report <- sprintf("Within plants, shading changed mean photosynthesis by %.2f units (paired permutation p = %.3g). Swaps preserve plant pairing.", observed, p_value)

# Plot
ragg::agg_png(file.path(out_dir, "plot.png"), width=1600, height=1000, res=160, background="white")
par(mar=c(5,5,2,1), las=1, bty="l", cex=1.15)
matplot(c(1,2), t(as.matrix(d[c("control","shaded")])), type="l", lty=1,
        col="#99999980", xaxt="n", xlab="Leaf treatment", ylab="Photosynthesis (units)")
axis(1, 1:2, c("Control", "Shaded"))
points(rep(1,28), d$control, pch=16, col="#146A85")
points(rep(2,28), d$shaded, pch=16, col="#C56B3B")
dev.off()

preview <- capture.output(print(head(d, 4), row.names = FALSE))
full_output <- paste(capture.output(print(result)), collapse = "\n")
jsonlite::write_json(list(preview = preview, summary = summary_lines, report = report, full_output = full_output), file.path(out_dir, "results.json"), auto_unbox = TRUE, pretty = TRUE, digits = 12)
