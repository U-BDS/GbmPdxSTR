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
    theme = bs_theme(bootswatch = "flatly"),
    navbarPage(
      title = "GBM PDX STR search tool",
      inverse = FALSE,
      home_description,
      tabPanel(
        title = "STR Search",
        myModuleUI(id = "str_gbm")
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

  # sample csv download
  output$download_template <- downloadHandler(
    filename = "single_query_blank_template.csv",

    content = function(file) {
      write.csv(read.csv("./data/single_query_blank_template.csv"), file, row.names = FALSE)
    }
  )
}

shinyApp(ui = ui, server = server)
