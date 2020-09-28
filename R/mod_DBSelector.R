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
#' 
#' 
mod_DBSelector_ui <- function(id){
  ns <- NS(id)
  list_selec<- c('Total Ciudad de México' , 'Álvaro Obregón' , 'Azcapotzalco' , 'Benito Juárez' , 'Coyoacán',
                 'Cuajimalpa de Morelos' , 'Cuauhtémoc' , 'Gustavo A. Madero' ,
                 'Iztacalco' , 'Iztapalapa' , 'La Magdalena Contreras' , 'Miguel Hidalgo',
                 'Milpa Alta' , 'Tlalpan' , 'Tláhuac' , 'Venustiano Carranza', 'Xochimilco')
  tipo_incidentes <- c("ACCIDENTE" ,"LESIONADO" ,"DECESO" , 'TODOS')
  # bases<-c('FGJ' , 'SSC' , 'C5' , 'AXA' , 'Repubikla')
  bases<-c("FGJ" , "SSC" , "AXA" )
  fluidPage(
      selectInput(inputId = ns("filtro_lugar") , label = "Área de Análisis",
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
            )#,
            #  column(6,
            #       DT::dataTableOutput(outputId = ns( 'table_FGJ' )),
            # #     DT::dataTableOutput(outputId = ns( 'table_SSC' )),
            # #     DT::dataTableOutput(outputId = ns( 'table_AXA' )),
            #      textOutput(ns('txt'))
            #  )
      )
  )
}

#' DBSelector Server Function
#' @rdname mod_DBSelector
#' @export
#' @keywords internal
#' 
mod_DBSelector_server <-  function(input, output, session, interval_ba_rea){
  ns <- session$ns
  cdmx <- sf::read_sf(dsn = "./data/cdmx.shp", layer = "cdmx")
  
  # print(ns)
  datafram_re <- reactive({
    
    dataframe_fil <- readRDS("./data-raw/fuentes_unidas.rds")
    dataframe_fil <- dataframe_fil[dataframe_fil$fuente %in% input$filtro_bd,]   
    if(input$filtro_incidente != 'TODOS'){
      
      print(input$filtro_incidente)
      dataframe_fil <-dataframe_fil[dataframe_fil$tipo_incidente == input$filtro_incidente,]
      ##### Remove the ones that are NA  #### Since the ones that are not specific are not pass 
      dataframe_fil <- dataframe_fil[!is.na(dataframe_fil$tipo_incidente),] 
    }
    
    #### filtro fecha 
    interval_bar <- interval_ba_rea()
    
    
    # dataframe_fil <- dataframe_fil[dataframe_fil$timestamp %within%
    #                                  lubridate::interval(lubridate::ymd(interval_bar[1]),
    #                                                      lubridate::ymd(interval_bar[2])
    #                                                      ),
    #                                ]
    dataframe_fil <- dplyr::filter(dataframe_fil,
                                  (dataframe_fil$timestamp > lubridate::ymd(interval_bar[1])
                                   &
                                  dataframe_fil$timestamp < lubridate::ymd(interval_bar[2]))
                                  )    
    if (input$filtro_lugar != 'Total Ciudad de México') {
      tmp_contains <- sf::st_contains(
        sf::st_transform(
          cdmx[cdmx$nom_mun ==input$filtro_lugar,],
          32614
        ),
        dataframe_fil
      )
      dataframe_fil <- dataframe_fil[tmp_contains[[1]],]
    }
    return(dataframe_fil)
  })
  return(datafram_re)
}  
  


## To be copied in the UI
# mod_DBSelector_ui("DBSelector_ui_1")
    
## To be copied in the server
# callModule(mod_DBSelector_server, "DBSelector_ui_1")
 
