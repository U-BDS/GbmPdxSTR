#' summarize_allele_stats
#' This function processes a list of alleles into a summarized data.frame (e.g.: sums alleles across marker etc.)
#' It's meant to be a helper function to other primary functions in the app
#' @param allele_input input data containing the total or shared number of alleles
#' @param new_column_name column name in output data.frame
#' @param perform_binding options to perform binding in input data - needed for reference data; optional for query
#'
#' @return A data frame of summarized allelic information
#' @export
#'
#' @examples summarize_allele_stats(shared_alleles_list, new_column_name="shared_alleles")
summarize_allele_stats <- function(allele_input, new_column_name, perform_binding = TRUE) {

  # instead of bind rows can also do.call(rbind,shared_alleles_list),
  # but faster with bind_rows...
  if (perform_binding == TRUE) {
    allele_input <- dplyr::bind_rows(allele_input)
  }

  allele_input %>%
    tibble::column_to_rownames(var = "GBM") %>% # tmp to avoid index for rowsums
    mutate({{new_column_name}} := rowSums(.)) %>%
    tibble::rownames_to_column(var = "GBM") %>%
    # subset only to the new_column_name
    .[,c("GBM",new_column_name)] -> summarized_allele_df

  return(summarized_allele_df)
}
