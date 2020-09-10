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
      shinydashboard::tabItem(tabName = "intro",
        mod_introPageUI_ui("introPageUI_ui_1")
      ),
      shinydashboard::tabItem(tabName = "bd", h1("Tab Two")),
      shinydashboard::tabItem(tabName = "visualizador", h1("Tab Three"))
    )),
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
      app_title = "package"
    ),
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
    shinyjs::useShinyjs(debug = TRUE)
  )
}