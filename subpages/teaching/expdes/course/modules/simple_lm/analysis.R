# Run: Rscript analysis.R /absolute/output/folder
args <- commandArgs(trailingOnly = TRUE)
output_dir <- if (length(args)) args[1] else "."
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

# Simulate and save before analysis.
set.seed(1114)
nitrogen <- runif(36, 0, 12)
biomass <- 2.2 + .42 * nitrogen + rnorm(36, 0, .8)
d <- data.frame(pot = 1:36, nitrogen_mg = nitrogen, biomass_g = biomass)
write.csv(d, file.path(output_dir, "data.csv"), row.names = FALSE)
d <- read.csv(file.path(output_dir, "data.csv"))

# Analysis
fit <- lm(biomass_g ~ nitrogen_mg, data = d)
coefficients <- summary(fit)$coefficients
ci <- confint(fit)
grid <- data.frame(nitrogen_mg = seq(min(d$nitrogen_mg), max(d$nitrogen_mg), length.out = 100))
mean_ci <- predict(fit, grid, interval = "confidence")
new_pot <- predict(fit, grid, interval = "prediction")

# Primary figure
ragg::agg_png(file.path(output_dir, "plot.png"), width = 1600, height = 1000, res = 170)
par(mar = c(5, 5, 2, 1), las = 1, bty = "l", cex = 1.15)
plot(d$nitrogen_mg, d$biomass_g, type = "n", ylim = range(new_pot),
     xlab = "Nitrogen supplied (mg)", ylab = "Seedling biomass (g)")
polygon(c(grid$nitrogen_mg, rev(grid$nitrogen_mg)),
        c(mean_ci[, "lwr"], rev(mean_ci[, "upr"])), col = "#246A7330", border = NA)
lines(grid$nitrogen_mg, mean_ci[, "fit"], col = "#246A73", lwd = 3)
matlines(grid$nitrogen_mg, new_pot[, c("lwr", "upr")], lty = 2, col = "#B7663E")
points(d$nitrogen_mg, d$biomass_g, pch = 21, bg = "#246A73", col = "white", cex = 1.3)
legend("topleft", c("Mean + 95% confidence band", "95% prediction limits"),
       lty = c(1, 2), col = c("#246A73", "#B7663E"), bty = "n")
dev.off()

# Results are computed from the saved dataset.
summary_lines <- c(sprintf("Slope = %.3f g biomass per mg nitrogen", coef(fit)[2]),
 sprintf("95%% slope CI: %.3f to %.3f", ci[2,1], ci[2,2]),
 sprintf("Slope t = %.2f; df = %d; p = %.4g", coefficients[2,3], df.residual(fit), coefficients[2,4]),
 sprintf("R-squared = %.3f", summary(fit)$r.squared))
report <- sprintf("Each additional mg of nitrogen was associated with %.3f g higher mean biomass (95%% CI %.3f to %.3f); slope t(%d) = %.2f, p = %.4g. The narrow band concerns mean biomass; the wider prediction limits concern a new individual pot.", coef(fit)[2], ci[2,1], ci[2,2], df.residual(fit), coefficients[2,3], coefficients[2,4])
preview <- head(capture.output(print(head(d, 4), row.names = FALSE)), 5)
full_output <- paste(capture.output({ print(summary(fit)); print(confint(fit)) }), collapse = "\n")
jsonlite::write_json(list(preview = preview, summary = summary_lines, report = report, full_output = full_output),
 file.path(output_dir, "results.json"), auto_unbox = TRUE, pretty = TRUE, digits = 8)
cat(report, "\n")
