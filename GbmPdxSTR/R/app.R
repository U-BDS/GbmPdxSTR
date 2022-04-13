#------------ Configuration of the data --------------------
library(ggplot2)
library(dplyr)
library(shiny)
library(shinyjs)
library(markdown)
library(bslib)
library(DT)
library(tibble)

# global non-interactive functions, info and datasets to be shared among all
# connections per worker/process (https://shiny.rstudio.com/articles/scoping.html)
source("./home_description.R", local = TRUE)
#source("./helper_functions.R", local = TRUE)
source("./app_modules.R", local = TRUE)

main_panel_style <- "overflow-y:scroll; max-height: 1500px; max-width: 1500px; border-top: solid; border-bottom: solid; border-color: #e8e8e8"

# load reference
gbmpdx_ref <- read.csv(
  "../data/STR_GBM_PDX_Standards_wide.csv",
  stringsAsFactors = FALSE,
  colClasses = "character",
  row.names = 1
)

# markers present in reference
markers_ref <- colnames(gbmpdx_ref)
# markers_ref <- markers_ref[-1]

#----------------------- app -------------------------------
ui <- function() {
  bootstrapPage(
    "",
    useShinyjs(),
    theme = bs_theme(bootswatch = "flatly"),
    navbarPage(
      title = "GBM PDX STR search tool",
      inverse = FALSE,
      home_description,
      tabPanel(
        title = "STR Search",
        myModuleUI(id = "str_gbm")
      ),
    ),
    tags$head(tags$style(
      HTML(".shiny-output-error-validation {
                color: black;}")
    ))
  )
}

# Reminder: objects inside server function are instantiated per session...
server <- function(input, output, session) {
  shinyhelper::observe_helpers(help_dir = "helpfiles", withMathJax = FALSE)

  myModuleServer(
    id = "str_gbm",
    dataset = gbmpdx_ref
  )
}

shinyApp(ui = ui, server = server)
