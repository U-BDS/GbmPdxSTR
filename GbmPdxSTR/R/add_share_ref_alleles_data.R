#' @include summarize_allele_stats.R
NULL

#' add_share_ref_alleles_data
#' Adds the number of total alleles per marker and the number of shared alleles
#' between markers in the reference vs query. The output data.frame is also
#' transformed to the format which will be viewed in the app -
#' e.g.: allele values being comma separated
#' @param query query data
#' reference data (`gbmpdx_ref`) is expected to be present in the env. of the app
#'
#' @return A new reference data.frame containing the number of shared alleles (vs query)
#' and total alleles per marker in the data.frame format needed by the app
#' @export
#'
#' @examples add_share_ref_alleles_data(query)
add_share_ref_alleles_data <- function(query) {
  shared_alleles_list <- list()
  total_alleles_ref_list <- list()

  # computing information for shared alleles and all references
  for (gbm in rownames(gbmpdx_ref)) {
    message(paste0("processing query vs reference ", gbm)) ## TODO: remove this, just testing

    tmp_marker_data_share <- setNames(data.frame(matrix(ncol = length(markers_ref), nrow = 1)), markers_ref)
    tmp_marker_data_ref <- setNames(data.frame(matrix(ncol = length(markers_ref), nrow = 1)), markers_ref)

    for (marker in markers_ref) {

      # intersect to acquire shared alleles
      # reference only has one row
      intersect_dat <- length(
        na.omit(
          intersect(
            strsplit(query[rownames(query), marker], split = ",")[[1]],
            strsplit(gbmpdx_ref[gbm, marker], split = ",")[[1]]
          )
        )
      )

      # compute total number of alleles for all gbms
      ref_total <- length(
        na.omit(
          strsplit(gbmpdx_ref[gbm, marker], split = ",")[[1]]
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

  gbmpdx_ref %>%
    tibble::rownames_to_column(var = "GBM") -> output_df

  output_df <- plyr::join_all(
    list(output_df, shared_allele_numbers, total_ref_alleles),
    by = "GBM",
    type = "full"
  )

  return(output_df)
}
