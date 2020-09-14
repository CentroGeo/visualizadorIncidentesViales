#' DBSelector UI Function
#'
#' @description A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_DBSelector
#' @export
#' @importFrom shiny NS tagList 
mod_DBSelector_ui <- function(id){
  ns <- NS(id)
  list_selec<- c('Total Ciudad de México' , 'Álvaro Obregón' , 'Azcapotzalco' , 'Benito Juárez' , 'Coyoacán',
                 'Cuajimalpa de Morelos' , 'Cuauhtémoc' , 'Gustavo A. Madero' ,
                 'Iztacalco' , 'Iztapalapa' , 'La Magdalena Contreras' , 'Miguel Hidalgo',
                 'Milpa Alta' , 'Tlalpan' , 'Tláhuac' , 'Venustiano Carranza', 'Xochimilco')
  tipo_incidentes <- c('Decesos' , 'Lesionados' , 'Accidentes' , 'Todos')
  # bases<-c('FGJ' , 'SSC' , 'C5' , 'AXA' , 'Repubikla')
  bases<-c('FGJ' , 'SSC' , 'AXA' )
  fluidPage(
      selectInput(inputId = ns('filtro_lugar') , label = 'Área de Análisis',
                                    choices = list_selec
      ),
      fluidRow( 
            column(6,
                radioButtons(inputId = ns('filtro_incidente') ,
                    label = 'Tipo de Incidente' ,
                    inline = TRUE,
                    choices = tipo_incidentes
                ),
                checkboxGroupInput(inputId = ns('filtro_bd') , 
                    label = 'Base de Datos' ,
                    inline = TRUE,
                    choices = bases
                )
            ),
             column(6,
                 DT::dataTableOutput(outputId = ns( 'table_FGJ' )),
            #     DT::dataTableOutput(outputId = ns( 'table_SSC' )),
            #     DT::dataTableOutput(outputId = ns( 'table_AXA' )),
                 textOutput(ns('txt'))
             )
      )
  )
}

#' DBSelector Server Function
#' @rdname mod_DBSelector
#' @export
#' @keywords internal
#' 
mod_DBSelector_server <-  function(input, output, session){
  ns <- session$ns
  cdmx <- read_sf(dsn = "./data/cdmx.shp", layer = "cdmx")
  # print(ns)
  dataframe_FGJ <- reactive({
    tmpFGJ <- NULL
    if ('FGJ' %in% input$filtro_bd) {
      tmpFGJ<-readRDS('./data-raw/fgj.rds')
    }
  
    #print(tmpFGJ)
    if (input$filtro_incidente == 'Decesos') {
      bool1 <- tmpFGJ$delito == 'HOMICIDIO CULPOSO POR TRÁNSITO VEHICULAR (COLISION)'
      bool2 <- tmpFGJ$delito == 'HOMICIDIO CULPOSO POR TRÁNSITO VEHICULAR (ATROPELLADO)'
      bool3 <- tmpFGJ$delito == 'HOMICIDIO CULPOSO POR TRÁNSITO VEHICULAR (CAIDA)'
      bool4 <- tmpFGJ$delito == 'HOMICIDIO CULPOSO POR TRÁNSITO VEHICULAR'
      tmpFGJ <- tmpFGJ[bool1|bool2|bool3|bool4, ]
    }
    else if (input$filtro_incidente == 'Lesionados'){
      bool1 <- tmpFGJ$delito == 'LESIONES CULPOSAS POR TRANSITO VEHICULAR'
      bool2 <- tmpFGJ$delito == 'LESIONES CULPOSAS POR TRANSITO VEHICULAR EN COLISION'
      tmpFGJ <-tmpFGJ[bool1|bool2, ]
    }
    else if (input$filtro_incidente == 'Accidentes') {
      bool1 <- tmpFGJ$delito == 'DAÑO EN PROPIEDAD AJENA CULPOSA POR TRÁNSITO VEHICULAR A AUTOMOVIL'
      bool2 <- tmpFGJ$delito == 'DAÑO EN PROPIEDAD AJENA CULPOSA POR TRÁNSITO VEHICULAR A BIENES INMUEBLES'
      tmpFGJ <-tmpFGJ[bool1|bool2, ]

    }
    if (input$filtro_lugar != 'Total Ciudad de México') {
      tmp_contains <- sf::st_contains(
        sf::st_transform(
          cdmx[cdmx$nom_mun ==input$filtro_lugar,],
          32614
        ),
        tmpFGJ
      )
      tmpFGJ <- tmpFGJ[tmp_contains[[1]],]
    }
    tmpFGJ
  })
  dataframe_SSC <- reactive({
    tmpSSC <- NULL
    if ('SSC' %in% input$filtro_bd) {
      tmpSSC<-readRDS('./data-raw/ssc.rds')
    }
    if (ns(input$filtro_incidente) == 'Decesos') {
      bool1 <- tmpSSC$total_occisos > 0
      tmpSSC <- tmpSSC[bool1,]
    } else if (input$filtro_incidente == 'Lesionados') {
      bool1 <- tmpSSC$total_occisos == 0
      bool2 <- tmpSSC$total_lesionados > 0
      tmpSSC <- tmpSSC[bool1 & bool2,]
    } else if (input$filtro_incidente == 'Accidentes') {
      bool1 <- tmpSSC$total_occisos == 0
      bool2 <- tmpSSC$total_lesionados == 0
      tmpSSC <- tmpSSC[bool1 & bool2,]
    }
    if (input$filtro_lugar != 'Total Ciudad de México') {
      tmp_contains <- sf::st_contains(
        sf::st_transform(
          cdmx[cdmx$nom_mun ==input$filtro_lugar,],
          32614
        ),
        tmpSSC
      )
      tmpSSC <- tmpSSC[tmp_contains[[1]],]
    }
    tmpSSC
  })
  dataframe_AXA <- reactive({
   print(input$filtro_bd)
    tmpAXA<- NULL
  if ("AXA" %in% input$filtro_bd) {
    #print('Lectura')
    tmpAXA<-readRDS('./data-raw/axa.rds')
  }
    
    if (input$filtro_incidente == 'Decesos') {
      #print('filtro 1')
      bool1 <- tmpAXA$fallecido == 'SI'
      tmpAXA <- tmpAXA[bool1,]
    }
    else if (input$filtro_incidente == 'Lesionados') {
      #print('filtro 2')
      bool1 <- tmpAXA$fallecido != 'SI'
      bool2 <- tmpAXA$lesionados > 0
      tmpAXA <- tmpAXA[bool1 & bool2,]
    }
    else if (input$filtro_incidente == 'Accidentes') {
      #print('filtro 3')
      bool1 <- tmpAXA$fallecido != 'SI'
      bool2 <- tmpAXA$lesionados == 0
      tmpAXA <- tmpAXA[bool1 & bool2,]
    }
    if (input$filtro_lugar != 'Total Ciudad de México') {
      #print('filtro 4')
      tmp_contains <- sf::st_contains(
        sf::st_transform(
          cdmx[cdmx$nom_mun ==input$filtro_lugar,],
          32614
        ),
        tmpAXA
      )
      tmpAXA <- tmpAXA[tmp_contains[[1]],]
    }
    tmpAXA
  })

  output$txt <- renderText({
    basedatos <- paste(input$filtro_bd, collapse = ", ")
    filtros <- paste(input$filtro_incidente, collapse = ", ")
    paste("Bases seleccionadas", basedatos, "\n Filtro", filtros)
  })

  return(list( dataframe_FGJ,dataframe_SSC, dataframe_AXA))
  #return(list(dataframe_AXA))
}

## To be copied in the UI
# mod_DBSelector_ui("DBSelector_ui_1")
    
## To be copied in the server
# callModule(mod_DBSelector_server, "DBSelector_ui_1")
 
