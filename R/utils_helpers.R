#' Preprocesa archivo csv de Fiscalía
#'
#' @param fgj tabla con los datos de fiscalía leídos de csv
#'
#' @return Tabla con los datos preprocesados listos para utilizarse 
#' en la plataforma.
#' 
#'
preprocesa_pgj <- function(pgj) {
  pgj['timestamp'] <- lubridate::parse_date_time(
                       pgj$fecha_hechos,
                       "Y-m-d H:M:S"
                      )
  pgj <-
     dplyr::filter(pgj,
       timestamp >= lubridate::parse_date_time("2016-01-01", "Y-m-d")
      )
  pgj["geopoint"] <- NULL
  pgj <- pgj[order(pgj$timestamp),]
  pgj["id"] <- seq.int(nrow(pgj))
  pgj <- dplyr::filter(pgj,!is.na(latitud) & !is.na(longitud))
  pgj <- dplyr::filter(pgj,!is.na(timestamp))
  pgj <- sf::st_transform(sf::st_as_sf(
    pgj,
    coords = c("longitud", "latitud"),
    crs = 4326
  ), 32614)
  return(pgj)
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
  ssc <- janitor::clean_names(ssc, "snake")
  # =
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
  # =
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

#' Preprocesa los datos de AXA
#' 
#'Preprocess the data from the tables in the AXA site  
#' 
#' 
preprocesa_axa_origin<- function(axa_new){
  
  ### axa is the new and should have the corresponding column names
  
  #### Read old axa
  df_old <- readr::read_delim("./data-raw/AXA.csv",
                          col_names = TRUE,
                          quote = "\"",
                          delim = ";"
  )
  
  
  ##### Va a tener que ser harcodeado 
  name_look<-c( "LATITUD","LONGITUD","CAUSA SINIESTRO", "TIPO VEHICULO",
     "NIVEL DAÑO VEHICULO" , "PUNTO DE IMPACTO", "AÑO","MES" ,"DÍA NUMERO",
     "HORA","LESIONADOS","RELACION LESIONADOS", "NIVEL LESIONADO",  
     "HOSPITALIZADO","FALLECIDO")
  axa_new<- axa_new[, name_look]
  
  axa_rds_loc <- preprocesa_axa(df_old)
  max_year_axa<- max(axa_rds_loc$ao)
  axa_rds_loc_y<- axa_rds_loc[axa_rds_loc$ao==max_year_axa,]
  max_month_axa <- max(axa_rds_loc_y$mes)
  axa_rds_loc_y_m <- axa_rds_loc_y[axa_rds_loc_y$mes== max_month_axa,]
  max_day_axa <- max(axa_rds_loc_y_m$dia_numero)
  axa_red_pre <-preprocesa_axa(axa_red)
  axa_red_pre$mes<- as.integer(axa_red_pre$mes)
  axa_red_pre <- axa_red_pre[axa_red_pre$ao >= max_year_axa,]
  axa_red_pre <- axa_red_pre[axa_red_pre$mes >= max_month_axa,]
  
  axa_red_pre <-axa_red_pre[axa_red_pre$mes== max_month_axa &
    axa_red_pre$dia_numero >= max_day_axa |
    axa_red_pre$mes >max_month_axa, ]
  
  axa_red_pre$timestamp <-as.chron(axa_red_pre$timestamp)
  axa_all <-rbind(axa_rds_loc, axa_red_pre)
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
  fgj_cols <- c("delito", "geometry", "timestamp")
  ssc_cols <- c("total_occisos", "geometry", "timestamp", "total_lesionados")
  axa_cols <- c("fallecido", "geometry", "timestamp", "lesionados")
  axa <- dplyr::select(axa, tidyselect::all_of(axa_cols))
  fgj <- dplyr::select(fgj, tidyselect::all_of(fgj_cols))
  ssc <- dplyr::select(ssc, tidyselect::all_of(ssc_cols))
  fgj <- dplyr::mutate(
    fgj,
    tipo_incidente =
      ifelse(startsWith(
        fgj$delito,
        "HOMICIDIO CULPOSO POR TRÁNSITO VEHICULAR"
      ), "DECESO",
      ifelse(startsWith(
        fgj$delito,
        "LESIONES CULPOSAS POR TRANSITO VEHICULAR"),
        "LESIONADO",
        ifelse(startsWith(
        fgj$delito,
        "DAÑO EN PROPIEDAD AJENA CULPOSA POR TRÁNSITO VEHICULAR"),
        "ACCIDENTE",
        NA
        ))
      )
  )
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
  axa$fuente <- "AXA"
  cols <- c("geometry", "timestamp", "tipo_incidente", "fuente")
  axa <- dplyr::select(axa, tidyselect::all_of(cols))
  fgj <- dplyr::select(fgj, tidyselect::all_of(cols))
  ssc <- dplyr::select(ssc, tidyselect::all_of(cols))
  total <- rbind(axa, fgj)
  total <- rbind(total, scc)
  return(total)
}


