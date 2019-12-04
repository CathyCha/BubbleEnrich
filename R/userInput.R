# userInput.R
#'
#' \code{userInput}
#'
#'
#' @param geneSet - string path to the gene set user wants to use, store in a csv file
#' @return a numeric vector sorted in decreasing order with name as geneID and numeric value as fold change
#'
#' @author \href{https://orcid.org/0000-0003-4609-4965}{Cathy Cha} (aut)
#'
#' @examples
#' \dontrun{
#'
#' numVec <- userInput("")
#' }
#'
#' @export
userInput <- function(geneSet){

#read in the csv file from user defined path
userGeneSet <-read.csv(geneSet)

#check if input is valid
if (length(userGeneSet) == 0) {stop("Gene Set is empty")}

#numerical vector of input genes
geneSet <- userGeneSet[,2]
#named numerical vector
names(geneSet) <- as.character(userGeneSet[,1])


#check if geneIDs are valid geneIDs


#sort the genes in decreasing order, if not already sorted
if (order(GeneSet, decreasing = FALSE)) {
  #sort in decreasing order
  geneSet <- sort(geneSet, decreasing = TRUE)
}


#fold change greater than 2 defined as DEGs
geneSet <- names(geneSet)[abs(geneSet)>2]


#return the vector
return(geneSet)
}

# [END]
