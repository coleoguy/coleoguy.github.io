library(shiny)
library(shinythemes)
library(viridis)
library(ggplot2)
# Define UI for application that draws a histogram
ui <- fluidPage(
  theme = "sandstone.css",
  tags$style(type="text/css",
             ".shiny-output-error { visibility: hidden; }",
             ".shiny-output-error:before { visibility: hidden; }"),

  sidebarLayout(
    sidebarPanel(
      width = 3,
      img(src = "plant.jpg", width = "90%", align = "center"),
      h4("TOS Database"),
      h4("Plants"),
      br(),
      tags$style(type = "text/css", "label { font-size: 10px; }"),
      selectInput("ord", "Select an order:",
                  c("None",
                    "All orders",
                    'Sapindales',
                    'Apiales',
                    'Ericales',
                    'Malpighiales',
                    'Fagales',
                    'Caryophyllales',
                    'Asterales',
                    'Asparagales',
                    'Gentianales',
                    'Saxifragales',
                    'Fabales',
                    'Cucurbitales',
                    'Santalales',
                    'incertae sedis',
                    'Solanales',
                    'Malvales',
                    'Piperales',
                    'Zygophyllales',
                    'Laurales',
                    'Lamiales',
                    'Rosales',
                    'Poales',
                    'Brassicales',
                    'Liliales',
                    'Gunnerales',
                    'Genianales',
                    'Arecales',
                    'Austrobaileyales',
                    'Ranunculales',
                    'Dipsacales',
                    'Rhamnales'),selected=""),
      uiOutput("fam"),
      uiOutput("gen"),
      textInput("text", label = "Search", value = ""),
      br(),
      uiOutput("totals")
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Table",
                 checkboxGroupInput(inputId = "col.pic", label = "Choose data to include",
                                    choices = c("Taxonomy",
                                                "Sexual system",
                                                "Selfing",
                                                "Growth form",
                                                "Woodiness",
                                                "Life form",
                                                "Gametophyte chromosome number (mean)",
                                                "Sporophytic chromosome number (mean)",
                                                "Citations"), selected = c("Taxonomy","Sexual system"),
                                    inline = TRUE, width = NULL, choiceNames = NULL, choiceValues = NULL),
                 downloadButton("downloadData", "Download"),
                 div(tableOutput("selTable"),
                     style = "font-size:80%")),
        tabPanel("Information", div(HTML("
                                           <br>
                                           <br>
                                           This server allows you to select a group of taxa and view a subset of the traits recorded for each species. For instance, only a single reference is provided for each species in the web interface. However, when you click the download button all available data for the selected species will be included in the CSV file generated.
                                         Downloaded datasets include only short citation keys for full citation download the full <a href='data.plant.refs.csv' target='_blank'>plant reference file.</a>"), style = "font-size:100%"))

      )
    )
  )
)

# Define server logic
server <- function(input, output) {
  # read in the data
  dat <- read.csv("data.plant.csv", as.is=T, check.names=F)

  # subsets data based on order selection
  target.dat <- reactive({
    a <- dat
    if(input$ord != "All orders") a <- dat[dat$Order == input$ord, ]
    return(a)
  })
  # generates a vector of current family names
  fam <- reactive(sort(unique(target.dat()$Family)))

  # subsets data based on family selection
  target.dat2 <- reactive({
    a <- target.dat()
    if(input$fam != "All families"){
      a <- a[a$Family == input$fam, ]
    }
    return(a)
  })
  # generates a vector of current genus names
  gen <- reactive(sort(unique(target.dat2()$Genus)))

  # this makes the family dropdown menu
  output$fam <- renderUI({
    selectInput("fam", "Select a family:", choices = c("All families", fam()))
  })

  # this makes the genus dropdown menu
  output$gen <- renderUI({
    selectInput("gen", "Select a genus:", choices = c("All genera", gen()))
  })

  # make final data selection function based on taxonomy choices
  final.dat <- reactive({
    a <- target.dat()
    if(input$fam != "All families") a <- a[a$Family == input$fam, ]
    if(input$gen != "All genera") a <- a[a$Genus == input$gen, ]
    return(a)
  })

  # now we can also incorporate search terms within selected data


  final.dat5 <- reactive({
    a <- final.dat()
    if(input$text != ""){
      names <- list()
      for(i in 1:nrow(final.dat())){
        names[[i]] <- strsplit(final.dat()$Species[i], " ")[[1]]
      }
      good.rows <- c()
      # check order
      good.rows <- c(good.rows, which(final.dat()$Order == input$text))
      # check family
      good.rows <- c(good.rows, which(final.dat()$Family == input$text))
      # check genus
      good.rows <- c(good.rows, which(final.dat()$Genus == input$text))
      # check species
      good.rows <- c(good.rows, which(final.dat()$Species == input$text))
      # check all possible names
      for(i in 1:length(names)){
        if(tolower(input$text) %in% tolower(names[[i]])){
          good.rows <- c(good.rows, i)
        }
      }
      unsorted <- final.dat()[good.rows, ]
      sorted <- unsorted[order(unsorted$Species),]
      return(sorted)
    }else{
      return(a)
    }
  })

  output$totals <- renderText({
    paste(nrow(final.dat5()),"records available")
  })

  col.dat <- reactive({
    x <- 4
    if("Taxonomy" %in% input$col.pic) x <- c(1, 2, 3, 5, x)
    if("Sexual system" %in% input$col.pic) x <- c(x, 13)
    if("Selfing" %in% input$col.pic) x <- c(x, 15)
    if("Growth form" %in% input$col.pic) x <- c(x, 17)
    if("Woodiness" %in% input$col.pic) x <- c(x, 19)
    if("Life form" %in% input$col.pic) x <- c(x, 22)
    if("Gametophyte chromosome number (mean)" %in% input$col.pic) x <- c(x, 26)
    if("Sporophytic chromosome number (mean)" %in% input$col.pic) x <- c(x, 30)
    if("Citations" %in% input$col.pic) x <- c(x, 40)

    x <- sort(x)
    return(x)
  })
  output$selTable <- renderTable(final.dat5()[,col.dat()],
                                 na = "",
                                 striped = T)
  output$downloadData <- downloadHandler(
    filename = paste("TOS_data_", Sys.Date(), ".csv", sep=""),
    content = function(file) {
      write.csv(final.dat5(), file, row.names = FALSE)
    }
  )

}
# Run the application
shinyApp(ui = ui, server = server)






