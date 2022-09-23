#' add_share_ref_alleles_data
#' Adds the number of total alleles per marker and the number of shared alleles
#' between markers in the reference vs query. The output data.frame is also
#' transformed to the format which will be viewed in the app -
#' e.g.: allele values being comma separated
#' @param query query data
#' @param include_amel logical indicating whether to include Amelogenin in score computation
#' @param reference to be implemented in STR search. May be the built-in reference from the app
#' or a custom tumor line reference with the same STR markers used in the app reference
#'
#' @return A new reference data.frame containing the number of shared alleles (vs query)
#' and total alleles per marker in the data.frame format needed by the app
#' @export
#' @import dplyr
#'
#' @examples
#' \dontrun{
#' add_share_ref_alleles_data(query)
#' }
add_share_ref_alleles_data <- function(query, include_amel = TRUE, reference = "app_reference") {
  shared_alleles_list <- list()
  total_alleles_ref_list <- list()

  stopifnot(is.logical(include_amel))

  #----- evaluate choice of reference -----

  if (reference == "app_reference") {
    reference <- gbmpdx_ref
  } else {

    # custom reference should meet standard app requirements (similar to multi-query but
    # with the goal here to have in the same initial format as the build-in reference)
    # in this case reference should be path to csv containing additional tumor lines
    reference <- process_upload(reference)

    # save col names

    reference_cols <- colnames(reference)

    reference_list <- setNames(split(reference, seq(nrow(reference))), rownames(reference))

    # validate entries in custom reference
    reference_list <- mapply(FUN = function(x) {
      x <- validate_marker_query(x, input_type = "csv")

      return(x)
    }, x = reference_list, SIMPLIFY = FALSE)

    # in this case let's for now go back to a d.f
    reference <- data.frame(matrix(unlist(reference_list),
      nrow = length(reference_list),
      byrow = TRUE
    ),
    stringsAsFactors = FALSE,
    row.names = names(reference_list)
    )

    colnames(reference) <- reference_cols
  }


  #----------------------------------------
  # message("processing query vs reference")

  # computing information for shared alleles and all references
  for (gbm in rownames(reference)) {
    tmp_marker_data_share <- setNames(data.frame(matrix(ncol = length(markers_ref), nrow = 1)), markers_ref)
    tmp_marker_data_ref <- setNames(data.frame(matrix(ncol = length(markers_ref), nrow = 1)), markers_ref)

    for (marker in markers_ref) {

      # intersect to acquire shared alleles
      # reference only has one row
      intersect_dat <- length(
        na.omit(
          intersect(
            strsplit(query[rownames(query), marker], split = ",")[[1]],
            strsplit(reference[gbm, marker], split = ",")[[1]]
          )
        )
      )

      # compute total number of alleles for all gbms
      ref_total <- length(
        na.omit(
          strsplit(reference[gbm, marker], split = ",")[[1]]
        )
      )

      tmp_marker_data_share[, marker] <- intersect_dat
      tmp_marker_data_ref[, marker] <- ref_total

      # track which ref
      tmp_marker_data_share$GBM <- gbm
      tmp_marker_data_ref$GBM <- gbm
    }

    shared_alleles_list[[gbm]] <- tmp_marker_data_share # add to list of all markers
    total_alleles_ref_list[[gbm]] <- tmp_marker_data_ref
  }

  if (include_amel == FALSE) {
    shared_alleles_list <- lapply(X = shared_alleles_list, FUN = function(x) {
      select(x, -Amel)
    })

    total_alleles_ref_list <- lapply(X = total_alleles_ref_list, FUN = function(x) {
      select(x, -Amel)
    })
  }

  # summarizing the data
  shared_allele_numbers <- summarize_allele_stats(
    shared_alleles_list,
    new_column_name = "shared_alleles"
  )
  total_ref_alleles <- summarize_allele_stats(
    total_alleles_ref_list,
    new_column_name = "total_alleles"
  )


  # create new d.f as part of output

  reference %>%
    tibble::rownames_to_column(var = "GBM") -> output_df

  output_df <- plyr::join_all(
    list(output_df, shared_allele_numbers, total_ref_alleles),
    by = "GBM",
    type = "full"
  )

  # adding data_type variable for use of `RowGroup` later on in DT

  output_df$data_type <- "reference"

  return(output_df)
}
