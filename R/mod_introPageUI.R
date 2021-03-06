
lis_intro <- list(
    panorama_general = "Uno de los compromisos de la Secretaría de \
    Movilidad de la Ciudad de México (SEMOVI) es generar estrategias \
    de seguridad vial basadas en evidencia y para ello, es fundamental \
    entender las características de los hechos de tránsito que \
    ocurren en la ciudad.",

    panorama_general_2 =  "A partir de la liberación de datos de \
    fuentes oficiales, en materia de hechos de tránsito, la SEMOVI \
    en colaboración con el Laboratorio de Datos Geoespaciales (DataLab) \
    del Centro de Ciencias de Información Geoespacial (CentroGeo) \
    y AXA Seguros, se dieron a la tarea de desarrollar una herramienta \
    de geovisualización de información que permitiera",

    panorama_general_3 = "entender la dinámica espacial de los hechos \
    de tránsito.",


    herramienta_geovisualizacion =
      "Esta herramienta permite a los usuarios explorar y analizar de \
      forma interactiva, los datos disponibles de la Secretaría de \
      Seguridad Ciudadana (SSC), del Centro de Comando, Control, \
      Cómputo, Comunicaciones y Contacto Ciudadano de la Ciudad de México \
      (C5), de la Fiscalía General de Justicia (FGJ) y AXA Seguros."
)


#' introPageUI UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_introPageUI_ui <- function(id) {
  ns <- NS(id)
  tagList(
    tags$div(
      style = "width: 100%; height: 100%; text-align: center; padding-top: 1vh;",
      tags$div(
        style = "background-color: white; margin: auto; width: 80%; padding: 30px; border-radius: 10px;",
        tags$img(src = "www/logo_semovi.png", style = "height: 100px;"),
        tags$p(strong("Visualizador de Incidentes Viales"),
          style = "font-size: 32pt; color: #848888; padding-bottom: 15px;"),
        tags$div(
          style = "text-align: justify; margin: auto; width: 90%; font-size: 12pt; color: #697070;",
          fluidRow(
            column(
              9,
              tags$p(strong("Panorama General"),
                style = "font-size: 18pt; color: #848888; text-align: left;"),
              tags$p(lis_intro$panorama_general),
              tags$p(lis_intro$panorama_general_2, 
                    tags$b(lis_intro$panorama_general_3)
                    )
            ),
            column(
              3,
              tags$img(src = "www/img/intro_a.jpg", style = "width: 100%;")
            )
          ),
          tags$div(style = "height: 20px; background-color: white;"),
          fluidRow(
            column(
              3,
              tags$img(src = "www/img/intro_b.jpg", style = "width: 100%;")
            ),
            column(
              9,
              tags$p(
                strong("Herramienta de Geovisualización"),
                style = "font-size: 18pt; color: #848888; text-align: left;"
              ),
              tags$p(lis_intro$herramienta_geovisualizacion),
              tags$div(
                style = "font-size: 24pt; text-align: right;",
                actionButton(
                  inputId = ns("boton_ver_visualizador"),
                  label = "Ir a Visualizador",
                  icon = icon("globe-americas"),
                  style = "background-color: #00AA5A; color: white; border-color: ; font-size: 14pt;"
                )
              )
            )
          ),
          # tags$div(style = "height: 20px; background-color: white;"),
          # fluidRow(
          #   column(
          #     9,
          #     tags$p(strong(
          #       "Herramienta de Integración de Información"
          #     ), style = "font-size: 18pt; color: #848888; text-align: left;"),
          #     tags$p(
          #       "En la Ciudad de México los datos de incidentes viales  son recopilados por diferentes instituciones gubernamentales basándose en los objetivos particulares de cada una de ellas, por lo que no existe una única fuente de datos. Para la SEMOVI es importante poder contar con un panorama general, que integre los datos de las diferentes instituciones. Por lo que se desarrolló una aplicación que permite explorar los datos para complementar e integrar registros en una sola fuente."
          #     ),
          #     tags$div(
          #       style = "font-size: 24pt; text-align: left;",
          #       actionButton(
          #         inputId = "boton_ver_integracion",
          #         label = "Información sobre Herramienta de Integración",
          #         icon = icon("info-circle"),
          #         style = "background-color: #00AA5A; color: white; border-color: ; font-size: 14pt;"
          #       )
          #     )
          #   ),
          #   column(
          #     3,
          #     tags$img(src = "www/img/intro_c.jpg", style = "width: 100%;")
          #   )
          # )
        ),
        tags$div(style = "height: 20px; background-color: white;"),
        tags$div(
          style = "margin: auto; width: 90%; text-align: left; color: #848888;",
          tags$p(
            strong("Realizado en colaboración por:")
          )
        ),
        tags$div(
          style = "margin: auto; width: 100%;",
          fluidRow(
            column(3,
              tags$img(src = "www/logo_semovi.png", style = "height: 45px;")
            ),
            column(1,
              tags$img(src = "www/axa.png", style = "height: 50px;")
            ),
            column(1,
              tags$img(src = "www/conacyt.png", style = "height: 50px;")
            ),
            column(1,
              tags$img(src = "www/centrogeo.png", style = "height: 50px;")
            ),
            column(2,
              tags$img(src = "www/GeoInt-Logo-High.png",
                style = "height: 50px;")
            ),
            column(1,
              tags$img(src = "www/datalab.png", style = "height: 30px;"))
          )
        )
      )
    )
  )
}

#' introPageUI Server Function
#'
#' @noRd
mod_introPageUI_server <- function(input, output, session, parent) {
  ns <- session$ns
  observeEvent(input$boton_ver_visualizador, {
    shinydashboard::updateTabItems(parent,
      inputId = "tabs",
      selected = "visualizador"
    )
  })
  # observeEvent(input$boton_ver_visualizador, {
  #   shinydashboard::updateTabItems(parent,
  #     inputId = "menu",
  #     selected = "visualizador"
  #   )
  # })
}

## To be copied in the UI
# mod_introPageUI_ui("introPageUI_ui_1")

## To be copied in the server
# callModule(mod_introPageUI_server, "introPageUI_ui_1")
