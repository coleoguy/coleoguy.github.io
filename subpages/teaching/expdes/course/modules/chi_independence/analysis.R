# Run: Rscript analysis.R path/to/output-folder
args <- commandArgs(trailingOnly = TRUE)
out_dir <- if (length(args)) args[1] else "."
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

# Simulate and save the data before analyzing them.
set.seed(3105)
d <- data.frame(habitat = rep(c("Forest", "Grassland", "Urban"), each = 90))
d$infection <- ifelse(rbinom(270, 1, rep(c(.25, .42, .55), each = 90)),
                       "Infected", "Uninfected")
write.csv(d, file.path(out_dir, "data.csv"), row.names = FALSE)

# Analyze the saved data.
d <- read.csv(file.path(out_dir, "data.csv"))

tab <- table(d$habitat, d$infection)
fit <- chisq.test(tab, correct = FALSE)
cramers_v <- sqrt(as.numeric(fit$statistic) /
                  (sum(tab) * min(nrow(tab)-1, ncol(tab)-1)))
rates <- prop.table(tab, 1)[, "Infected"]

# One primary plot.
ragg::agg_png(file.path(out_dir, "plot.png"),
              width = 1600, height = 1000, res = 160, background = "white")
p <- ggplot2::ggplot(d, ggplot2::aes(habitat, fill = infection)) +
  ggplot2::geom_bar(position = "fill", width = .65) +
  ggplot2::scale_fill_manual(values = c(Infected = "#126887", Uninfected = "#d8d8d8")) +
  ggplot2::scale_y_continuous(limits = c(0, 1)) +
  ggplot2::labs(x = "Habitat", y = "Fraction of lizards", fill = "Status") +
  ggplot2::theme_classic(base_size = 17) +
  ggplot2::theme(legend.position = "top")
print(p)
dev.off()

# Numerical output is generated from this analysis.
results <- list(
  preview = head(apply(d, 1, paste, collapse = " | "), 5),
  summary = c(sprintf("Infection probabilities: %s", paste(sprintf("%s %.2f", names(rates), rates), collapse = "; ")), sprintf("Minimum expected count: %.1f", min(fit$expected)), sprintf("Chi-square(%d) = %.3f", fit$parameter, fit$statistic), sprintf("p = %.4g; Cramer V = %.3f", fit$p.value, cramers_v)),
  report = sprintf("Infection probabilities differed descriptively across habitats (%s). The independence test gives chi-square(%d) = %.2f, p = %.3g; Cramer V = %.2f. This observational association does not establish a habitat effect.", paste(sprintf("%s %.0f%%", names(rates),100*rates), collapse = ", "), fit$parameter, fit$statistic, fit$p.value, cramers_v),
  full_output = paste(capture.output(print(fit)), collapse = "\n")
)
jsonlite::write_json(results, file.path(out_dir, "results.json"),
                     pretty = TRUE, auto_unbox = TRUE, digits = 6)
