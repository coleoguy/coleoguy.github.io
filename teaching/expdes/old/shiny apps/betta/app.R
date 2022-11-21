#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Predicting Sale Price"),
  "For this dataset lets look at a simple model where the expected sale price for a fish is a function of a y intercept plus an effect of size, sex, and color.",
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      numericInput("yint",
                   "y intercept",
                   value = 0),
      numericInput("size",
                   "additional cost per 1 unit of increase in length",
                   value = 0),
      numericInput("red",
                   "price change for red relative to blue",
                   value = 0),
      numericInput("galaxy",
                   "price change for galaxy relative to blue",
                   value = 0),
      numericInput("sex",
                   "price change for a male relative to a female",
                   value = 0)),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  dat <- read.csv("bettafish.csv")
  # get predicted values
  
  pred.vals <- reactive({
    temp.vals <- c()
    for(i in 1:nrow(dat)){
      x <- input$size * dat$size[i]
      if(dat$sex[i] == "male"){
        x <- x + input$sex
      }
      if(dat$color[i] == "red"){
        x <- x + input$red
      }
      if(dat$color[i] == "galaxy"){
        x <- x + input$galaxy
      }
      x <- x + input$yint
      temp.vals[i] <- x
    }
    return(temp.vals)
  })
  
  
  output$distPlot <- renderPlot({
    pchs <-  c(15,16)[as.factor(dat$sex)]
    cols <- c("blue","black","red")[as.factor(dat$color)]
    par(mfcol=c(2,2))
    plot(x=dat$size, y=dat$price, pch=pchs, col=cols,
         xlab="fish size", ylab="sale price")
    plot(x=dat$size, y=pred.vals(), pch=pchs, col=cols,
         xlab="fish size",ylab="predicted sale price")
    difs <- dat$price - pred.vals()
    sqdifs <- difs^2
    hist(sqdifs, main=paste("Total sum of squared residuals:", sum(sqdifs)))
    plot(x=rep(1,5),y=1:5, pch=c(15,16,16,16,16),xaxt="n",yaxt="n",
         col=c("gray", "gray", "blue","black","red"),xlab="",ylab="",bty="n")
    text(x=rep(1,5), y=1:5, pos=4,
         labels = c("female","male","blue","galaxy","red"))
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
