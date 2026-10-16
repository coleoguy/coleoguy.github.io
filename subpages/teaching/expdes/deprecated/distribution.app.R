# app.R
# Minimal Shiny app: pick a distribution, set parameters, draw N samples, plot.

library(shiny)
library(ggplot2)

ui <- fluidPage(
  titlePanel("Sample from a Distribution"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        "dist", "Distribution",
        choices = c("Normal", "Uniform", "Exponential", "Poisson", "Binomial", "Gamma"),
        selected = "Normal"
      ),
      uiOutput("param_ui"),
      numericInput("n", "Sample size (n)", min = 1, max = 1e6, value = 100, step = 1),
      numericInput("seed", "Seed (optional)", value = NA),
      actionButton("draw", "Draw sample", class = "btn-primary"),
      hr(),
      checkboxInput("show_rug", "Show rug", TRUE),
      checkboxInput("show_density", "Show density overlay", TRUE)
    ),
    mainPanel(
      plotOutput("plot", height = 400),
      tags$br(),
      verbatimTextOutput("summary")
    )
  )
)

server <- function(input, output, session) {
  
  # dynamic parameter inputs
  output$param_ui <- renderUI({
    switch(input$dist,
           "Normal" = tagList(
             numericInput("mean", "mean (μ)", value = 0),
             numericInput("sd",   "sd (σ) > 0", value = 1, min = 1e-8)
           ),
           "Uniform" = tagList(
             numericInput("min", "min (a)", value = 0),
             numericInput("max", "max (b)", value = 1)
           ),
           "Exponential" = numericInput("rate", "rate (λ) > 0", value = 1, min = 1e-8),
           "Poisson" = numericInput("lambda", "mean (λ) ≥ 0", value = 5, min = 0),
           "Binomial" = tagList(
             numericInput("size", "trials (n) ≥ 0", value = 10, min = 0, step = 1),
             sliderInput("prob", "probability (p) ∈ [0,1]", min = 0, max = 1, value = 0.5, step = 0.01)
           ),
           "Gamma" = tagList(
             numericInput("shape", "shape (k) > 0", value = 2, min = 1e-8),
             numericInput("rateG", "rate (θ⁻¹) > 0", value = 1, min = 1e-8)
           )
    )
  })
  
  # draw sample on click
  samp <- eventReactive(input$draw, {
    if (!is.na(input$seed)) set.seed(as.integer(input$seed))
    n <- max(1, as.integer(input$n))
    switch(input$dist,
           "Normal"      = rnorm(n, mean = input$mean, sd = max(input$sd, 1e-8)),
           "Uniform"     = {
             a <- input$min; b <- input$max
             if (b < a) { tmp <- a; a <- b; b <- tmp }
             runif(n, min = a, max = b)
           },
           "Exponential" = rexp(n, rate = max(input$rate, 1e-8)),
           "Poisson"     = rpois(n, lambda = max(input$lambda, 0)),
           "Binomial"    = rbinom(n, size = max(as.integer(input$size), 0), prob = min(max(input$prob, 0), 1)),
           "Gamma"       = rgamma(n, shape = max(input$shape, 1e-8), rate = max(input$rateG, 1e-8))
    )
  }, ignoreInit = TRUE)
  
  output$plot <- renderPlot({
    x <- samp()
    req(x)
    
    # choose a sensible geometry for discrete vs continuous
    is_discrete <- input$dist %in% c("Poisson", "Binomial")
    df <- data.frame(x = x)
    
    p <- ggplot(df, aes(x = x)) +
      { if (is_discrete) geom_bar() else geom_histogram(aes(y = after_stat(density)), bins = 30) } +
      labs(
        x = "Value",
        y = if (is_discrete) "Count" else "Density",
        title = paste("Sample from", input$dist)
      ) +
      theme_minimal(base_size = 14)
    
    if (!is_discrete && isTRUE(input$show_density)) {
      p <- p + geom_density(linewidth = 1)
    }
    if (!is_discrete && isTRUE(input$show_rug)) {
      p <- p + geom_rug(alpha = 0.4)
    }
    
    p
  })
  
  output$summary <- renderPrint({
    x <- samp()
    req(x)
    if (input$dist %in% c("Poisson", "Binomial")) {
      tab <- sort(table(x))
      cat("Counts:\n"); print(tab)
      cat("\nMean:", mean(x), "  Var:", var(x), "  n:", length(x), "\n")
    } else {
      summary(x)
    }
  })
}

shinyApp(ui, server)
