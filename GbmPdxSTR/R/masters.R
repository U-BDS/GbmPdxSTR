#' masters
#' Masters match algorithm for STR profiling. Computes and return the score.
#' The denominator (total_alleles)
#' @param shared_allele  The number of shared alleles between query and reference
#' @param total_allele The total alleles present in either the query (original Masters)
#' or the reference (modified Masters)
#'
#' @return Masters score
#' @export
#'
#' @examples masters(shared_allele = 13, total_allele = 15)
masters <- function(shared_allele,
                    total_allele) {
  score <- (shared_allele / total_allele) * 100

  return(score)
}

