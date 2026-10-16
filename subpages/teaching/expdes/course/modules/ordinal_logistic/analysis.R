# Run: Rscript analysis.R path/to/output-folder
args <- commandArgs(trailingOnly = TRUE)
out_dir <- if (length(args)) args[1] else "."
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

# Simulate and save the data before analyzing them.
set.seed(3115)
d <- data.frame(fragment = 1:180, temperature = runif(180, 26, 32))
latent <- .8 * (d$temperature - 28) + rlogis(180)
d$severity <- cut(latent, c(-Inf, -1, .7, 2.2, Inf),
                  labels = c("None", "Mild", "Moderate", "Severe"))
write.csv(d, file.path(out_dir, "data.csv"), row.names = FALSE)

# Analyze the saved data.
d <- read.csv(file.path(out_dir, "data.csv"))

d$severity <- ordered(d$severity, levels = c("None", "Mild", "Moderate", "Severe"))
fit <- ordinal::clm(severity ~ temperature, data = d, link = "logit")
fit0 <- ordinal::clm(severity ~ 1, data = d, link = "logit")
LR <- 2 * as.numeric(logLik(fit) - logLik(fit0))
p_value <- pchisq(LR, df = 1, lower.tail = FALSE)
b <- fit$beta["temperature"]
se <- sqrt(vcov(fit)["temperature", "temperature"])
odds_ratio <- exp(b)
ci <- exp(b + c(-1, 1) * 1.96 * se)
grid <- data.frame(temperature = seq(26, 32, length.out = 100))
probabilities <- predict(fit, newdata = grid, type = "prob")$fit
plot_data <- data.frame(temperature = rep(grid$temperature, 4), severity = rep(colnames(probabilities), each = 100), probability = c(probabilities))
plot_data$severity <- factor(plot_data$severity, levels = levels(d$severity))

# One primary plot.
ragg::agg_png(file.path(out_dir, "plot.png"),
              width = 1600, height = 1000, res = 160, background = "white")
p <- ggplot2::ggplot(plot_data, ggplot2::aes(temperature, probability,
                                            color = severity)) +
  ggplot2::geom_line(linewidth = 1.3) +
  ggplot2::scale_color_manual(values = c(None = "#6b8581", Mild = "#126887",
                                        Moderate = "#b96735", Severe = "#682b35")) +
  ggplot2::ylim(0, 1) +
  ggplot2::labs(x = "Temperature (°C)", y = "Predicted category probability",
                color = "Bleaching severity") +
  ggplot2::theme_classic(base_size = 17) +
  ggplot2::theme(legend.position = "top")
print(p)
dev.off()

# Numerical output is generated from this analysis.
results <- list(
  preview = head(apply(d, 1, paste, collapse = " | "), 5),
  summary = c(sprintf("Common odds ratio per 1°C: %.3f", odds_ratio), sprintf("95%% Wald CI: %.3f to %.3f", ci[1], ci[2]), sprintf("Likelihood ratio = %.3f; df = 1", LR), sprintf("p = %.4g", p_value)),
  report = sprintf("Each 1°C increase multiplied the modeled odds of higher rather than lower bleaching severity by %.2f (95%% Wald CI %.2f–%.2f; likelihood-ratio p = %.3g), assuming the same temperature effect across thresholds.",odds_ratio,ci[1],ci[2],p_value),
  full_output = paste(capture.output(print(summary(fit))), collapse = "\n")
)
jsonlite::write_json(results, file.path(out_dir, "results.json"),
                     pretty = TRUE, auto_unbox = TRUE, digits = 6)
