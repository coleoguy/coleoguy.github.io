# Run: Rscript analysis.R path/to/output-folder
args <- commandArgs(trailingOnly = TRUE)
out_dir <- if (length(args)) args[1] else "."
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

# Simulate and save the data before analyzing them.
set.seed(3112)
d <- data.frame(fish = 1:130, length_cm = runif(130, 18, 42))
mu <- exp(-.2 + .085 * d$length_cm)
d$parasites <- rnbinom(130, mu = mu, size = 2)
write.csv(d, file.path(out_dir, "data.csv"), row.names = FALSE)

# Analyze the saved data.
d <- read.csv(file.path(out_dir, "data.csv"))

fit <- MASS::glm.nb(parasites ~ length_cm, data = d)
b <- coef(fit)["length_cm"]
se <- sqrt(vcov(fit)["length_cm", "length_cm"])
p_value <- summary(fit)$coefficients["length_cm", "Pr(>|z|)"]
rate_ratio <- exp(5 * b)
ci <- exp(5 * (b + c(-1, 1) * 1.96 * se))
grid <- data.frame(length_cm = seq(18, 42, length.out = 120))
grid$mean_count <- predict(fit, grid, type = "response")

# One primary plot.
ragg::agg_png(file.path(out_dir, "plot.png"),
              width = 1600, height = 1000, res = 160, background = "white")
p <- ggplot2::ggplot(d, ggplot2::aes(length_cm, parasites)) +
  ggplot2::geom_point(alpha = .55, size = 2, color = "#555555") +
  ggplot2::geom_line(data = grid, ggplot2::aes(y = mean_count),
                    color = "#126887", linewidth = 1.3) +
  ggplot2::labs(x = "Fish length (cm)", y = "Parasite count") +
  ggplot2::theme_classic(base_size = 17)
print(p)
dev.off()

# Numerical output is generated from this analysis.
results <- list(
  preview = head(apply(d, 1, paste, collapse = " | "), 5),
  summary = c(sprintf("Mean count ratio per 5 cm: %.3f", rate_ratio), sprintf("95%% Wald CI: %.3f to %.3f", ci[1], ci[2]), sprintf("Wald p = %.4g", p_value), sprintf("Estimated negative-binomial theta: %.3f", fit$theta)),
  report = sprintf("A 5-cm increase in fish length multiplied expected parasite count by %.2f (95%% Wald CI %.2f–%.2f; Wald p = %.3g). Negative binomial variation allows more spread than a Poisson model.", rate_ratio, ci[1], ci[2], p_value),
  full_output = paste(capture.output(print(summary(fit))), collapse = "\n")
)
jsonlite::write_json(results, file.path(out_dir, "results.json"),
                     pretty = TRUE, auto_unbox = TRUE, digits = 6)
