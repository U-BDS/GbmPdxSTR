.onLoad <- function(libname, pkgname) {

  # NOTE: for now, will leave this data as being read by csv
  assign("gbmpdx_ref", utils::read.csv("./data/STR_GBM_PDX_Standards_wide.csv",
    stringsAsFactors = FALSE,
    colClasses = "character",
    row.names = 1
  ),
  envir = parent.env(environment())
  )

  # markers present in reference
  assign("markers_ref", colnames(gbmpdx_ref), envir = parent.env(environment()))

  # use first entry from reference as values for placeholders for manual entries
  # ensure NA is quoted to make placeholder more clear
  assign("placeholders", tidyr::replace_na(as.character(gbmpdx_ref[1, ]), "NA"), envir = parent.env(environment()))
}
