library(shiny)

ui <- fluidPage(
  titlePanel("BubbleEnrich"),
  sidebarLayout(
    sidebarPanel(
      fileInput(inputId = "fileInput", label = "Input your own gene set",
                accept = c("text/csv",
                           "text/comma-separated-values,text/plain",
                           ".csv")
                ),
      # slider to filter by enrichment size cut off
      sliderInput(inputId = "enrichmentSize", label = "Enrichment size greater than:", min = 1, max = 20, value = 5),
      # select tab to change low p-value colour
      selectInput(inputId = "lowcolour", label = "Low P-Value Colour:", c("Purple", "Blue", "Black", "Red", "Green", "Orange")),
      # select tab to change high p-value colour
      selectInput(inputId = "highcolour", label = "High P-Value Colour:", c("Purple", "Blue", "Black", "Red", "Green", "Orange"))
    ),
    mainPanel(
      # ggplot output
      plotOutput("bubblePlot", click = "plot_click")
    )
  ),

  # row where the plot results would show
  fluidRow(
    column(width = 12,
           h4("Click on an enrichment bubble to see contributing genes"),
           htmlOutput("click_info")
    )
  )
)

server <- function(input, output) {

  output$bubblePlot <- renderPlot({
    inputfile <- input$fileInput[,c("datapath")]

    if(is.null(inputfile)) {
      # use ovarian example data from DOSE package if geneSet is not supplied
      geneSet <- get(data(geneList, package="DOSE"))
    } else {
      # if file input is provided
      geneSet <- userInput(inputfile)
    }

    if (is.numeric(geneSet) == FALSE) {stop("Input must be of type numerical vector")}

    #We define fold change greater than 2 as DEGs
    geneSet <- names(geneSet)[abs(geneSet)>2]

    #load in the DisGeNET annotations for disease to gene
    disgeneAnnot <- BubbleEnrich:::disgeneAnnot
    diseaseTOgene <- disgeneAnnot[, c("diseaseId", "geneId")]
    diseaseTOname <- disgeneAnnot[, c("diseaseId", "diseaseName")]

    #enrichment using clusterProfiler's enricher() function
    enrich <- clusterProfiler::enricher(geneSet, TERM2GENE = diseaseTOgene, TERM2NAME = diseaseTOname)
    enrich <- geneIDsort(enrich, input$enrichmentSize)

    #define different colour schemes for plot depending on user input
    # helper function for defined colours
    lowcolour <- colourInput(input$lowcolour, "lowcolour")
    highcolour <- colourInput(input$highcolour, "highcolour")

    #plot the enrichment results as a bubble plot using ggplot
    g <- ggplot2::ggplot(enrich[], ggplot2::aes(x = BgRatio, y = pvalue, size = Count, fill = pvalue)) +
      ggplot2::geom_point(shape = 21, alpha = 0.3) +
      ggplot2::scale_size(range = c(.1, 17), name = "Count") +
      ggrepel::geom_text_repel(ggplot2::aes(x = BgRatio, y = pvalue, label = Description), size = 2, point.padding = NA, segment.color = NA) +
      ggplot2::ggtitle("Disease Ontology Enrichment") +
      ggplot2::scale_fill_continuous(low = lowcolour, high = highcolour) +
      ggplot2::theme_bw() +
      ggplot2::theme(legend.position = "bottom", legend.direction = "horizontal",
                     axis.text.x = ggplot2::element_text(angle=45, hjust = 1)) +
      ggplot2::labs(fill = "-log(adjusted pvalue)", size = "Set Size")

    # information output on click
    output$click_info <- renderText({
      enrichclean <- enrich[][,c("Description", "geneID", "Count", "BgRatio", "pvalue")]
      plotinfo <- nearPoints(enrichclean, coordinfo=input$plot_click)
      html <- paste0("<strong>Disease Phenotype: </strong> ", plotinfo$Description, "<br>",
              "<strong>Genes: </strong> ", plotinfo$geneID, "<br>" ,"<strong>Gene Count: </strong>",
              plotinfo$Count)

      return(html)
    })

    return(g)
  })
}

shinyApp(ui = ui, server = server)
