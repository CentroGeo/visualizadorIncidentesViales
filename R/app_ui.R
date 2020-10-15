#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd

app_ui <- function(request) {
  shinydashboard::dashboardPage(
    # title = 'Visualizador de Datos de Incidentes Viales - SEMOVI',
    # skin = 'green',
    shinydashboard::dashboardHeader(
      title = "Visualizador de Datos de Incidentes Viales - SEMOVI"),
    shinydashboard::dashboardSidebar(shinydashboard::sidebarMenuOutput("menu")),
    shinydashboard::dashboardBody(shinydashboard::tabItems(
  ##############Introduccion##########
      shinydashboard::tabItem(tabName = "intro",
        mod_introPageUI_ui("introPageUI_ui_1")
      ),
      shinydashboard::tabItem(tabName = "bd", mod_infoBdUI_ui("infoBdUI_ui_1")),
      ########### Visualizador#################
      shinydashboard::tabItem(
                          tabName = "visualizador",
                          fluidPage(
                             column(6,
                               mod_mapa_ui("mapa_ui_1"),
                               mod_bar_ui("bar_ui_1")
                             ),
                             column(6,
                                mod_DBSelector_ui("DBSelector_ui_1"),
                                mod_graficas_ui("graficas_ui_1")
                            )
                        )
                    ),
      ######## Actualizacion########
      shinydashboard::tabItem(tabName = "actualiza",
        mod_csvFileUI_ui("csvFileUI_ui", label = "Selecciona un CSV"),
        DT::dataTableOutput("tabla")
        )
    ),
    tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # List the first level UI elements here

    )
 )
) 
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path("www", app_sys("app/www"))

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "Visualizador de Incidentes Viales CDMX"
    ),
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
    shinyjs::useShinyjs(debug = TRUE)
  )
}