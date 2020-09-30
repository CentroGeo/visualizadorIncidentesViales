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
  callModule(mod_infoBdUI_server, "infoBdUI_ui_1", parent = session)
  data <- callModule(mod_csvFileUI_server, "csvFileUI_ui")
  output$tabla <- DT::renderDataTable({data()})
  # List the first level callModules here
  #callModule(mod_landingPageUI_server, "landing")
  # data <- callModule(mod_csvFileUI_server, "csvFileUI_ui")
  # output$tabla <- DT::renderDataTable({data()})
  # save <- callModule(mod_saveDataUI_server, "saveDataUI_ui", datos = data)

  ##########LayOut######
  callModule(mod_mapa_server, "mapa_ui_1")
  #data_ou t<- callModule(mod_DBSelector_server, "DBSelector_ui_1")
  inter_bar_call <- callModule(mod_bar_server, "bar_ui_1")
  data_out <- callModule(mod_DBSelector_server, "DBSelector_ui_1", inter_bar_call)
  
  output$tabla_todos <- DT::renderDataTable({data_out()})
  callModule(mod_graficas_server, "graficas_ui_1" ,data_out)
  
  



app_server <- function( input, output, session ) {
  # List the first level callModules here
  callModule(mod_mapa_server, "mapa_ui_1")
  #data_out<- callModule(mod_DBSelector_server, "DBSelector_ui_1")
  # print(data_out) 
  # print(data_out[[1]]())
   #output$tabla_FGJ <- DT::renderDataTable({data_out[[1]]()})
   #output$tabla_SSC <- DT::renderDataTable({data_out[[2]]()})
   #output$tabla_AXA <- DT::renderDataTable({data_out[[3]]()})
  # 
  inter_bar_call <- callModule(mod_bar_server, "bar_ui_1")
  data_out<- callModule(mod_DBSelector_server, "DBSelector_ui_1", inter_bar_call)
  # print(head(data_out()))
  output$tabla_todos <- DT::renderDataTable({data_out()})
  callModule(mod_graficas_server, "graficas_ui_1" ,data_out)
  
  
  
>>>>>>> layout_visualizador
}
