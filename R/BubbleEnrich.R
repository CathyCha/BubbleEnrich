#' Bubble Graph of Disease Phentype Enrichment Results
#'
#' This function gets a ranked gene set of interest with related phenotypes and outputs a
#' bubble graph with bubble diameters correlated to the significance of the phenotype to the
#' gene set.
#'
#'
#' @param geneList A numeric, named vector, sorted in descending order
#' @return A ggplot plot
#'
#' @author \href{https://orcid.org/0000-0003-4609-4965}{Cathy Cha} (aut)
#'
#' @examples
#' \dontrun{
#' data(geneList, package="DOSE")
#' BubbleEnrich(geneList)
#' }
#' @references
#' Guangchuang Yu, Li-Gen Wang, Yanyan Han and Qing-Yu He. clusterProfiler: an R package
#' for comparing biological themes among gene clusters. OMICS: A Journal of Integrative
#' Biology 2012, 16(5):284-287 \href{https://www.ncbi.nlm.nih.gov/pubmed/22455463}
#'
#' @import ggplot2
#' @import ggrepel
#' @import clusterProfiler
#' @export
BubbleEnrich <- function(geneList = NULL) {
#Verify input dataframe
if(is.null(geneList)) {
  # use ovarian example data from DOSE package if geneSet is not supplied
  geneList <- get(data(geneList, package="DOSE"))
}

if (is.numeric(geneList) == FALSE) {stop("Input must be of type numerical vector")}

#We define fold change greater than 2 as DEGs
geneList <- names(geneList)[abs(geneList)>2]

#load in the DisGeNET annotations for disease to gene
# disgeneAnnot <- BubbleEnrich:::disgeneAnnot
diseaseTOgene <- disgeneAnnot[, c("diseaseId", "geneId")]
diseaseTOname <- disgeneAnnot[, c("diseaseId", "diseaseName")]

#enrichment using clusterProfiler's enricher() function
enrich <- clusterProfiler::enricher(geneList, TERM2GENE = diseaseTOgene, TERM2NAME = diseaseTOname)
enrich <- geneIDsort(enrich, 5)

#plot the enrichment results as a bubble plot using ggplot
g <- ggplot2::ggplot(enrich[], ggplot2::aes(x = BgRatio, y = -log(p.adjust), size = Count, fill = -log(p.adjust))) +
  ggplot2::geom_point(shape = 21, alpha = 0.3) +
  ggplot2::scale_size(range = c(.1, 17), name = "Count") +
  ggrepel::geom_text_repel(ggplot2::aes(x = BgRatio, y = -log(p.adjust), label = Description), size = 2, point.padding = NA, segment.color = NA) +
  ggplot2::ggtitle("Disease Ontology Enrichment") +
  ggplot2::scale_fill_continuous(low = "plum1", high = "purple4") +
  ggplot2::theme_bw() +
  ggplot2::theme(legend.position = "bottom", legend.direction = "horizontal",
                 axis.text.x = ggplot2::element_text(angle=45, hjust = 1)) +
  ggplot2::labs(fill = "-log(adjusted pvalue)", size = "Set Size")

return(g)
}
