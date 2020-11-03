#' mapa UI Function
#'
#' Map to display the "Accidentes viales"
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
#'
#' @return a map
mod_mapa_ui <- function(id) {
  ns <- NS(id)
  #####Aqui va el mapa
  fluidPage(
    leaflet::leafletOutput(outputId = ns("myMap"), height = "756px")
  )
}

#' mapa Server Function
#'
#' Despliega y actualiza el mapa de acuerdo a la selección del usuario.
#'
#' @param input shiny Parameter where the inputs from the UI are store
#'
#' @param output shiny parameter where the id are
#'               reference to display in the UI
#'
#' @param session shiny parameter to store the session
#'
#' @param datos reactive dataframe with data filterd by user parameters
mod_mapa_server <- function(input, output, session, datos) {
  cdmx <- sf::read_sf(dsn = "./data/cdmx.shp", layer = "cdmx")
  centroides <- sf::st_transform(cdmx, 32614) %>%
    sf::st_centroid(.) %>%
    sf::st_transform(., "+proj=longlat +ellps=GRS80 +no_defs")
  # Fijar parámetros iniciales y desplegar el mapa base
  lon <- -99.152613
  lat <- 19.320497
  zoom <- 10
  map <-  leaflet::leaflet(data = cdmx) %>%
            leaflet::addTiles(
              urlTemplate = '//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png'
              ) %>%
            leaflet::setView(lng = lon, lat = lat, zoom = zoom) %>%
            leaflet::addPolygons(fillColor = "#00A65A",
              fillOpacity = 0.10,
              color = "#006738",
              opacity = 0.75)
  output$myMap <- leaflet::renderLeaflet({map})
  # Íconos para los incidentes
  icons <- leaflet::iconList(
    DECESO_FGJ = leaflet::makeIcon("www/pgj_a.png"),
    LESIONADO_FGJ = leaflet::makeIcon("www/pgj_b.png"),
    ACCIDENTE_FGJ = leaflet::makeIcon("www/pgj_c.png"),
    DECESO_SSC = leaflet::makeIcon("www/ssc_a.png"),
    LESIONADO_SSC = leaflet::makeIcon("www/ssc_b.png"),
    ACCIDENTE_SSC = leaflet::makeIcon("www/ssc_c.png"),
    DECESO_AXA = leaflet::makeIcon("www/axa_a.png"),
    LESIONADO_AXA = leaflet::makeIcon("www/axa_b.png"),
    ACCIDENTE_AXA = leaflet::makeIcon("www/axa_c.png")
  )
  # Observamos los cambios en input de usuario
  observeEvent(datos[[1]](), ignoreNULL = FALSE, {
    # transformamos a coordenadas geográficas
    datos_4326 <- sf::st_transform(datos[[1]](), "+init=epsg:4326") %>%
      dplyr::mutate(
        latitud = sf::st_coordinates(geometry)[, 2],
        longitud = sf::st_coordinates(geometry)[, 1]
      )
    # columna para saber qué icono usar
    datos_4326 <- dplyr::mutate(datos_4326,
      icon_class = paste(tipo_incidente, fuente, sep = "_")
    )
    # si tenemos alcaldía seleccionada, centramos el mapa y hacemos zoom
    if (datos[[2]]() != "Total Ciudad de México") {
       alcaldia <- dplyr::filter(centroides, nom_mun == datos[[2]]())
       lon <- sf::st_coordinates(alcaldia)[1]
       lat <- sf::st_coordinates(alcaldia)[2]
       zoom <- 12
    }
    # Agragamos la capa de markers con los
    # incidentes seleccionados por el usuario
    leaflet::leafletProxy("myMap", session, data = datos_4326) %>%
      leaflet::clearMarkers() %>%
      leaflet::clearMarkerClusters() %>%
      leaflet::addMarkers(
        clusterOptions = leaflet::markerClusterOptions(),
        icon = ~icons[icon_class],
        popup = paste("Fuente: ", datos_4326$fuente, "<br>",
                      "Tipo de incidente: ", datos_4326$tipo_incidente, "<br>",
                      "Fecha y Hora: ", datos_4326$timestamp)
      ) %>%
      leaflet.extras::clearHeatmap() %>%
      leaflet.extras::addHeatmap(lng = ~longitud,
        lat = ~latitud,
        radius = 7) %>%
      leaflet::setView(lng = lon, lat = lat, zoom = zoom)
  })
}

## To be copied in the UI
# mod_mapa_ui("mapa_ui_1")
