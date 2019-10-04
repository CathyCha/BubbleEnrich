# BubbleEnrich.R
#'
#' \code{BubbleEnrich} gets a ranked gene set of interest with related phenotypes and outputs a
#' bubble graph with bubbles diameters correlated to the significance of the phenotype to the
#' gene set and corresponding genes contributing to the enrichment spreading from the disease bubbles.
#'
#'
#' @param geneList - a numeric, named vector, sorted in descending order
#'
#' @author \href{https://orcid.org/0000-0003-4609-4965}{Cathy Cha} (aut)
#'
#' @examples
#' \dontrun{
#' data(geneList)
#' BubbleEnrich(geneList)
#' }
#' @export
BubbleEnrich <- function(geneList) {

#We define fold change greater than 2 as DEGs
geneList <- names(geneList)[abs(geneList)>2]

#load in the DisGeNET annotations for disease to gene
load("./data/disgeneAnnot.rda")
diseaseTOgene <- disgeneAnnot[, c("diseaseId", "geneId")]
diseaseTOname <- disgeneAnnot[, c("diseaseId", "diseaseName")]

#enrichment using clusterProfiler's enricher() function
enrich <- clusterProfiler::enricher(geneList, TERM2GENE = diseaseTOgene, TERM2NAME = diseaseTOname)

#plot the enrichment results as a bubble plot using ggplot
g <- ggplot2::ggplot(enrich[], ggplot2::aes(x = BgRatio, y = -log(p.adjust), size = Count, fill = -log(p.adjust))) +
  ggplot2::geom_point(shape = 21, alpha = 0.3) +
  ggplot2::scale_size(range = c(.1, 17), name = "Count") +
  ggrepel::geom_text_repel(ggplot2::aes(x = BgRatio, y = -log(p.adjust), label = Description), size = 2, point.padding = NA, segment.color = NA) +
  ggplot2::ggtitle("Disease Ontology Enrichment") +
  ggplot2::scale_fill_continuous(low = "plum1", high = "purple4") +
  ggplot2::theme_bw() +
  ggplot2::theme(legend.position = "bottom", legend.direction = "horizontal",
        axis.text.x = element_text(angle=45, hjust = 1)) +
  ggplot2::labs(fill = "-log(adjusted pvalue)", size = "Set Size") +
  ggrepel::geom_text_repel(ggplot2::aes(x = BgRatio, y = -log(p.adjust), label = strsplit((geneID), split="/")) , size = 2)

g
}


# [END]
