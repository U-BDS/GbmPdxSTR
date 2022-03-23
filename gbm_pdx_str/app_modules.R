# app modules

#TODO: from reference files, can grab markers from there
#STR_markers <-

#-------------------------------------------UI-----------------------------------------------------

myModuleUI <- function(id) {
  ns <- NS(id)
  
  sidebarLayout(
    sidebarPanel(width = 3,
                 selectInput(inputId = ns("markers"),
                             label = "Add STR data or choose to load file",
                             choices = as.character(c("one","two")),
                             multiple = FALSE)
    ),
    
    mainPanel(width = 9, style = main_panel_style,
              #DT::dataTableOutput(ns("filtered_data"))
    )
  )
}


#-------------------------------------------SERVER-----------------------------------------------------

myModuleServer <- function(id, dataset) {
  moduleServer(
    id,
    function(input, output, session) {
      # output$result <- renderText({
      #   paste0(prefix, toupper(input$txt))
      # })
    }
  )
}
