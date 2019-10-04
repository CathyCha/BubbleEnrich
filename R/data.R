#' Disease to Gene Annotations from DisGeNET
#'
#'
#' @source \url{http://www.disgenet.org/static/disgenet_ap1/files/downloads/all_gene_disease_pmid_associations.tsv.gz}
#'
#' @format A dataframe with 1548061 rows and 14 columns
#' \describe{
#'  \item{geneID}{NCBI Entrez Gene Identifier}
#'  \item{geneSymbol}{Official Gene Symbol}
#'  \item{DSI}{The Disease Specificity Index for the gene}
#'  \item{DPI}{The Disease Pleiotropy Index for the gene}
#'  \item{diseaseId}{UMLS concept unique identifier}
#'  \item{diseaseName}{Name of the disease}
#'  \item{diseaseType}{The DisGeNET disease type: disease, phenotype and group}
#'  \item{diseaseSemanticType}{The UMLS Semantic Type(s) of the disease}
#'  \item{score}{DisGENET score for the Gene-Disease association}
#'  \item{EI}{The Evidence Index for the Gene-Disease association}
#'  \item{YearInitial}{First time that the Gene-Disease association was reported}
#'  \item{YearFinal}{Last time that the Gene-Disease association was reported}
#'  \item{pmid}{Publication reporting the Gene-Disease association}
#'  \item{source}{Original source reporting the Gene-Disease association}
#' }
#' @examples
#' \dontrun{
#'  disgeneAnnot
#' }
"disgeneAnnot"
