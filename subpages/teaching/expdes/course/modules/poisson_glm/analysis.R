# Run: Rscript analysis.R path/to/output-folder
args <- commandArgs(trailingOnly = TRUE)
out_dir <- if (length(args)) args[1] else "."
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

# Simulate and save the data before analyzing them.
set.seed(3111)
d <- data.frame(transect = 1:120, cover = runif(120, 0, 80),
                area = runif(120, 2, 8))
d$recruits <- rpois(120, d$area * exp(-.5 + .016 * d$cover))
write.csv(d, file.path(out_dir, "data.csv"), row.names = FALSE)

# Analyze the saved data.
d <- read.csv(file.path(out_dir, "data.csv"))

fit <- glm(recruits ~ cover + offset(log(area)), data = d,
           family = poisson)
p_value <- drop1(fit, test = "Chisq")["cover", "Pr(>Chi)"]
b <- coef(fit)["cover"]
se <- sqrt(vcov(fit)["cover", "cover"])
rate_ratio <- exp(10 * b)
ci <- exp(10 * (b + c(-1, 1) * 1.96 * se))
dispersion <- sum(residuals(fit, type = "pearson")^2) / df.residual(fit)
grid <- data.frame(cover = seq(0, 80, length.out = 120), area = 1)
grid$rate <- predict(fit, grid, type = "response")

# One primary plot.
ragg::agg_png(file.path(out_dir, "plot.png"),
              width = 1600, height = 1000, res = 160, background = "white")
p <- ggplot2::ggplot(d, ggplot2::aes(cover, recruits / area)) +
  ggplot2::geom_point(alpha = .55, size = 2, color = "#555555") +
  ggplot2::geom_line(data = grid, ggplot2::aes(y = rate),
                    color = "#126887", linewidth = 1.3) +
  ggplot2::labs(x = "Live coral cover (%)", y = "Recruits per square meter") +
  ggplot2::theme_classic(base_size = 17)
print(p)
dev.off()

# Numerical output is generated from this analysis.
results <- list(
  preview = head(apply(d, 1, paste, collapse = " | "), 5),
  summary = c(sprintf("Rate ratio per 10 cover points: %.3f", rate_ratio), sprintf("95%% Wald CI: %.3f to %.3f", ci[1], ci[2]), sprintf("Likelihood-ratio p = %.4g", p_value), sprintf("Pearson dispersion diagnostic: %.3f", dispersion)),
  report = sprintf("A 10-percentage-point increase in coral cover multiplied modeled recruit density by %.2f (95%% Wald CI %.2f–%.2f; p = %.3g). Area is handled as exposure; the observational association is not a causal effect.", rate_ratio, ci[1], ci[2], p_value),
  full_output = paste(capture.output(print(summary(fit))), collapse = "\n")
)
jsonlite::write_json(results, file.path(out_dir, "results.json"),
                     pretty = TRUE, auto_unbox = TRUE, digits = 6)
