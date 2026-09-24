# Run: Rscript analysis.R path/to/output-folder
args <- commandArgs(trailingOnly = TRUE)
out_dir <- if (length(args)) args[1] else "."
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

# Simulate and save the data before analyzing them.
set.seed(3113)
d <- data.frame(medium = rep(c("Low", "High"), each = 60),
                volume_ml = runif(120, .7, 1.3))
mu <- d$volume_ml * exp(2.4 + .5 * (d$medium == "High"))
clumps <- rpois(120, mu / 3)
d$colonies <- rpois(120, 3 * clumps)
write.csv(d, file.path(out_dir, "data.csv"), row.names = FALSE)

# Analyze the saved data.
d <- read.csv(file.path(out_dir, "data.csv"))

d$medium <- factor(d$medium, levels = c("Low", "High"))
fit <- glm(colonies ~ medium + offset(log(volume_ml)),
           data = d, family = quasipoisson)
b <- coef(fit)["mediumHigh"]
se <- sqrt(vcov(fit)["mediumHigh", "mediumHigh"])
critical <- qt(.975, df.residual(fit))
rate_ratio <- exp(b)
ci <- exp(b + c(-1, 1) * critical * se)
p_value <- summary(fit)$coefficients["mediumHigh", "Pr(>|t|)"]
dispersion <- summary(fit)$dispersion

# One primary plot.
ragg::agg_png(file.path(out_dir, "plot.png"),
              width = 1600, height = 1000, res = 160, background = "white")
par(mar = c(4, 5, 2, 1), las = 1)
beeswarm::beeswarm(colonies / volume_ml ~ medium, data = d,
  method = "swarm", pch = 16, cex = 1.1, col = c("#b96735", "#126887"),
  xlab = "Nutrient medium", ylab = "Colonies per milliliter", bty = "n")
group_means <- tapply(d$colonies / d$volume_ml, d$medium, mean)
points(1:2, group_means, pch = 18, cex = 2)
legend("topleft", "Black diamond: observed mean rate", pch = 18, bty = "n")
dev.off()

# Numerical output is generated from this analysis.
results <- list(
  preview = head(apply(d, 1, paste, collapse = " | "), 5),
  summary = c(sprintf("High / low mean rate ratio: %.3f", rate_ratio), sprintf("95%% t-based CI: %.3f to %.3f", ci[1], ci[2]), sprintf("Dispersion multiplier: %.3f", dispersion), sprintf("Quasi-Poisson t-test p = %.4g", p_value)),
  report = sprintf("High-nutrient medium had %.2f times the modeled colony rate of low-nutrient medium (95%% t-based CI %.2f–%.2f; p = %.3g). Estimated dispersion %.2f adjusts uncertainty for extra-Poisson variation.", rate_ratio, ci[1], ci[2], p_value, dispersion),
  full_output = paste(capture.output(print(summary(fit))), collapse = "\n")
)
jsonlite::write_json(results, file.path(out_dir, "results.json"),
                     pretty = TRUE, auto_unbox = TRUE, digits = 6)
