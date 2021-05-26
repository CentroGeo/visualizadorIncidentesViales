#' bar UI Function
#'
#' Genera la UI para el slider de tiempo.
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
                min = as.Date("2019-01-01", "%Y-%m-%d"),
                max = lubridate::date(max(fuentes_unidas$timestamp)),
                value = c(as.Date("2020-09-09", "%Y-%m-%d"),
                          lubridate::date(max(fuentes_unidas$timestamp)))
                )
  )
}
    
#' Bar Server Function
#' 
#' Regresa un reactive con los valores seleccionados en un vector
#' strings Y-m-d
#'
#' @param input shiny internal
#'
#' @param output shiny internal
#'
#' @param session shiny internal
#'
#' @return reactive con los valores seleccionados c(fecha_min, fecha_max) strings Y-m-d
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
 
