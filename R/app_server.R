#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
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
                shinydashboard::menuItem(
                  "Actualización de Datos",
                  icon = icon("globe"),
                  tabName = "actualiza"
                )
    )
  })
  callModule(mod_introPageUI_server, "introPageUI_ui_1", parent = session)

  # List the first level callModules here
  #callModule(mod_landingPageUI_server, "landing")
  # data <- callModule(mod_csvFileUI_server, "csvFileUI_ui")
  # output$tabla <- DT::renderDataTable({data()})
  # save <- callModule(mod_saveDataUI_server, "saveDataUI_ui", datos = data)
}
