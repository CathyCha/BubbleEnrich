# BubbleGSEA.R
#'
#' \code{BubbleEnrich} gets a ranked gene set of interest with related phenotypes and outputs a
#' bubble graph with bubbles diameters correlated to the significance of the phenotype to the
#' gene set and a tree diagram spreading from the bubbles of the specific genes that contribute
#' to the phenotypic output.
#'
#'
#' @param geneRank - a
#'
#' @author \href{https://orcid.org/0000-0003-4609-4965}{Cathy Cha} (aut)
#'
#' @examples
#' \dontrun{
#' data(geneList)
#' BubbleEnrich(geneList)
#' }
#' @export
BubbleGSEA <- function(geneList) {

#We define fold change greater than 2 as DEGs
geneList <- names(geneList)[abs(geneList)>2]

#load in the DisGeNET annotations for disease to gene
disgeneAnnot <- load("./data/disgeneAnnot.rda")
disease2gene = disgeneAnnot[, c("diseaseId", "geneId")]
disease2name = disgeneAnnot[, c("diseaseId", "diseaseName")]

#enrichment using clusterProfiler's enricher() function
enrich = enricher(geneList, TERM2GENE = disease2gene, TERM2NAME = disease2name)

#plot the enrichment results as a bubble plot using ggplot
g <- ggplot(enrich[], aes(x=BgRatio, y=-log(p.adjust), size = Count, fill = -log(p.adjust))) +
  geom_point(shape = 21, alpha=0.3) +
  scale_size(range = c(.1, 17), name="Count") +
  geom_text_repel(aes(x = BgRatio, y = -log(p.adjust), label = Description), size = 2, point.padding = NA, segment.color = NA) +
  ggtitle("Disease Ontology Enrichment") +
  scale_fill_continuous(low = "plum1", high = "purple4") +
  theme_bw() +
  theme(legend.position = "bottom", legend.direction = "horizontal",
        axis.text.x = element_text(angle=45, hjust = 1)) +
  labs(fill = "-log(adjusted pvalue)", size = "Set Size") +
  geom_text_repel(aes(x = BgRatio, y = -log(p.adjust), label = strsplit((geneID), split="/")) , size = 2)

g
}


# [END]
