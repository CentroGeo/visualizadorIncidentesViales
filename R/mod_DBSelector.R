#' DBSelector UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_DBSelector_ui <- function(id){
  ns <- NS(id)
  tagList(
    
 
  )
}
    
#' DBSelector Server Function
#'
#' @noRd 
mod_DBSelector_server <- function(input, output, session){
  ns <- session$ns
 
}
    
## To be copied in the UI
# mod_DBSelector_ui("DBSelector_ui_1")
    
## To be copied in the server
# callModule(mod_DBSelector_server, "DBSelector_ui_1")
 
