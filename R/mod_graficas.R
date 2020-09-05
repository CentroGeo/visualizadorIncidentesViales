#' graficas UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_graficas_ui <- function(id){
  ns <- NS(id)
  tagList(
 
  )
}
    
#' graficas Server Function
#'
#' @noRd 
mod_graficas_server <- function(input, output, session){
  ns <- session$ns
 
}
    
## To be copied in the UI
# mod_graficas_ui("graficas_ui_1")
    
## To be copied in the server
# callModule(mod_graficas_server, "graficas_ui_1")
 
