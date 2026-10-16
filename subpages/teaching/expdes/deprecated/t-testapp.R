# app.R
# Live-updating Shiny app: simulate two human height groups, auto-responding to any input change.
# Requirements: shiny, ggplot2, ggbeeswarm

library(shiny)
library(ggplot2)
library(ggbeeswarm)

# helper for mean ± 95% CI without extra packages
mean_ci <- function(y) {
  m  <- mean(y)
  se <- sd(y) / sqrt(length(y))
  data.frame(y = m, ymin = m - 1.96 * se, ymax = m + 1.96 * se)
}

ui <- fluidPage(
  titlePanel("Live Simulation: Heights in Two Groups"),
  sidebarLayout(
    sidebarPanel(
      helpText(
        "Defaults approximate adult U.S. heights: Group A ~ males (mean 175 cm, sd 7.5); ",
        "Group B ~ females (mean 162 cm, sd 7). Adjust and watch everything update live."
      ),
      tags$hr(),
      h4("Group A (e.g., Males)"),
      sliderInput("muA", "Mean A (cm)", min = 140, max = 200, value = 175, step = 0.1),
      sliderInput("sdA", "SD A (cm)",   min = 2,   max = 15,  value = 7.5, step = 0.1),
      numericInput("nA",  "Sample size A", value = 100, min = 2, step = 1),
      
      tags$hr(),
      h4("Group B (e.g., Females)"),
      sliderInput("muB", "Mean B (cm)", min = 140, max = 200, value = 162, step = 0.1),
      sliderInput("sdB", "SD B (cm)",   min = 2,   max = 15,  value = 7.0, step = 0.1),
      numericInput("nB",  "Sample size B", value = 100, min = 2, step = 1),
      
      tags$hr(),
      numericInput("seed", "Seed (optional, fixes randomness)", value = NA),
      checkboxInput("inches", "Also show values in inches in the table", FALSE),
      downloadButton("download_csv", "Download simulated data (CSV)")
    ),
    mainPanel(
      fluidRow(
        column(
          width = 7,
          plotOutput("swarm", height = 470)
        ),
        column(
          width = 5,
          h4("Welch Two-Sample t-test & Effect Size"),
          verbatimTextOutput("ttest"),
          tags$hr(),
          tableOutput("quickstats")
        )
      )
    )
  )
)

server <- function(input, output, session) {
  
  # Generate data reactively whenever any relevant input changes
  dat <- reactive({
    # Make RNG reproducible if seed is provided
    if (!is.na(input$seed)) set.seed(as.integer(input$seed))
    
    nA <- max(2L, as.integer(input$nA))
    nB <- max(2L, as.integer(input$nB))
    sdA <- max(input$sdA, 1e-8)
    sdB <- max(input$sdB, 1e-8)
    
    a  <- rnorm(nA, mean = input$muA, sd = sdA)
    b  <- rnorm(nB, mean = input$muB, sd = sdB)
    
    data.frame(
      group = factor(c(rep("A", nA), rep("B", nB)), levels = c("A", "B")),
      height_cm = c(a, b),
      stringsAsFactors = FALSE
    )
  })
  
  # Welch t-test and Cohen's d (updates live)
  output$ttest <- renderPrint({
    x <- dat(); req(x)
    a <- x$height_cm[x$group == "A"]
    b <- x$height_cm[x$group == "B"]
    
    tt <- t.test(a, b, var.equal = FALSE)
    
    # Cohen's d using pooled SD
    s2p <- ((length(a) - 1) * var(a) + (length(b) - 1) * var(b)) / (length(a) + length(b) - 2)
    d   <- (mean(a) - mean(b)) / sqrt(s2p)
    
    cat("Welch Two Sample t-test\n")
    print(tt)
    cat(sprintf("\nCohen's d (A - B): %.3f\n", d))
  })
  
  # Group summaries table (updates live)
  output$quickstats <- renderTable({
    x <- dat(); req(x)
    by_n <- tapply(x$height_cm, x$group, length)
    by_m <- tapply(x$height_cm, x$group, mean)
    by_s <- tapply(x$height_cm, x$group, sd)
    
    out <- data.frame(
      Group   = names(by_n),
      n       = as.integer(by_n),
      Mean_cm = round(as.numeric(by_m), 2),
      SD_cm   = round(as.numeric(by_s), 2),
      row.names = NULL
    )
    if (isTRUE(input$inches)) {
      out$Mean_in <- round(out$Mean_cm / 2.54, 2)
      out$SD_in   <- round(out$SD_cm   / 2.54, 2)
    }
    out
  }, striped = TRUE, bordered = TRUE, digits = 3)
  
  # Beeswarm-style plot with mean + 95% CI + mean±1SD guides (updates live)
  output$swarm <- renderPlot({
    x <- dat(); req(x)
    mu  <- tapply(x$height_cm, x$group, mean)
    sdv <- tapply(x$height_cm, x$group, sd)
    
    ggplot(x, aes(x = group, y = height_cm)) +
      ggbeeswarm::geom_quasirandom(width = 0.25, size = 2.2, alpha = 0.8) +
      stat_summary(fun = mean, geom = "point", shape = 21, size = 3.6,
                   fill = "white", stroke = 1.2) +
      stat_summary(fun.data = mean_ci, geom = "errorbar",
                   width = 0.16, linewidth = 0.95) +
      # mean (dashed) and ±1 SD (faint) reference per group
      annotate("segment", x = 0.8, xend = 1.2, y = mu["A"], yend = mu["A"],
               linetype = 2, alpha = 0.7) +
      annotate("segment", x = 1, xend = 1, y = mu["A"] - sdv["A"], yend = mu["A"] + sdv["A"],
               alpha = 0.5) +
      annotate("segment", x = 1.8, xend = 2.2, y = mu["B"], yend = mu["B"],
               linetype = 2, alpha = 0.7) +
      annotate("segment", x = 2, xend = 2, y = mu["B"] - sdv["B"], yend = mu["B"] + sdv["B"],
               alpha = 0.5) +
      labs(
        x = NULL, y = "Height (cm)",
        title = "Simulated Heights by Group (Live)",
        subtitle = "Beeswarm points = individuals; big dot = mean; bars = 95% CI (normal approx)."
      ) +
      theme_minimal(base_size = 15) +
      theme(
        panel.grid.major.x = element_blank(),
        axis.text.x = element_text(face = "bold")
      )
  })
  
  # CSV download reflects current live data
  output$download_csv <- downloadHandler(
    filename = function() paste0("sim_heights_", Sys.Date(), ".csv"),
    content = function(file) write.csv(dat(), file, row.names = FALSE)
  )
}

shinyApp(ui, server)
