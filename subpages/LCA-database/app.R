library(shiny)
library(viridis)
ref <- read.csv("ref_shiny.version.csv")
# Define UI for application that creates figure
ui <- fluidPage(
  theme = "sandstone.css",
  tags$style(type="text/css",
             ".shiny-output-error { visibility: hidden; }",
             ".shiny-output-error:before { visibility: hidden; }"),
  
    # Application title
    titlePanel("The Role of Epistasis"),
    # Sidebar with various dropdowns to subset data 
    sidebarLayout(
        sidebarPanel(
          width=4,
          img(src = "./epi-logo.png", width=250, align = "center"),
          h3("Plot options"),
          radioButtons("colorby", label = h4("Select data to color by:"),
                       choices = list("Clade" = 7, 
                                      "Divergence" = 12, 
                                      "Trait class" = 6,
                                      "Organism type" = 8,
                                      "Sex chromosome system" = 11,
#                                     "Method" = 14,
                                      "Regression type" = 13), 
                       selected = 7),
          h4("Select subset options:"),
          selectInput("clade", label = h5("Clade"), 
                      choices = list("Plant" = "plant", 
                                     "Animal" = "animal", 
                                     "All" = "all"), 
                      selected = "all"),
          selectInput("diverg", label = h5("Divergence"), 
                      choices = list("Within species" = "within", 
                                     "Between species" = "between", 
                                     "All" = "all"), 
                      selected = "all"),
          selectInput("class", label = h5("Trait class"), 
                      choices = list("Life history" = "LH", 
                                     "Morphology" = "M", 
                                     "All" = "all"), 
                      selected = "all"),
          selectInput("status", label = h5("Organism type"), 
                        choices = list("Domesticated" = "domestic", 
                                       "Lab" = "lab", 
                                       "Wild" = "wild",
                                       "All" = "all"), 
                        selected = "all"),
          selectInput("regress", label = h5("Regression type"), 
                      choices = list("Weighted LSR" = "Y", 
                                     "Unweighted LSR" = "N",
                                     "All" = "all"), 
                      selected = "all")
        ),
        mainPanel(
          
          
          tabsetPanel(
            tabPanel("Information", div(HTML("
<br>
<br>
Since the 1930s, scientists have debated the importance of epistatic gene action 
relative to additive gene action in trait divergence. Previous studies have been 
limited in the number of datasets for which they can accurately quantify epistatic 
effects. To resolve this debate, we have conducted an extensive literature search 
and generated several datasets, allowing us to quantify the composite genetic effects 
that underlie trait divergence across the tree of life. This database houses over 
1,600 datasets from 130 publications, allowing viewers to visualize the effect of 
epistasis on a range of organisms and phenotypes. In the plot tab, you can select 
the data you wish to color the base plot, then select options to further subset 
the data. In the table tab, you can customize a table to include any listed 
parameters. Each dataset can be downloaded by clicking the hyperlink file 
name in the last column. You can see all of the complete citations used in the 
literature search in the citations tab.
<br>
<br>
<b>Submitting Data:</b> If you are aware of any available records that should be added to the database, please email us and we will incorporate the missing data.
<a href='mailto:blackmon@tamu.edu'>Contact Us</a><br>
<br>
Data taken from the database must not be reproduced in published lists, online databases, or other
formats, nor redistributed without permission. The information in this database is provided
solely for personal and academic use, and must not be used for the purposes of financial gain.
<br>
<br>
<b>The database should be cited as follows:</b>
<br>
<a href='XXXX' target='_blank'> Elliott, Jorja, Maximos Chin, Brian E. Fontenot, 
Sabyasachi Mandal, Thomas D. McKnight, Jeffery P. Demuth, Heath Blackmon, 
Wright was Right: Analysis of over one thousand datasets supports the critical 
role of epistasis in genetics and evolution. XXX</a>
<br>
<br>
Current version of the database is 1.0 last updated 14 July 2023."), style = "font-size:100%")),
            
            
            tabPanel("Plot",plotOutput("distPlot")),
            tabPanel("Table",
                     checkboxGroupInput(inputId = "table", label = "Choose columns to include",
                                        choices = c("Organism",
                                                    "Phenotype",
                                                    "Sex chromosome System",
                                                    "Trait class",
                                                    "Clade",
                                                    "Divergence",
                                                    "Divergence time (MYA)",
                                                    "Organism type",
                                                    "Regression type",
                                                    "Citation"),
                                        selected = c("Organism", "Phenotype", "Citation"),
                                        inline = T),
#                     downloadButton("downloadData", "Download table"), 
                     tableOutput("table")),
            tabPanel("Citations", div(tableOutput("citTable"), style = "font-size:80%"))
))))
          
        
    




# Define server logic required to create  plot
server <- function(input, output) {
  cit.table <- read.csv("citations.csv", as.is=T, check.names=F)
  output$value <- renderPrint({ input$method })


    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- read.csv("complete.results.csv")
        x <- x[complete.cases(x),]
        if(input$clade != "all"){
          x <- x[x$kingdom == input$clade,]
        }
        if(input$diverg != "all"){
          x <- x[x$divergence == input$diverg,]
        }
        if(input$class != "all"){
          x <- x[x$class == input$class,]
        }
        if(input$status != "all"){
          x <- x[x$domestication == input$status,]
        }
        if(input$regress != "all"){
          x <- x[x$weighted == input$regress,]
        }
        z <- as.numeric(input$colorby)
        states <- unique(x[, z])

        y1 <- sort(x$epi[x[, z] == states[1]])
        y2 <- sort(x$epi[x[, z] == states[2]])
        y3 <- sort(x$epi[x[, z] == states[3]])
        y4 <- sort(x$epi[x[, z] == states[4]])
        x1 <- seq(from=0, to=1, length.out=length(y1))
        x2 <- seq(from=0, to=1, length.out=length(y2))
        x3 <- seq(from=0, to=1, length.out=length(y3))
        x4 <- seq(from=0, to=1, length.out=length(y4))
        plot(y=y1, x=x1, col="#440154FF", type="l",
             xlab="proportion of datasets analyzed",
             ylab="proportion of trait divergence that is epistasic",
             ylim=c(0,1))
        lines(y=y2, x=x2, col="#7AD151FF")
        lines(y=y3, x=x3, col="#22A884FF")
        lines(y=y4, x=x4, col="#3B528BFF")
        points(y=y1, x=x1, col="#440154FF",pch=16, cex=.9)
        points(y=y2, x=x2, col="#7AD151FF", pch=16, cex=.9)
        points(y=y3, x=x3, col="#22A884FF", pch=16, cex=.9)
        points(y=y4, x=x4, col="#3B528BFF", pch=16, cex=.9)
        cols <- c("#440154FF", "#7AD151FF", "#22A884FF", "#3B528BFF")
        yinc <- -.04
        ns <- c(length(x1), length(x2), length(x3), length(x4))[1:length(states)]
        for(i in 1:length(states)){
          points(x=0,y=(.96+yinc*i), pch=15,col=cols[i],cex=1.1)
          text(x=0,y=(.96+yinc*i), pos=4, paste(states[i]," ", "(n = ", ns[i],")", sep=""))
        }
     })
      ref.table <- reactive({
        x <- 0
      if("Organism" %in% input$table) x <- c(x, 2)
      if("Phenotype" %in% input$table) x <- c(x, 3)
      if("Sex chromosome System" %in% input$table) x <- c(x, 4)
      if("Trait class" %in% input$table) x <- c(x, 5)
      if("Clade" %in% input$table) x <- c(x, 6)
      if("Divergence" %in% input$table) x <- c(x, 7)
      if("Divergence time (MYA)" %in% input$table) x <- c(x, 8)
      if("Organism type" %in% input$table) x <- c(x, 9)
      if("Regression type" %in% input$table) x <- c(x, 10)
      if("Citation" %in% input$table) x <- c(x, 12)
      return(x)
    })

    output$table <-      renderTable({ 
        urls <- ref$new.file.name
        data <- paste0("<a href='",  urls,"' target='_blank'>", urls, "</a>")
        data.frame(ref[,ref.table()], data)


      }, sanitize.text.function = function(x) x)
      

      
#    output$downloadData <- downloadHandler(
#      filename = paste("epistasis", Sys.Date(), ".csv", sep=""),
#      content = function(file) {
#        write.csv(x[,ref.table()], file, row.names = FALSE)
#      })
    output$citTable <- renderTable(cit.table,
                                   na = "",
                                   striped = T)
    }




# Run the application 
shinyApp(ui = ui, server = server)
