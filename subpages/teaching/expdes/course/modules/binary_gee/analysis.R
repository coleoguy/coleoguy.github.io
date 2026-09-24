# Run: Rscript analysis.R path/to/output-folder
args <- commandArgs(trailingOnly = TRUE)
out_dir <- if (length(args)) args[1] else "."
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

# Simulate and save the data before analyzing them.
set.seed(3116)
shared <- rep(rnorm(80), each = 4)
d <- data.frame(animal = rep(1:80, each = 4),
  week = rep(0:3, 80), vaccine = rep(rep(c("Control", "Vaccinated"), each = 40), each = 4))
z <- sqrt(.3) * shared + sqrt(.7) * rnorm(320)
p <- plogis(-.6 + .35 * d$week - .9 * (d$vaccine == "Vaccinated"))
d$infected <- as.integer(pnorm(z) < p)
write.csv(d, file.path(out_dir, "data.csv"), row.names = FALSE)

# Analyze the saved data.
d <- read.csv(file.path(out_dir, "data.csv"))

d$vaccine <- factor(d$vaccine, levels = c("Control", "Vaccinated"))
d <- d[order(d$animal, d$week), ]
fit <- geepack::geeglm(infected ~ vaccine + week, id = animal,
  data = d, family = binomial, corstr = "exchangeable")
b <- coef(fit)["vaccineVaccinated"]
se <- sqrt(vcov(fit)["vaccineVaccinated", "vaccineVaccinated"])
odds_ratio <- exp(b)
ci <- exp(b + c(-1, 1) * 1.96 * se)
p_value <- 2 * pnorm(abs(b / se), lower.tail = FALSE)
observed <- aggregate(infected ~ vaccine + week, d, mean)

# One primary plot.
ragg::agg_png(file.path(out_dir, "plot.png"),
              width = 1600, height = 1000, res = 160, background = "white")
p <- ggplot2::ggplot(observed, ggplot2::aes(week, infected,
  color = vaccine, group = vaccine)) +
  ggplot2::geom_line(linewidth = 1) + ggplot2::geom_point(size = 3) +
  ggplot2::scale_color_manual(values = c(Control = "#b96735", Vaccinated = "#126887")) +
  ggplot2::scale_y_continuous(limits = c(0, 1)) +
  ggplot2::scale_x_continuous(breaks = 0:3) +
  ggplot2::labs(x = "Week", y = "Observed infection probability", color = "Group") +
  ggplot2::theme_classic(base_size = 17) +
  ggplot2::theme(legend.position = "top")
print(p)
dev.off()

# Numerical output is generated from this analysis.
results <- list(
  preview = head(apply(d, 1, paste, collapse = " | "), 5),
  summary = c(sprintf("Independent animals: %d; observations: %d", length(unique(d$animal)),nrow(d)), sprintf("Marginal vaccination odds ratio: %.3f", odds_ratio), sprintf("95%% robust CI: %.3f to %.3f",ci[1],ci[2]), sprintf("Robust Wald p = %.4g",p_value), sprintf("Working correlation estimate: %.3f",fit$geese$alpha)),
  report = sprintf("The estimated population-average infection odds ratio for vaccination was %.2f (95%% robust CI %.2f–%.2f; Wald p = %.3g), adjusted for week. The model treats 80 animals, rather than 320 rows, as independent units.",odds_ratio,ci[1],ci[2],p_value),
  full_output = paste(capture.output(print(summary(fit))), collapse = "\n")
)
jsonlite::write_json(results, file.path(out_dir, "results.json"),
                     pretty = TRUE, auto_unbox = TRUE, digits = 6)
