# Run: Rscript analysis.R path/to/output-folder
args <- commandArgs(trailingOnly = TRUE)
out_dir <- if (length(args)) args[1] else "."
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

# Simulate and save the data before analyzing them.
set.seed(3114)
d <- data.frame(food = rep(c("Low", "High"), each = 120))
d$choice <- c(sample(c("Open", "Shelter", "Surface"), 120, TRUE,
                      prob = c(.25, .50, .25)),
              sample(c("Open", "Shelter", "Surface"), 120, TRUE,
                      prob = c(.50, .30, .20)))
write.csv(d, file.path(out_dir, "data.csv"), row.names = FALSE)

# Analyze the saved data.
d <- read.csv(file.path(out_dir, "data.csv"))

d$food <- factor(d$food, levels = c("Low", "High"))
d$choice <- factor(d$choice, levels = c("Open", "Shelter", "Surface"))
fit <- nnet::multinom(choice ~ food, data = d, trace = FALSE)
fit0 <- nnet::multinom(choice ~ 1, data = d, trace = FALSE)
LR <- 2 * as.numeric(logLik(fit) - logLik(fit0))
df <- attr(logLik(fit), "df") - attr(logLik(fit0), "df")
p_value <- pchisq(LR, df, lower.tail = FALSE)
probabilities <- predict(fit, data.frame(food = levels(d$food)), type = "probs")

# One primary plot.
ragg::agg_png(file.path(out_dir, "plot.png"),
              width = 1600, height = 1000, res = 160, background = "white")
p <- ggplot2::ggplot(d, ggplot2::aes(food, fill = choice)) +
  ggplot2::geom_bar(position = "fill", width = .65) +
  ggplot2::scale_fill_manual(values = c(Open = "#126887", Shelter = "#b96735",
                                       Surface = "#a4b3ad")) +
  ggplot2::labs(x = "Food availability", y = "Choice probability", fill = "Microhabitat") +
  ggplot2::theme_classic(base_size = 17) +
  ggplot2::theme(legend.position = "top")
print(p)
dev.off()

# Numerical output is generated from this analysis.
results <- list(
  preview = head(apply(d, 1, paste, collapse = " | "), 5),
  summary = c(sprintf("Low-food probabilities: %s", paste(sprintf("%.3f",probabilities[1,]),collapse=", ")), sprintf("High-food probabilities: %s", paste(sprintf("%.3f",probabilities[2,]),collapse=", ")), sprintf("Likelihood ratio = %.3f; df = %d", LR, df), sprintf("Joint p = %.4g", p_value)),
  report = sprintf("Predicted probabilities for open/shelter/surface were %s under low food and %s under high food. The joint likelihood-ratio test gives chi-square(%d) = %.2f, p = %.3g; it tests the whole distribution of choices.", paste(sprintf("%.2f",probabilities[1,]),collapse="/"), paste(sprintf("%.2f",probabilities[2,]),collapse="/"), df, LR, p_value),
  full_output = paste(capture.output(print(summary(fit))), collapse = "\n")
)
jsonlite::write_json(results, file.path(out_dir, "results.json"),
                     pretty = TRUE, auto_unbox = TRUE, digits = 6)
