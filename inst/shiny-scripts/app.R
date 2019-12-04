library(shiny)

ui <- fluidPage(
  titlePanel("BubbleEnrich"),
  sidebarLayout(
    sidebarPanel(
      fileInput(inputId = "fileInput", label = "Input your own gene set",
                accept = c("text/csv",
                           "text/comma-separated-values,text/plain",
                           ".csv")),
      textInput(inputId = "enrichmentSize", label = "Enrichment size"),
      selectInput(inputId = "colour", label = "Theme:", c("Purple", "Blue", "Black", "Red", "Green"))
    ),
    mainPanel(
      plotOutput("bubblePlot")
    )
  )
)

server <- function(input, output) {
  # if(is.null(geneSet <- input$fileInput)){
  #   geneSet <- data(geneList, package="DOSE")
  # }

  output$bubblePlot <- renderPlot({
    BubbleEnrich()
  })
}

shinyApp(ui = ui, server = server)
