# Run: Rscript analysis.R /absolute/output/folder
args <- commandArgs(trailingOnly = TRUE)
output_dir <- if (length(args)) args[1] else "."
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

# Simulate and save before analysis.
set.seed(1107)
d <- data.frame(treatment = rep(c("Control", "Strain A", "Strain B"), each = 24),
                damage = c(rbinom(24, 8, .25), rbinom(24, 8, .40),
                           rbinom(24, 8, .58)))
write.csv(d, file.path(output_dir, "data.csv"), row.names = FALSE)
d <- read.csv(file.path(output_dir, "data.csv"))
# Analysis
d$treatment <- factor(d$treatment, levels = c("Control", "Strain A", "Strain B"))
fit <- kruskal.test(damage ~ treatment, data = d)

# Primary figure
ragg::agg_png(file.path(output_dir, "plot.png"), width = 1600, height = 1000, res = 170)
par(mar = c(5, 5, 2, 1), las = 1, bty = "l", cex = 1.15)
x <- as.integer(d$treatment)
plot(jitter(x, amount = .14), d$damage, pch = 21,
     bg = c("#246A73", "#B7663E", "#73649A")[x], col = "white",
     xaxt = "n", yaxt = "n", xlim = c(.6, 3.4), xlab = "Pathogen treatment", ylab = "Damage score")
axis(1, 1:3, levels(d$treatment)); axis(2, 0:8)
med <- tapply(d$damage, d$treatment, median)
segments(1:3 - .18, med, 1:3 + .18, med, lwd = 4)
dev.off()

# Results are computed from the saved dataset.
summary_lines <- c(sprintf("Kruskal–Wallis chi-square = %.2f; df = %.0f; p = %.4g", fit$statistic, fit$parameter, fit$p.value),
 paste("Observed medians:", paste(names(med), med, collapse = "; ")),
 "The omnibus result does not identify which pairs differ.")
report <- sprintf("Damage-score distributions were compared using Kruskal–Wallis: chi-square(%.0f) = %.2f, p = %.4g. An omnibus result concerns at least one group difference; it does not identify a particular pair or generally establish different medians.", fit$parameter, fit$statistic, fit$p.value)
preview <- head(capture.output(print(head(d, 4), row.names = FALSE)), 5)
full_output <- paste(capture.output(print(fit)), collapse = "\n")
jsonlite::write_json(list(preview = preview, summary = summary_lines, report = report, full_output = full_output),
 file.path(output_dir, "results.json"), auto_unbox = TRUE, pretty = TRUE, digits = 8)
cat(report, "\n")
