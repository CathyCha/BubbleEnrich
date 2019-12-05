#' Helper Function for BubbleEnrich shiny application
#'
#' A function that formats a .csv user input of gene set data into a numerical vector in
#' decreasing order.
#'
#'
#' @param geneSet A string path to the gene set user wants to use, stored in a csv file
#' @return a numeric vector sorted in decreasing order with name as geneID and numeric value as fold change
#'
#' @author \href{https://orcid.org/0000-0003-4609-4965}{Cathy Cha} (aut)
#'
#' @examples
#' \dontrun{
#' numVec <- userInput("/extdata/data.csv")
#' }
#'
#' @importFrom utils data read.csv
#' @export
userInput <- function(geneSet){

#read in the csv file from user defined path
userGeneSet <-read.csv(geneSet)
print(head(userGeneSet))

#check if input is valid
if (length(userGeneSet) == 0) {stop("Gene Set is empty")}

#numerical vector of input genes
geneSet <- userGeneSet[,2]
#named numerical vector
names(geneSet) <- as.character(userGeneSet[,1])

#fold change greater than 2 defined as DEGs
# geneSet <- names(geneSet)[abs(geneSet)>1]

#return the vector
return(geneSet)
}
