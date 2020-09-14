#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # List the first level UI elements here 
    
    fluidPage(
      column(6 ,
              mod_mapa_ui("mapa_ui_1")
              ),
      column(6,
             mod_DBSelector_ui("DBSelector_ui_1"),
              DT::dataTableOutput(outputId = 'tabla_FGJ' ),
              DT::dataTableOutput(outputId = 'tabla_SSC' ),
              DT::dataTableOutput(outputId = 'tabla_AXA' )
             #mod_graficas_ui("graficas_ui_1")
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
golem_add_external_resources <- function(){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
 
  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'package'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
  )
}

