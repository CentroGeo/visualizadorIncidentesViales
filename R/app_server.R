#' The application server-side
#' Define la estructura general de la aplicación
#' sidebar, paneles, etc
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  actualizar <- getOption("Actualizar_datos")
  output$menu <- shinydashboard::renderMenu({
    shinydashboard::sidebarMenu(id = "tabs",
                shinydashboard::menuItem(
                  "Introducción",
                  icon = icon("door-open"),
                  tabName = "intro"
                ),
                shinydashboard::menuItem(
                  "Bases de Datos",
                  icon = icon("layer-group"),
                  tabName = "bd"
                ),
                shinydashboard::menuItem(
                  "Visualizador",
                  icon = icon("globe"),
                  tabName = "visualizador"
                ),
                if (actualizar) {
                  shinydashboard::menuItem(
                    "Actualización de Datos",
                    icon = icon("globe"),
                    tabName = "actualiza"
                  )
                }
    )
  })
  ##### Módulos de UI ######
  # Introducción
  callModule(mod_introPageUI_server, "introPageUI_ui_1", parent = session)
  # Info de BD
  callModule(mod_infoBdUI_server, "infoBdUI_ui_1", parent = session)
  ##### Módulos del servidor #####
  # Time slider
  inter_bar_call <- callModule(mod_bar_server, "bar_ui_1")
  # Actualización de datos
  if (actualizar) {
    data <- callModule(mod_csvFileUI_server, "csvFileUI_ui")
    output$tabla <- DT::renderDataTable({data()})
  }
  # Leemos todos los datos completos una sola vez
  # Selector de bases de datos
  data_out <- callModule(mod_DBSelector_server,
    "DBSelector_ui_1",
    inter_bar_call,
    fuentes_unidas
  )
  # Gráficas
  callModule(mod_graficas_server, "graficas_ui_1", data_out[[1]])
  # Mapa
  callModule(mod_mapa_server, "mapa_ui_1", data_out)
}
