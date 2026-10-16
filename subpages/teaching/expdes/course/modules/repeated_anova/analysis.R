# Run: Rscript analysis.R /absolute/output/folder
args <- commandArgs(trailingOnly = TRUE)
output_dir <- if (length(args)) args[1] else "."
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
library(ggplot2)
# Simulate and save before analysis.
set.seed(2103)
d <- expand.grid(temperature = c(15, 20, 25, 30), subject = 1:24)
individual <- rnorm(24, 0, 2)
d$oxygen <- 8 + .35 * (d$temperature - 15) +
  individual[d$subject] + rnorm(nrow(d), 0, 1.3)
write.csv(d, file.path(output_dir, "data.csv"), row.names = FALSE)
d <- read.csv(file.path(output_dir, "data.csv"))
d$subject <- factor(d$subject)
d$condition <- factor(d$temperature)
# Analysis
fit <- aov(oxygen ~ condition + Error(subject/condition), data = d)
summary(fit)
endpoints <- t.test(d$oxygen[d$temperature == 30],
                   d$oxygen[d$temperature == 15], paired = TRUE)

# Primary figure
ragg::agg_png(file.path(output_dir, "plot.png"), width = 1600, height = 1000, res = 160, background = "white")
p <- ggplot(d, aes(temperature, oxygen)) +
  geom_line(aes(group = subject), color = "#A9B5B8", alpha = .55) +
  geom_point(color = "#246A73", alpha = .6, size = 1.8) +
  stat_summary(fun = mean, geom = "line", color = "#B7663E", linewidth = 1.7) +
  stat_summary(fun = mean, geom = "point", color = "#B7663E", size = 3.5) +
  scale_x_continuous(breaks = c(15, 20, 25, 30)) +
  labs(x = "Assay temperature (°C)", y = "Oxygen use (µmol/hour)",
       caption = "Gray lines preserve individuals; orange line shows means") +
  theme_classic(base_size = 16)
print(p)
dev.off()

# Results computed from the saved data.
tab <- summary(fit)[[2]][[1]]
summary_lines <- c(sprintf("Condition F(%g, %g) = %.2f", tab$Df[1], tab$Df[2], tab$`F value`[1]),
 sprintf("Omnibus p = %.4g", tab$`Pr(>F)`[1]),
 sprintf("Planned 30−15°C mean difference = %.2f µmol/hour", endpoints$estimate),
 sprintf("95%% CI %.2f to %.2f", endpoints$conf.int[1], endpoints$conf.int[2]))
report <- sprintf("Within the same 24 animals, temperature means differed (F(%g, %g) = %.2f, p = %.4g). The prespecified 30−15°C mean increase was %.2f µmol/hour (95%% CI %.2f to %.2f). The repeated-measures F test assumes sphericity; the experiment has 24 independent animals, not 96 independent rows.", tab$Df[1], tab$Df[2], tab$`F value`[1], tab$`Pr(>F)`[1], endpoints$estimate, endpoints$conf.int[1], endpoints$conf.int[2])
full_output <- paste(capture.output({
  if (exists("fit", inherits = FALSE)) print(summary(fit))
  if (exists("test", inherits = FALSE)) print(test)
  if (exists("overall", inherits = FALSE)) print(overall)
  if (exists("comparisons", inherits = FALSE)) print(comparisons)
  if (exists("comparison", inherits = FALSE)) print(comparison)
  if (exists("ph_check", inherits = FALSE)) print(ph_check)
  if (exists("poisson_fit", inherits = FALSE)) print(summary(poisson_fit))
}), collapse = "\n")

preview <- head(capture.output(print(head(d, 4), row.names = FALSE)), 5)
jsonlite::write_json(list(preview = preview, summary = summary_lines,
                         report = report, full_output = full_output),
  file.path(output_dir, "results.json"), auto_unbox = TRUE,
  pretty = TRUE, digits = 8)
cat(report, "\n")
