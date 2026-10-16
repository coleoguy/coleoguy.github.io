# Run: Rscript analysis.R path/to/output-folder
args <- commandArgs(trailingOnly = TRUE)
out_dir <- if (length(args)) args[1] else "."
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

# Simulate and save the data before analyzing them.
set.seed(3110)
d <- data.frame(cross = 1:160, divergence = runif(160, 0, 8))
d$viable <- rbinom(160, 1, plogis(1.9 - .5 * d$divergence))
write.csv(d, file.path(out_dir, "data.csv"), row.names = FALSE)

# Analyze the saved data.
d <- read.csv(file.path(out_dir, "data.csv"))

fit <- glm(viable ~ divergence, data = d, family = binomial)
test <- drop1(fit, test = "Chisq")
p_value <- test["divergence", "Pr(>Chi)"]
b <- coef(fit)["divergence"]
se <- sqrt(vcov(fit)["divergence", "divergence"])
odds_ratio <- exp(b)
ci <- exp(b + c(-1, 1) * 1.96 * se)
grid <- data.frame(divergence = seq(0, 8, length.out = 120))
pred <- predict(fit, grid, type = "link", se.fit = TRUE)
grid$probability <- plogis(pred$fit)
grid$lower <- plogis(pred$fit - 1.96 * pred$se.fit)
grid$upper <- plogis(pred$fit + 1.96 * pred$se.fit)

# One primary plot.
ragg::agg_png(file.path(out_dir, "plot.png"),
              width = 1600, height = 1000, res = 160, background = "white")
p <- ggplot2::ggplot(d, ggplot2::aes(divergence, viable)) +
  ggplot2::geom_jitter(width = 0, height = .025, alpha = .35, color = "#126887") +
  ggplot2::geom_ribbon(data = grid, ggplot2::aes(x = divergence, ymin = lower,
    ymax = upper), inherit.aes = FALSE, fill = "#126887", alpha = .17) +
  ggplot2::geom_line(data = grid, ggplot2::aes(y = probability),
                    color = "#126887", linewidth = 1.2) +
  ggplot2::coord_cartesian(ylim = c(-.04, 1.04)) +
  ggplot2::labs(x = "Parental divergence (%)", y = "Hybrid viability probability") +
  ggplot2::theme_classic(base_size = 17)
print(p)
dev.off()

# Numerical output is generated from this analysis.
results <- list(
  preview = head(apply(d, 1, paste, collapse = " | "), 5),
  summary = c(sprintf("Divergence coefficient: %.3f", b), sprintf("Odds ratio per percentage point: %.3f", odds_ratio), sprintf("95%% Wald CI for odds ratio: %.3f to %.3f", ci[1], ci[2]), sprintf("Likelihood-ratio p = %.4g", p_value)),
  report = sprintf("Each additional percentage point of divergence multiplied modeled viability odds by %.2f (95%% Wald CI %.2f–%.2f; likelihood-ratio p = %.3g). The curve translates odds into probabilities; this association alone does not establish causation.", odds_ratio, ci[1], ci[2], p_value),
  full_output = paste(capture.output(print(summary(fit))), collapse = "\n")
)
jsonlite::write_json(results, file.path(out_dir, "results.json"),
                     pretty = TRUE, auto_unbox = TRUE, digits = 6)
