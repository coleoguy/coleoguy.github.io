args <- commandArgs(trailingOnly = TRUE)
out_dir <- if (length(args)) args[1] else "generated"
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

# Simulate and save the observations
set.seed(240511)
ecotype <- rep(c("Forest", "Grassland", "Dune"), each=25)
size <- rnorm(75, rep(c(12,14,13),each=25), 1.2)
d <- data.frame(ecotype, body_mm=size,
  wing_mm=1.3*size+rnorm(75,0,1), femur_mm=.45*size+rnorm(75,0,.4),
  antenna_mm=.7*size+rep(c(0,1,-1),each=25)+rnorm(75,0,.5))
write.csv(d, file.path(out_dir, "data.csv"), row.names = FALSE)
d <- read.csv(file.path(out_dir, "data.csv"))

# Analysis from the saved CSV
z <- scale(d[c("body_mm","wing_mm","femur_mm","antenna_mm")])
distance <- dist(z)
result <- cmdscale(distance, k=2, eig=TRUE)
summary_lines <- c(sprintf("Two-dimensional goodness of fit: %.3f", result$GOF[1]),"Euclidean distances between standardized traits","Closer points have more similar trait combinations")
report <- sprintf("The two-dimensional configuration has a goodness-of-fit measure of %.3f for the supplied distances. Its axes summarize distances; their signs and orientation have no fixed biological meaning.",result$GOF[1])

# Plot
ragg::agg_png(file.path(out_dir, "plot.png"), width=1600, height=1000, res=160, background="white")
par(mar=c(5,5,2,1), las=1, bty="l", cex=1.15)
coordinates <- result$points
colours <- c("#146A85", "#C56B3B", "#5B8266")[match(d$ecotype,c("Forest","Grassland","Dune"))]
plot(coordinates, pch=21, bg=colours, cex=1.1, asp=1,
     xlab="Dimension 1", ylab="Dimension 2")
legend("topright", c("Forest","Grassland","Dune"), pch=21,
       pt.bg=c("#146A85", "#C56B3B", "#5B8266"), bty="n")
dev.off()

preview <- capture.output(print(head(d, 4), row.names = FALSE))
full_output <- paste(capture.output(print(result)), collapse = "\n")
jsonlite::write_json(list(preview = preview, summary = summary_lines, report = report, full_output = full_output), file.path(out_dir, "results.json"), auto_unbox = TRUE, pretty = TRUE, digits = 12)
