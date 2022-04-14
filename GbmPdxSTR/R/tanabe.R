#' tanabe
#' Tanabe match algorithm for STR profiling. Computes and return the score
#' @param query_total_allele The total alleles present in the query
#' @param reference_total_allele The total alleles present in the reference
#' @param shared_allele The number of shared alleles between query and reference
#'
#' @return Tanabe score
#' @export
#'
#' @examples tanabe(query_total_allele = 15,reference_total_allele = 16,shared_allele = 13)
tanabe <- function(query_total_allele,
                   reference_total_allele,
                   shared_allele) {
  score <- (2 * shared_allele / (query_total_allele + reference_total_allele)) * 100

  return(score)
}
