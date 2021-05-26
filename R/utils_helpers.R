#' Preprocesa archivo csv de Fiscalía
#'
#' @param fgj tabla con los datos de fiscalía leídos de csv
#'
#' @return Tabla con los datos preprocesados listos para utilizarse 
#' en la plataforma.
#' 
#'
preprocesa_pgj <- function(pgj) {
  #### Se eliminan los duplicados
  pgj <- dplyr::filter(pgj , grepl("TRANSITO",Delito) | grepl("TRÁNSITO",Delito))  
  pgj <- dplyr::distinct(pgj,idCarpeta , .keep_all= TRUE)
  ## Se eliminan los que no tienen fecha
  pgj <- pgj[!is.na(pgj$FechaHecho),]
  ### Se eliminan los que no tienen hora 
  pgj <- pgj[!is.na(pgj$HoraHecho),]
  pgj['fecha_hechos'] <- lubridate::dmy( pgj$FechaHecho )
  pgj['hora_hechos'] <- lubridate::hms(pgj$HoraHecho)                        
  pgj['timestamp'] <- pgj$fecha_hechos + pgj$hora_hechos
  ### Hasta acá
  pgj <-
     dplyr::filter( pgj,
       timestamp >= lubridate::parse_date_time("2019-01-01", "Y-m-d")
      )
  pgj["geopoint"] <- NULL
  pgj <- pgj[order(pgj$timestamp), ]
  pgj["id"] <- seq.int(nrow(pgj))
  pgj <- dplyr::filter(pgj, !is.na(latitud) & !is.na(longitud))
  pgj <- dplyr::filter(pgj, !is.na(timestamp))
  pgj <- sf::st_transform(sf::st_as_sf(
    pgj,
    coords = c("longitud", "latitud"),
    crs = 4326
  ), 32614)
  return(pgj)
}



#' Preprocesa archivo csv de Fiscalía
#'
#' Lee el rds original y permite incorporar los nuevos datos usando la fecha 
#'
#' @param fgj_new tabla con los datos de fiscalía leídos de csv
#'
#' @return Tabla con los datos preprocesados listos para utilizarse 
#' en la plataforma.
#' 
#'
preprocesa_pgj_origin <- function(fgj_new) {
  df_old <- readRDS("./data-raw/fgj.rds")
  max_date_fgj <- max(df_old$fecha_hechos)
  fgj_red_pre <- preprocesa_pgj(fgj_new)
  fgj_red_pre <- fgj_red_pre[fgj_red_pre$fecha_hechos > max_date_fgj, ]
  ##### esto se debe de cambiar pero es la solucion facil
  df_old$fecha_hechos <- as.character(df_old$fecha_hechos)
  fgj_red_pre$fecha_hechos <- as.character(fgj_red_pre$fecha_hechos)
  df_old$timestamp <- as.character(df_old$timestamp)
  fgj_red_pre$timestamp <- as.character(fgj_red_pre$timestamp)
  df_old$fecha_inicio <- as.character(df_old$fecha_inicio)
  fgj_red_pre$fecha_inicio <- as.character(fgj_red_pre$fecha_inicio)
  ####
  sf::st_crs(df_old) <- 32614
  fgj_all <- rbind(df_old, fgj_red_pre)
  ##### regresar como se debe
  fgj_all$fecha_hechos <- lubridate::as_datetime(fgj_all$fecha_hechos)
  fgj_all$fecha_inicio <- lubridate::as_date(fgj_all$fecha_inicio)
  fgj_all$timestamp <- lubridate::as_datetime(fgj_all$timestamp)
  return(fgj_all)
}





#' Preprocesa archivo csv de Secretaría de Seguridad Ciudadana
#'
#' @param ssc Tabla con los datos de SSC leídos de csv
#'
#' @return Tabla con los datos preprocesados listos para utilizarse
#'  en la plataforma.
#' 
#'
#' 
preprocesa_ssc <- function(ssc) {
  ssc <- ssc %>% dplyr::filter(hora != "SD" & unidad_a_cargo != "SD")
  ssc$hora_bien <- lubridate::hm(ssc$hora)
  ssc[is.na(ssc$hora_bien),]$hora_bien <- lubridate::hms(ssc[is.na(ssc$hora_bien),]$hora)
  ssc$timestamp <- with(ssc, lubridate::dmy(ssc$fecha_evento) + ssc$hora_bien)
  ssc <- dplyr::filter(ssc,!is.na(coordenada_y) & !is.na(coordenada_x))
  ssc <- sf::st_transform(sf::st_as_sf(
    ssc,
    coords = c("coordenada_y", "coordenada_x"),
    crs = 4326
  ), 32614)
  return(ssc)
}



#' Preprocesa los datos de AXA
#'
#'Preprocess the data from the tables in the AXA site
#'
#'
preprocesa_axa_origin <- function(axa_new) {

  ### axa is the new and should have the corresponding column names
  #### Read old axa
  # df_old <- readr::read_delim("./data-raw/AXA.csv",
  #                         col_names = TRUE,
  #                         quote = "\"",
  #                         delim = ";"
  # )

  df_old <- readRDS("./data-raw/axa.rds")
  max_timestamp_old <- max(df_old$timestamp)
  # TODO: en realidad tiene que haber dos de estas porque estos datos 
  #       pueden venir en dos formatos diferentes
  axa_red_pre <- preprocesa_axa_nuevos_datos(axa_new)
  #axa_red_pre$mes<- as.integer(axa_red_pre$mes)
  axa_red_pre <- axa_red_pre[axa_red_pre$timestamp >= max_timestamp_old, ]
  #axa_red_pre$timestamp <-as.chron(axa_red_pre$timestamp)
  cols <- c("fallecido", "geometry", "timestamp", "lesionados")
  df_old <- dplyr::select(df_old, tidyselect::all_of(cols))
  axa_red_pre <- dplyr::select(axa_red_pre, tidyselect::all_of(cols))
  axa_all <- rbind(df_old, axa_red_pre)
  return(axa_all)
}




#' Preprocesa archivo csv de AXA
#'
#' @param axa Tabla con los datos de AXA leídos de csv
#'
#' @return Tabla con los datos preprocesados listos para utilizarse 
#' en la plataforma.
#' 
#'
#' 
preprocesa_axa_nuevos_datos <- function(axa) {
  axa <- janitor::clean_names(axa, "snake")
  axa <- axa[rowSums(is.na(axa)) != ncol(axa),]
  axa['hora'] <- lubridate::hms(paste0(axa$hora, ':01:00'))
  axa$mes[axa$mes == 'ENERO'] <- 1
  axa$mes[axa$mes == 'FEBRERO'] <- 2
  axa$mes[axa$mes == 'MARZO'] <- 3
  axa$mes[axa$mes == 'ABRIL'] <- 4
  axa$mes[axa$mes == 'MAYO'] <- 5
  axa$mes[axa$mes == 'JUNIO'] <- 6
  axa$mes[axa$mes == 'JULIO'] <- 7
  axa$mes[axa$mes == 'AGOSTO'] <- 8
  axa$mes[axa$mes == 'SEPTIEMBRE'] <- 9
  axa$mes[axa$mes == 'OCTUBRE'] <- 10
  axa$mes[axa$mes == 'NOVIEMBRE'] <- 11
  axa$mes[axa$mes == 'DICIEMBRE'] <- 12
  axa['fecha'] <- lubridate::dmy(
                                  paste0(
                                        axa$dia_numero,
                                        "/",
                                        axa$mes,
                                        "/",
                                        axa$ano)
                              )
  axa$timestamp <- with(
                          axa,
                          axa$fecha + axa$hora
                        )
  axa$longitud <- as.numeric(axa$longitud)
  axa$latitud <- as.numeric(axa$latitud)
  axa <- dplyr::filter(axa, !is.na(latitud) & !is.na(longitud))
  axa <- dplyr::filter(axa, !is.na(timestamp))
  axa <- sf::st_transform(
                          sf::st_as_sf(axa,
                                          coords = c('longitud','latitud'),
                                          crs = 4326), 32614
                          )
  return(axa)
}


#' Preprocesa archivo csv de AXA
#'
#' @param c5 Tabla con los datos del C5 leídos de un csv
#'
#' @return Tabla con los datos preprocesados listos para utilizarse 
#' en la plataforma.
#'
#'
#'
preprocesa_C5 <- function(c5) {

  #Se eliminan falsas alarmas y delitos 
  c5 <- c5 %>% dplyr::filter(clas_con_f_alarma != "FALSA ALARMA" & clas_con_f_alarma != "DELITO")%>% 
               dplyr::filter(codigo_cierre != "A" & codigo_cierre != "I")
  incidente_c4_lesionados <- c("accidente-choque con lesionados",
                               # "accidente-choque con prensados", # esta qué onda, preguntarle a Vanessa
                               "detención ciudadana-atropellado",
                               "lesionado-accidente automovilístico", # Esta categoría no viene
                               "lesionado-atropellado"
                              )
  ###Accidente
  incidente_c4_accidente <- c("accidente-choque sin lesionados",
                              "detención ciudadana-accidente automovilístico",
                              "accidente-ciclista",
                              "accidente-ferroviario",
                              "accidente-monopatín", # No viene
                              "accidente-motociclista",
                              "accidente-otros",
                              "accidente-choque con prensados", # A poco estos no están lesionados
                              "accidente-persona atrapada / desbarrancada", # A poco estos no están lesionados?
                              "accidente-vehiculo atrapado", # A poco estos no están lesionados?
                              "accidente-vehículo atrapado-varado", # A poco estos no están lesionados?
                              "accidente-vehiculo desbarrancado", # A poco estos no están lesionados?
                              "accidente-volcadura"
                              )

  ### Decesos
  incidente_c4_decesos <- c("cadáver-accidente automovilístico",
                            "cadáver-atropellado"
                            )
  ####Se les da la etiqueta correspondiente
  c5 <- dplyr::mutate(
    c5,
    tipo_incidente =
      ifelse(c5$incidente_c4 %in% incidente_c4_decesos, "DECESO",
             ifelse(c5$incidente_c4 %in% incidente_c4_lesionados,
                    "LESIONADO",
                    ifelse(c5$incidente_c4 %in% incidente_c4_accidente,
                           "ACCIDENTE",
                           NA
                    ))
      )
  )
  c5$fecha_creacion <- lubridate::dmy(c5$fecha_creacion)
  c5$hora_creacion <- lubridate::hms(c5$hora_creacion)
  c5$timestamp <- with(
    c5,
    c5$fecha_creacion + c5$hora_creacion
  )
  c5 <- dplyr::filter(c5, !is.na(latitud) & !is.na(longitud))
  c5 <- dplyr::filter(c5, !is.na(timestamp))
  #obtenemos los puntos
  c5 <- sf::st_transform(
    sf::st_as_sf(c5,
                 coords = c('longitud','latitud'),
                 crs = 4326), 32614
  )
  return(c5)
}

#' Preprocesa archivo csv del C5
#'
#' Lee el rds original y permite incorporar los nuevos datos usando la fecha
#'
#' @param c5_new tabla con los datos de fiscalía leídos de csv
#'
#' @return Tabla con los datos preprocesados listos para utilizarse
#' en la plataforma.
#' 
#'
preprocesa_C5_origin <- function(c5_new) {
  df_old <- readRDS("./data-raw/c5.rds")
  max_date_c5 <- max(df_old$fecha_creacion_2)
  c5_red_pre <- preprocesa_C5(c5_new)
  c5_red_pre <- c5_red_pre[c5_red_pre$fecha_creacion_2 > max_date_c5, ]
  print("Se une el archivo al ya subido para hacer un nuevo rds")
  c5_all <- rbind(df_old, c5_red_pre)
  return(c5_all)
}





#' Joins the tables
#'
#'  Modifies the tables to joint in to a single table
#'
#'@returns The table concatenation
#'
une_tablas <- function() {
  axa <- readRDS("./data-raw/axa.rds")
  fgj <- readRDS("./data-raw/fgj.rds")
  ssc <- readRDS("./data-raw/ssc.rds")
  c5 <- readRDS("./data-raw/c5.rds")
  fgj_cols <- c("Delito","CalidadJuridica", "geometry", "timestamp")
  ssc_cols <- c("total_occisos", "geometry", "timestamp", "total_lesionados")
  axa_cols <- c("fallecido", "geometry", "timestamp", "lesionados")
  c5_cols <- c("geometry", "timestamp", "tipo_incidente")
  axa <- dplyr::select(axa, tidyselect::all_of(axa_cols))
  fgj <- dplyr::select(fgj, tidyselect::all_of(fgj_cols))
  ssc <- dplyr::select(ssc, tidyselect::all_of(ssc_cols))
  c5 <- dplyr::select(c5, tidyselect::all_of(c5_cols))

  delitos_deceso <- c(
    "DAÑO EN PROPIEDAD AJENA CULPOSA POR TRÁNSITO VEHICULAR A AUTOMOVIL",
    "DAÑO EN PROPIEDAD AJENA CULPOSA POR TRÁNSITO VEHICULAR A BIENES INMUEBLES",
    "DAÑO EN PROPIEDAD AJENA CULPOSA POR TRÁNSITO VEHICULAR A VIAS DE COMUNICACION",
    "HOMICIDIO CULPOSO POR TRÁNSITO VEHICULAR",
    "HOMICIDIO CULPOSO POR TRÁNSITO VEHICULAR (ATROPELLADO)",
    "HOMICIDIO CULPOSO POR TRÁNSITO VEHICULAR (CAIDA)",
    "HOMICIDIO CULPOSO POR TRÁNSITO VEHICULAR (COLISION)",
    "LESIONES CULPOSAS POR TRANSITO VEHICULAR",
    "LESIONES CULPOSAS POR TRANSITO VEHICULAR EN COLISION"
  )
  delitos_lesionados <- c(
    "LESIONES CULPOSAS POR TRANSITO VEHICULAR",
    "LESIONES CULPOSAS POR TRANSITO VEHICULAR EN COLISION"
  )
  delitos_accidente <- c(
    "DAÑO EN PROPIEDAD AJENA CULPOSA POR TRÁNSITO VEHICULAR A AUTOMOVIL",
    "DAÑO EN PROPIEDAD AJENA CULPOSA POR TRÁNSITO VEHICULAR A BIENES INMUEBLES",
    "DAÑO EN PROPIEDAD AJENA CULPOSA POR TRÁNSITO VEHICULAR A VIAS DE COMUNICACION"
  )
  condicion_deceso = fgj$Delito %in% delitos_deceso & fgj$CalidadJuridica == "CADAVER"
  condicion_lesionados = fgj$Delito %in% delitos_lesionados & fgj$CalidadJuridica != "CADAVER"
  condicion_accidente = fgj$Delito %in% delitos_accidente & fgj$CalidadJuridica != "CADAVER"
  fgj <- dplyr::mutate(
      fgj,
      tipo_incidente =
        ifelse(condicion_deceso,
               "DECESO",
               ifelse(condicion_lesionados,
                      "LESIONADO",
                      ifelse(condicion_accidente,
                      "ACCIDENTE",
                      NA
                      )
              )
        )
    )
  
  fgj<-fgj[!is.na(fgj$tipo_incidente), ]
  fgj$fuente <- "FGJ"
  
  
  ssc <- dplyr::mutate(
    ssc,
    tipo_incidente =
      ifelse(ssc$total_occisos > 0, "DECESO",
      ifelse(ssc$total_occisos == 0 & ssc$total_lesionados > 0,
        "LESIONADO",
        ifelse(ssc$total_occisos == 0 & ssc$total_lesionados == 0,
        "ACCIDENTE",
        NA
        ))
      )
  )
  ssc$fuente <- "SSC"
  axa <- dplyr::mutate(
    axa,
    tipo_incidente =
      ifelse(axa$fallecido == "SI", "DECESO",
      ifelse(axa$fallecido != "SI" & axa$lesionados > 0,
        "LESIONADO",
        ifelse(axa$fallecido != "SI" & axa$lesionados == 0,
        "ACCIDENTE",
        NA
        ))
      )
  )
  c5$fuente <- "C5"
  axa$fuente <- "AXA"
  cols <- c("geometry", "timestamp", "tipo_incidente", "fuente")
  axa <- dplyr::select(axa, tidyselect::all_of(cols))
  fgj <- dplyr::select(fgj, tidyselect::all_of(cols))
  ssc <- dplyr::select(ssc, tidyselect::all_of(cols))
  total <- rbind(axa, fgj)
  total <- rbind(total, ssc)
  sf::st_crs(c5) <- sf::st_crs(total)
  total <- rbind(total, c5)
  cdmx <- sf::read_sf(dsn = "./data-raw/cdmx.shp")
  cdmx$geometry <- sf::st_transform(
     cdmx$geometry,
     32614
  )
  total <- sf::st_join(total, cdmx["nom_mun"], left = FALSE)
  total <- total[!is.na(total$tipo_incidente), ]
  total <- sf::st_transform(total, "+init=epsg:4326") %>%
    dplyr::mutate(
      latitud = sf::st_coordinates(geometry)[, 2],
      longitud = sf::st_coordinates(geometry)[, 1]
    )
  return(total)
}