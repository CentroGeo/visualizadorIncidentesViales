#' Preprocesa archivo csv de Fiscalía
#'
#' @param fgj tabla con los datos de fiscalía leídos de csv
#'
#' @return Tabla con los datos preprocesados listos para utilizarse 
#' en la plataforma.
#' 
#'jJ 
preprocesa_pgj <- function(pgj) {
  #### Se eliminan los duplicados
  # TODO: Esto ya no va (no hay esas columnas)
  pgj <- dplyr::distinct(pgj,idCarpeta , .keep_all= TRUE)
  ## Se eliminan los que no tienen fecha
  # TODO: ya no se llama así la columna (fecha_hechos) y es timestamp
  pgj <- pgj[!is.na(pgj$FechaHecho),]
  ### Se eliminan los que no tienen hora 
  pgj <- pgj[!is.na(pgj$HoraHecho),]
  # TODO por lo anterior, todo esto es un poco diferente
  pgj['fecha_hechos'] <- lubridate::dmy( pgj$FechaHecho )
  pgj['hora_hechos'] <- lubridate::hms(pgj$HoraHecho)                        
  pgj['timestamp'] <- pgj$fecha_hechos + pgj$hora_hechos
  ### Hasta acá
  pgj <-
     dplyr::filter( pgj,
       timestamp >= lubridate::parse_date_time("2018-01-01", "Y-m-d")
      )
  pgj["geopoint"] <- NULL
  pgj <- pgj[order(pgj$timestamp), ]
  pgj["id"] <- seq.int(nrow(pgj))
  # TODO: EStos campos ya no tienen nulos, ahora están codificados con NA
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
  # TODO: al parecer ya no necesitamos esto
  ssc <- janitor::clean_names(ssc, "snake")
  # TODO: ya no se llama hora_evento, se llama hora
  # TODO: checar cómo viene codificado ahora
  ssc$hora_evento <- lubridate::hms(chron::times(paste0(
    ifelse(nchar(ssc$hora2) == 1, paste0("0", ssc$hora2), ssc$hora2),
    ":",
    ifelse(
      stringr::str_sub(ssc$hora_evento,-1) == ".",
      substr(ssc$hora_evento, 4, 5),
      stringr::str_sub(ssc$hora_evento,-2)
    ),
    ":00"
  )))

  ssc$timestamp <- with(ssc, lubridate::ymd(ssc$fecha_evento) + ssc$hora_evento)
  # TODO: No sabemos si esto sigue siendo así LOL
  ssc$no_folio[ssc$no_folio == "SD"] <-
    paste0("SinID_", seq(1:nrow(dplyr::filter(ssc, no_folio == "SD"))))
  tmp <- dplyr::filter(
                       as.data.frame(
                         table(ssc$no_folio),
                         stringsAsFactors = FALSE),
                         Freq > 1
                      )
  for (i in tmp$Var1) {
    ssc$no_folio[ssc$no_folio == i] <-
      paste0(i, "_", seq(1:tmp[tmp$Var1 == i,]$Freq))
  }
  rm(tmp, i)
  ssc <- dplyr::filter(ssc,!is.na(coordenada_y) & !is.na(coordenada_x))
  ssc <- dplyr::filter(ssc,!is.na(timestamp))
  # =
  ssc <- sf::st_transform(sf::st_as_sf(
    ssc,
    coords = c("coordenada_x", "coordenada_y"),
    crs = 4326
  ), 32614)
  return(ssc)
}

######Nio hay para SSC por que sus datos estan iguales


#' Preprocesa los datos de AXA
#'
#'Preprocess the data from the tables in the AXA site
#'
#'
preprocesa_axa_origin<- function(axa_new) {

  ### axa is the new and should have the corresponding column names
  #### Read old axa
  df_old <- readr::read_delim("./data-raw/AXA.csv",
                          col_names = TRUE,
                          quote = "\"",
                          delim = ";"
  )


  ##### Va a tener que ser harcodeado
  name_look <- c("LATITUD", "LONGITUD", "CAUSA SINIESTRO", "TIPO VEHICULO",
     "NIVEL DAÑO VEHICULO", "PUNTO DE IMPACTO", "AÑO", "MES", "DÍA NUMERO",
     "HORA", "LESIONADOS", "RELACION LESIONADOS", "NIVEL LESIONADO",
     "HOSPITALIZADO", "FALLECIDO")
  axa_new <- axa_new[, name_look]
  ##### remove before pass 
  axa_new <- axa_new[!(axa_new$LATITUD == '\\N' | axa_new$LATITUD == '0'), ]
  axa_new <- axa_new[!(axa_new$LONGITUD == '\\N' | axa_new$LONGITUD == '0'), ]
  names(axa_new) <- names(df_old)
  axa_new$latitud <- as.double(axa_new$latitud)
  axa_new$longitud <- as.double(axa_new$longitud)

  axa_rds_loc <- preprocesa_axa(df_old)
  max_year_axa <- max(axa_rds_loc$ao)
  axa_rds_loc_y <- axa_rds_loc[axa_rds_loc$ao == max_year_axa, ]
  max_month_axa <- max(axa_rds_loc_y$mes)
  axa_rds_loc_y_m <- axa_rds_loc_y[axa_rds_loc_y$mes == max_month_axa, ]
  max_day_axa <- max(axa_rds_loc_y_m$dia_numero)
  axa_red_pre <- preprocesa_axa(axa_new)
  #axa_red_pre$mes<- as.integer(axa_red_pre$mes)
  axa_red_pre <- axa_red_pre[axa_red_pre$ao >= max_year_axa, ]
  axa_red_pre <- axa_red_pre[axa_red_pre$mes >= max_month_axa, ]

  axa_red_pre <- axa_red_pre[axa_red_pre$mes == max_month_axa &
    axa_red_pre$dia_numero >= max_day_axa |
    axa_red_pre$mes > max_month_axa, ]

  #axa_red_pre$timestamp <-as.chron(axa_red_pre$timestamp)
  axa_all <- rbind(axa_rds_loc, axa_red_pre)
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
preprocesa_axa <- function(axa) {
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
  axa['fecha'] <- lubridate::date(chron::dates(
                                paste0(
                                       axa$dia_numero,
                                       "-",
                                       axa$mes,
                                       "-",
                                       axa$ao),
                                       format = "d-m-y"
                              ))
  axa$timestamp <- with(
                          axa,
                          axa$fecha + axa$hora
                        )
  axa['causa_siniestro'] <- as.character(axa$causa_siniestro)
  axa$causa_siniestro[axa$causa_siniestro == '\\N'] <-
    paste0(
      'SinID_',
      seq(1:nrow(dplyr::filter(axa , causa_siniestro == '\\N')
      )))
  axa <- dplyr::filter(axa, !is.na(latitud) & !is.na(longitud))
  axa <- dplyr::filter(axa, !is.na(timestamp))
  # =
  axa <- sf::st_transform(
                          sf::st_as_sf(axa,
                                          coords = c('longitud','latitud'),
                                          crs = 4326), 32614
                          )
  return(axa)
}


#' Preprocesa archivo csv de AXA
#'
#' @param df_abierto Tabla con los datos del C5 leídos de un csv
#'
#' @return Tabla con los datos preprocesados listos para utilizarse 
#' en la plataforma.
#'
#'
#'
preprocesa_C5<- function(df_abierto) {

  #Se eliminan falsas alarmas y delitos 
  df_abierto <- df_abierto[df_abierto$clas_con_f_alarma != "Falsa Alarma" |
                            df_abierto$clas_con_f_alarma != "Delito",
                          ]
  # Se eliminan los incidentes falsos
  # TODO: Cambió esta columna, hay que actualizar (ahora es más simple, sólo trae el código)
  # TODO: Cambiar por un dplyr::filter
  Confirmacion1 <- df_abierto$codigo_cierre == "(A) La unidad de atención a emergencias fue despachada, llegó al lugar de los hechos y confirmó la emergencia reportada"
  Confirmacion2 <- df_abierto$codigo_cierre == "(I) El incidente reportado es afirmativo y se añade información adicional al evento"
  df_abierto <- df_abierto[Confirmacion1 | Confirmacion2, ]
  ##Lesionados
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
  df_abierto <- dplyr::mutate(
    df_abierto,
    tipo_incidente =
      ifelse(df_abierto$incidente_c4 %in% incidente_c4_decesos, "DECESO",
             ifelse(df_abierto$incidente_c4 %in% incidente_c4_lesionados,
                    "LESIONADO",
                    ifelse(df_abierto$incidente_c4 %in% incidente_c4_accidente,
                           "ACCIDENTE",
                           NA
                    ))
      )
  )
  
  
  ### obtenemos el timestamp como estan en dos formatos distintos
  ## vamos a tener que hacer moidificaciones
  # TODO: REVISAR SI SIGUE FUNCIONANDO ASÍ O SE PUEDE SIMPLIFICAR
  df_abierto$fecha_creacion_2 <- ifelse(nchar(df_abierto$fecha_creacion) > 8,
                     lubridate::as_date(df_abierto$fecha_creacion,
                                         format = "%d/%m/%Y"),
                     lubridate::as_date(df_abierto$fecha_creacion,
                                        format = "%d/%m/%y")
                     )
  # df_abierto$fecha_creacion_2 <- lubridate::as_date( df_abierto$fecha_creacion,
  #                                                  format= "%d/%m/%Y")
  df_abierto$fecha_creacion_2 <- lubridate::as_date(df_abierto$fecha_creacion_2)
  df_abierto$hora_creacion_2 <- lubridate::hms(df_abierto$hora_creacion)
  df_abierto$timestamp <- with(
    df_abierto,
    df_abierto$fecha_creacion_2 + df_abierto$hora_creacion_2
  )
  df_abierto <- dplyr::filter(df_abierto, !is.na(latitud) & !is.na(longitud))
  df_abierto <- dplyr::filter(df_abierto, !is.na(timestamp))
  #obtenemos los puntos
  df_abierto <- sf::st_transform(
    sf::st_as_sf(df_abierto,
                 coords = c('longitud','latitud'),
                 crs = 4326), 32614
  )
  return(df_abierto)
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
  # fgj <- dplyr::mutate(
  #   fgj,
  #   tipo_incidente =
  #     ifelse(startsWith(
  #       fgj$delito,
  #       "HOMICIDIO CULPOSO POR TRÁNSITO VEHICULAR"
  #     ), "DECESO",
  #     ifelse(startsWith(
  #       fgj$delito,
  #       "LESIONES CULPOSAS POR TRANSITO VEHICULAR"),
  #       "LESIONADO",
  #       ifelse(startsWith(
  #       fgj$delito,
  #       "DAÑO EN PROPIEDAD AJENA CULPOSA POR TRÁNSITO VEHICULAR"),
  #       "ACCIDENTE",
  #       NA
  #       ))
  #     )
  # )
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
  sf::st_crs(cdmx) <- sf::st_crs(total)
  total <- sf::st_join(total, cdmx["nom_mun"], left = FALSE)
  total <- total[!is.na(total$tipo_incidente), ]
  total <- sf::st_transform(total, "+init=epsg:4326") %>%
    dplyr::mutate(
      latitud = sf::st_coordinates(geometry)[, 2],
      longitud = sf::st_coordinates(geometry)[, 1]
    )
  return(total)
}