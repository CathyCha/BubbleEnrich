# BubbleGSEA.R
#'
#' \code{BubbleGSEA} gets a ranked gene set of interest with related phenotypes and outputs a 
#' bubble graph with bubbles diameters correlated to the significance of the phenotype to the 
#' gene set and a tree diagram spreading from the bubbles of the specific genes that contribute 
#' to the phenotypic output. 
#'
#'
#' @param geneRank - a .cls file of the ranked genes 
#' @param pheno - a .gmt file of the phenotypes 
#' @return () 
#'
#' @author \href{https://orcid.org/0000-0003-4609-4965}{Cathy Cha} (aut)
#' @seealso TODO : Documentation of semantic similarity calculations and GO enrichment analysis \code{\link{GOSemSim}}
#'
#'
#' @examples
#' \dontrun{
#' BubbleGSEA("/data/geneList", "/data/phenotypes")
#' }
#' @export
semanticSimilarity <- function(geneRank, phenotypes) {
  
  
  
  
  
}


# [END]