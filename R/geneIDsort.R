# geneIDsort.R
#'
#' \code{userInput}
#'
#'
#' @param enrichData - dataframe of the disease phenotypes with its corresponding geneIDs that contribute to it's enrichment
#' @return a vector object with phenotype with it's corresponding geneids
#'
#' @author \href{https://orcid.org/0000-0003-4609-4965}{Cathy Cha} (aut)
#'
#' @examples
#' \dontrun{
#'
#' }
#'
#' @export
geneIDsort <- function(enrichData){

# load("data/HGNCAnnot.rda");
HGNCAnnot <- BubbleEnrich:::HGNCAnnot

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

#filter data so that only enrichments greater than 10 contributing genes are considered
#also cleans up enrichments with no HGNC symbol mapping
#change with shiny later upon input
idsToRemove <- sapply(geneIDs$geneID, function(i) length(i) > 5)
geneIDFilter <- geneIDs[c(idsToRemove),]

enrichData@result <- geneIDFilter

return(enrichData)

# #make a ggrepel line for each gene in the list
# for (i in 1:nrow(geneIDs)) {
#
#   for (j in 0:length(geneIDs$geneID[[i]])) {
#
#     j = j + 1
#   }
#   i = i + 1
# }
#
# enrich@result <- geneIDs
# return
}

# [END]
