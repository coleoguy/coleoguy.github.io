# Run: Rscript analysis.R /absolute/output/folder
# Required packages: geepack, ggplot2, ragg, jsonlite.
args <- commandArgs(trailingOnly = TRUE)
output_dir <- if (length(args)) args[1] else "."
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
library(ggplot2)

# Simulate independent mesocosms with repeated samples; save first.
set.seed(1401)
mesocosm <- rep(1:90, each = 4)
week <- rep(0:3, 90)
treatment <- rep(rep(c("Ambient", "Warm"), each = 45), each = 4)
volume_ml <- runif(360, .5, 1.5)
shared_rate <- rgamma(90, shape = 2, rate = 2)
mu <- volume_ml * exp(2.2 + .45 * (treatment == "Warm") + .1 * week)
colonies <- rpois(360, mu * shared_rate[mesocosm])
d <- data.frame(mesocosm, week, treatment, volume_ml, colonies)
write.csv(d, file.path(output_dir, "data.csv"), row.names = FALSE)
d <- read.csv(file.path(output_dir, "data.csv"))

# A marginal log-mean model with robust cluster-level uncertainty.
d$treatment <- factor(d$treatment, levels = c("Ambient", "Warm"))
d <- d[order(d$mesocosm, d$week), ]
fit <- geepack::geeglm(colonies ~ treatment + week + offset(log(volume_ml)),
  id = mesocosm, data = d, family = poisson(link = "log"),
  corstr = "exchangeable", std.err = "san.se")
b <- coef(fit)["treatmentWarm"]
se <- sqrt(vcov(fit)["treatmentWarm", "treatmentWarm"])
rate_ratio <- exp(b)
ci <- exp(b + c(-1, 1) * 1.96 * se)
p_value <- 2 * pnorm(abs(b / se), lower.tail = FALSE)

# The primary plot shows repeated observations and descriptive group rates.
ragg::agg_png(file.path(output_dir, "plot.png"), width = 1600, height = 1000,
              res = 170, background = "white")
observed <- aggregate(cbind(colonies, volume_ml) ~ treatment + week, d, sum)
observed$rate <- observed$colonies / observed$volume_ml
p <- ggplot(d, aes(week, colonies / volume_ml, color = treatment)) +
  geom_line(aes(group = mesocosm), alpha = .12, linewidth = .5) +
  geom_line(data = observed, aes(y = rate, group = treatment), linewidth = 1.4) +
  geom_point(data = observed, aes(y = rate), size = 3.4) +
  scale_color_manual(values = c(Ambient = "#246A73", Warm = "#B7663E")) +
  scale_x_continuous(breaks = 0:3) +
  labs(x = "Week", y = "Colonies per mL", color = "Temperature",
       caption = "Faint lines: mesocosms. Thick lines: observed group rates.") +
  theme_classic(base_size = 18) + theme(legend.position = "top")
print(p)
dev.off()

summary_lines <- c(
  sprintf("Independent mesocosms: %d; observations: %d", length(unique(d$mesocosm)), nrow(d)),
  sprintf("Population-average Warm / Ambient rate ratio = %.3f", rate_ratio),
  sprintf("95%% robust CI: %.3f to %.3f", ci[1], ci[2]),
  sprintf("Robust Wald p = %.4g", p_value),
  sprintf("Working correlation estimate = %.3f", fit$geese$alpha))
report <- sprintf("The population-average colony rate in warmed mesocosms was %.2f times the ambient rate (95%% robust CI %.2f to %.2f; Wald p = %.4g), adjusting for week and sampled volume. The %d mesocosms are the independent units; the model accounts for their repeated samples.", rate_ratio, ci[1], ci[2], p_value, length(unique(d$mesocosm)))
preview <- head(capture.output(print(head(d, 4), row.names = FALSE)), 5)
full_output <- paste(capture.output(print(summary(fit))), collapse = "\n")
jsonlite::write_json(list(preview = preview, summary = summary_lines,
  report = report, full_output = full_output),
  file.path(output_dir, "results.json"), auto_unbox = TRUE, pretty = TRUE, digits = 8)
cat(report, "\n")
