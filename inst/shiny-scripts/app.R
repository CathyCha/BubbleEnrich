library(shiny)

ui <- fluidPage(
  titlePanel("BubbleEnrich"),
  sidebarLayout(
    sidebarPanel(
      fileInput(inputId = "fileInput", label = "Input your own gene set"),
      textInput(inputId = "enrichmentSize", label = "Enrichment size"),
      selectInput(inputId = "colour", label = "Theme:", c("Purple", "Blue", "Black", "Red", "Green"))
    ),
    mainPanel(
      plotOutput("bubblePlot")
    )
  )
)

server <- function(input, output) {
  output$bubblePlot <- renderPlot({
    data(geneList, package="DOSE")
    BubbleEnrich(geneList)
  })
}

shinyApp(ui = ui, server = server)
