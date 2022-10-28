# deploy app

source("./global.R")

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


# Reminder: objects inside server function are instantiated per session...
server <- function(input, output, session) {
  shinyhelper::observe_helpers(help_dir = "helpfiles", withMathJax = TRUE)

  myModuleServer(
    id = "str_gbm"
  )

  myModuleServer_multi_query(
    id = "str_gbm_multi_query"
  )
}

shinyApp(ui = ui, server = server)
