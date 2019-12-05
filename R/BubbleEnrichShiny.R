#' shiny app for BubbleEnrich Package
#'
#' A function that launches the shiny app for this package.
#' The code has been placed in \code{./inst/shiny-scripts}.
#'
#' @return No return value but open up a shiny page.
#'
#' @examples
#' \dontrun{
#' BubbleEnrichShiny()
#' }
#'
#' @export
#' @importFrom shiny runApp

BubbleEnrichShiny <- function() {
  appDir <- system.file("shiny-scripts",
                        package = "BubbleEnrich")
  shiny::runApp(appDir, display.mode = "normal")
  return()
}

