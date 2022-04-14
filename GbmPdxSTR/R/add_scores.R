#' @include tanabe.R masters.R
NULL

#' add_scores
#' Adds matching scores between query and reference to the reference data containing all markers
#' @param ref_alleles_data processed reference data - should be the output of `add_share_ref_alleles_data()`
#' @param query_alleles_data processed query data - should be the output of `add_query_alleles_data()`
#' @param scoring_algorithm choice of scoring algorithm: `tanabe` or `masters`
#' @param masters_denominator if `masters` is chosen in `scoring_algorithm`, choose the which denominator
#' to use in computation. Should be either `query` (original Masters) or `reference` (modified Masters)
#'
#' @return A new reference data.frame containing the matching scores between query and each marker in the reference.
#' @export
#'
#' @examples
#' \dontrun{
#' add_scores(ref_alleles_data = add_share_ref_alleles_data(query),
#' query_alleles_data = add_query_alleles_data(query),
#' scoring_algorithm = "tanabe")
#' }
add_scores <- function(ref_alleles_data,
                       query_alleles_data,
                       scoring_algorithm = c("tanabe", "masters"),
                       masters_denominator = c("query", "reference")) {

  # evaluate scoring choices:
  scoring_algorithm <- match.arg(scoring_algorithm)

  # total alleles from query:
  query_total <- query_alleles_data$total_alleles

  # compute scores and adds them to every marker in ref_allele_data via apply
  # reminder that for apply we subset the reference
  # to only contain the needed data to compute scores

  if (scoring_algorithm == "tanabe") {
    ref_alleles_data$Score <- round(
      apply(
        subset(ref_alleles_data,
               select = c("shared_alleles", "total_alleles")
        ),
        MARGIN = 1,
        function(x) {
          tanabe(
            query_total_allele = query_total,
            reference_total_allele = x["total_alleles"],
            shared_allele = x["shared_alleles"]
          )
        }
      ),
      digits = 2
    )
  } else {
    masters_denominator <- match.arg(masters_denominator)

    if (masters_denominator == "query") {
      ref_alleles_data$Score <- round(
        apply(
          subset(ref_alleles_data,
                 select = c("shared_alleles")
          ),
          MARGIN = 1,
          function(x) {
            masters(
              x["shared_alleles"],
              query_total
            )
          }
        ),
        digits = 2
      )
    } else {
      ref_alleles_data$Score <- round(
        apply(
          subset(ref_alleles_data,
                 select = c("shared_alleles", "total_alleles")
          ),
          MARGIN = 1,
          function(x) {
            masters(
              x["shared_alleles"],
              x["total_alleles"]
            )
          }
        ),
        digits = 2
      )
    }
  }
  return(ref_alleles_data)
}
