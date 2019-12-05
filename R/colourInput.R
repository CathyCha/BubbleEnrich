#' Helper Function for BubbleEnrich shiny application
#'
#' A function that returns a colour scheme based on user input in the BubbleEnrich
#' shiny applicaton
#'
#'
#' @param colour A string corresponding to userinput colour selection
#' @param type A string representing the value of the colour (low or high p-value)
#' @return A string that represents a colour in ggplot
#'
#' @author \href{https://orcid.org/0000-0003-4609-4965}{Cathy Cha} (aut)
#'
#' @examples
#' colourInput("Purple", "highcolour")
#' colourInput("Blue", "lowcolour")
#'
#' @export
colourInput <- function(colour, type){
  #differentiate between the low and high colour values
  # lighter for low p-values and darker for high p-values
  if(type == "highcolour"){
    if(colour == "Purple"){
      colour <- "purple1"
    }else if(colour == "Blue") {
      colour <- "#4545ba"
    }else if(colour == "Red") {
      colour <- "lightcoral"
    }else if(colour == "Orange") {
      colour <- "#ff6500"
    }else if(colour == "Black") {
      colour <- "grey57"
    }else if(colour == "Green") {
      colour <- "palegreen4"
    }

  }else {
    #type == "lowcolour"
    if(colour == "Purple"){
      colour <- "plum1"
    }else if(colour == "Blue") {
      colour <- "#d8d8ff"
    }else if(colour == "Red") {
      colour <- "mistyrose"
    }else if(colour == "Orange") {
      colour <- "#fff1d8"
    }else if(colour == "Black") {
      colour <- "grey90"
    }else if(colour == "Green") {
      colour <- "lightgreen"
    }
  }

  return(colour)
}
