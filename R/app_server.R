#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  # List the first level callModules here
  data <- callModule(mod_csvFileUI_server, "csvFileUI_ui")
  output$tabla <- DT::renderDataTable({data()})
  save <- callModule(mod_saveDataUI_server, "saveDataUI_ui", datos = data)
}
