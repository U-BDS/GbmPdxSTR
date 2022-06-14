#------------ Configuration of the data --------------------
library(ggplot2)
library(dplyr)
library(shiny)
library(shinyjs)
library(shinyhelper)
library(markdown)
library(bslib)
library(DT)
library(tibble)

# global non-interactive functions, info and datasets to be shared among all
# connections per worker/process (https://shiny.rstudio.com/articles/scoping.html)
#TODO: change from using source to load_all()
source("./R/home_description.R", local = TRUE)
source("./R/generics.R", local = TRUE)
source("./R/summarize_allele_stats.R", local = TRUE)
source("./R/add_query_alleles_data.R", local = TRUE)
source("./R/add_share_ref_alleles_data.R", local = TRUE)
source("./R/tanabe.R", local = TRUE)
source("./R/masters.R", local = TRUE)
source("./R/add_scores.R", local = TRUE)
source("./R/process_query.R", local = TRUE)
source("./R/validate_marker_query.R", local = TRUE)
source("./R/process_multi_query.R", local = TRUE)
source("./R/summarize_multi_query.R", local = TRUE)
source("./R/save_multi_query_workbook.R", local = TRUE)
source("./R/app_modules.R", local = TRUE)

#TODO: consider increasing max-width
main_panel_style <- "overflow-y:scroll; max-height: 1500px; max-width: 1500px; border-top: solid; border-bottom: solid; border-color: #e8e8e8"

# load reference
gbmpdx_ref <- read.csv(
  "./data/STR_GBM_PDX_Standards_wide.csv",
  stringsAsFactors = FALSE,
  colClasses = "character",
  row.names = 1
)

# markers present in reference
markers_ref <- colnames(gbmpdx_ref)
# markers_ref <- markers_ref[-1]

#----------------------- app -------------------------------
ui <- function() {
  bootstrapPage("",
    useShinyjs(),
    theme = bs_theme(bootswatch = "flatly", secondary = "#2C3E50"),
    navbarPage(
      title = "GBM PDX STR search tool",
      inverse = FALSE,
      home_description,
      tabPanel(
        title = "STR Search",
        myModuleUI(id = "str_gbm")
      ),
      tabPanel(
        title = "STR multi-query Search",
        myModuleUI_multi_query(id = "str_gbm_multi_query")
      )
    ),
    tags$head(
      tags$style(
        HTML(".shiny-output-error-validation {
                color: black;
                                }")
      )
    )
  )
}


# # Reminder: objects inside server function are instantiated per session...
server <- function(input, output, session) {
  shinyhelper::observe_helpers(help_dir = "helpfiles", withMathJax = TRUE)

  myModuleServer(
    id = "str_gbm",
    dataset = gbmpdx_ref #TODO unneeded argument, here but reminder to add this to make it more modular (will need to modify functions)
  )

  myModuleServer_multi_query(
    id = "str_gbm_multi_query",
    dataset = gbmpdx_ref #TODO unneeded argument, see reminder as above
  )

}

shinyApp(ui = ui, server = server)
