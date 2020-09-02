#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  # List the first level callModules here
  datafile <- callModule(mod_csvFileUI_server, "csvFileUI_ui_1")
  output$table <- DT::renderDataTable({
    datafile()
  })

}
