#' bar UI Function
#'
#' Generate a bar to get a time interval
#'
#'
#' @param id Internal parameters for {shiny}.
#'
#'
#' @importFrom shiny NS tagList
#'
mod_bar_ui <- function(id) {
  ns <- NS(id)
  fluidRow(
    sliderInput(inputId = ns("filtro_fecha"),
                label = "Periodo de Tiempo",
                width = "100%",
                timeFormat = "%d/%m/%Y",
                # TODO: deben venir de los datos
                min = as.Date("2018-01-01", "%Y-%m-%d"),
                max = as.Date("2020-09-09", "%Y-%m-%d"),
                value = c(as.Date("2019-08-01", "%Y-%m-%d"),
                        as.Date("2020-09-09", "%Y-%m-%d"))
                )
  )
}
    
#' Bar Server Function
#' ¿
#' The function returns a reactive function that returns a vectors with the
#'  date of the interval
#'
#' @param input shiny internal
#'
#' @param output shiny internal
#'
#' @param session shiny internal
#'
#' @return Reactive function that returns a vector with a time interval
#' (min, max) dates
mod_bar_server <- function(input, output, session) {
  ns <- session$ns
  interval_val <- reactive({
    input$filtro_fecha
  })
  return(interval_val)
}
    
## To be copied in the UI
# mod_bar_ui("bar_ui_1")
    
## To be copied in the server
# callModule(mod_bar_server, "bar_ui_1")
 
