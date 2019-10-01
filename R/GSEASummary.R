# GSEASummary.R
#'
#' \code{GSEASummary} 
#'
#'
#' @param geneSet (list) - gene set of interest
#' @param 
#' @return (matrix) 
#'
#' @author \href{https://orcid.org/0000-0003-4609-4965}{Cathy Cha} (aut)
#' @seealso Documentation of semantic similarity calculations and GO enrichment analysis \code{\link{GOSemSim}}
#'
#'
#' @examples
#' \dontrun{
#' semanticSimilarity("PHALY")
#' }
#' @export
#' 
GSEASummary <- function(geneSet) {
  #taken from my BCB420 systems curation unit
  geneSet <- list("ADH1A", "ADH1B", "ADH1C", "ADH4", "ADH5", "ADH6", "ADH7", "ALDH1A", "ALDH2", "ALDH")
  
  #install clusterProfiler if not already installed 
  if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
  
  BiocManager::install("clusterProfiler")
  
  library(org.Hs.eg.db)
  data(geneList)
  gene <- names(geneList)[abs(geneList) > 2]
  
  #######Testing#######
  gsecc <- gseGO(geneList=geneList, ont="CC", OrgDb=org.Hs.eg.db, verbose=F)
  head(summary(gsecc))
}


# [END]