# NOTE: not making this app into shiny-app package for now
# to favor use of promises_future.
# To use both, would need to resolve a similar issue to:
# https://github.com/ThinkR-open/golem/discussions/749

#-------------------------------packages-------------------------------------
library(ggplot2)
library(dplyr)
library(shiny)
library(shinyjs)
library(shinyhelper)
library(markdown)
library(bslib)
library(DT)
library(tibble)
library(promises)
library(future)

plan(multisession)

#--------------------------custom functions----------------------------------
lapply(list.files("./R"), FUN = function(x) source(paste0("./R/", x)))
#--------------------------global variables-----------------------------------
# load reference
gbmpdx_ref <- read.csv(
  "./data/STR_GBM_PDX_Standards_wide.csv",
  stringsAsFactors = FALSE,
  colClasses = "character",
  row.names = 1
)

# markers present in reference
markers_ref <- colnames(gbmpdx_ref)

# use first entry from reference as values for placeholders for manual entries
# ensure NA is quoted to make placeholder more clear

placeholders <- tidyr::replace_na(as.character(gbmpdx_ref[1, ]), "NA")
