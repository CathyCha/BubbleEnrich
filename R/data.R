#' Disease to Gene Annotations from DisGeNET
#'
#' @source \url{http://www.disgenet.org/static/disgenet_ap1/files/downloads/all_gene_disease_pmid_associations.tsv.gz}<br/>
#' @format A dataframe with 1548061 rows and 3 columns
#' \describe{
#'  \item{geneID}{NCBI Entrez Gene Identifier}
#'  \item{diseaseId}{UMLS concept unique identifier}
#'  \item{diseaseName}{Name of the disease}
#' }
#' @examples
#' \dontrun{
#'  disgeneAnnot
#' }
"disgeneAnnot"

#' HGNC geneId to HGNC symbol annotation data
#'
#' @source \url{https://www.genenames.org/cgi-bin/download/custom?col=gd_hgnc_id&col=gd_app_sym&col=gd_app_name&col=gd_status&col=gd_prev_sym&col=gd_aliases&col=gd_pub_chrom_map&col=gd_pub_acc_ids&col=gd_pub_refseq_ids&col=md_eg_id&status=Approved&status=Entry%20Withdrawn&hgnc_dbtag=on&order_by=gd_app_sym_sort&format=text&submit=submit}<br/>
#' @format A dataframe with 46736 rows and 2 columns
#' \describe{
#'  \item{HGNC.ID}{HGNC gene ID}
#'  \item{Approved.symbol}{HGNC approved gene symbols}
#' }
#' @examples
#' \dontrun{
#'  HGNCAnnot
#' }
"HGNCAnnot"
