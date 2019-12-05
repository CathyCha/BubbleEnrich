#' Helper Function for BubbleEnrich Function and shiny app
#'
#' A function that maps HGNC geneIDs to its corresponding HGNC symbol and filers the enrichment
#' results based on a user defined cut off value.
#'
#'
#' @param enrichData A dataframe of the disease phenotypes with its corresponding geneIDs that
#' contribute to it's enrichment
#' @param sizeFilter A positive integer that defines the cut off value for enrichment result size
#' @return a enrichResult object
#'
#' @author \href{https://orcid.org/0000-0003-4609-4965}{Cathy Cha} (aut)
#'
#' @examples
#' \dontrun{
#' geneIDsort(enrichData, 5)
#' }
#'
#'
#' @export
geneIDsort <- function(enrichData, sizeFilter){

# load("data/HGNCAnnot.rda");
# HGNCAnnot <- BubbleEnrich:::HGNCAnnot

#split up the geneIDs
geneIDs <- enrichData@result
#save the gene data for each enrichment result as a list of string
# strings in the list correspond to the HGNC ID, which we will map to a
# more easily read HGNC symbol later
geneIDs$geneID <- strsplit(geneIDs$geneID, "/")


#maps the geneIDs to its HGNC symbol and saves it as a vector in the dataframe
for (i in 1:nrow(geneIDs)) {
  HGNCsym <- vector()
  for (j in 0:length(geneIDs$geneID[[i]])) {
    k = c(HGNCAnnot[which(HGNCAnnot$HGNC.ID == geneIDs$geneID[[i]][j]),]$Approved.symbol)
    HGNCsym <- c(HGNCsym, k)
    j = j + 1
  }
  geneIDs$geneID[[i]] = HGNCsym
  i = i + 1
}

if(missing(sizeFilter)){
 sizeFilter <- 5
}

#filter data so that only enrichments greater than 5 contributing genes are considered
#also cleans up enrichments with no HGNC symbol mapping
#change with shiny later upon input
idsToRemove <- sapply(geneIDs$geneID, function(i) length(i) > sizeFilter)
geneIDFilter <- geneIDs[c(idsToRemove),]

enrichData@result <- geneIDFilter

return(enrichData)
}
