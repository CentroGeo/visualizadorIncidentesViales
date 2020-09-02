#' Regresa los conteos finales para las gráficas por Dia/Hora.
#'
#' @param datos Un tibble con los datos.
#' @param user_input el objeto con los parámetros del usuario.
#' @param tipo "PGJ"; "SSC"; "C5"; "AXA" Cuál base de datos.
#' @return tibble con columnas con los eventos agregados por dia.
#' @examples
#' count_final <- get_final_counts(bd$tmp_pgj, input, "PGJ")

get_final_counts <- function(datos, user_input, tipo) {
  count_final <-
    data.frame(
      n = as.integer() ,
      ref = as.integer() ,
      etiqueta = as.character() ,
      categoria = as.character()
    )
  datos$geometry <- NULL
  if (tipo == "PGJ") {
    subgrafica <- user_input$subgrafica_pgj2
  } else if (tipo == "SSC") {
    subgrafica <- user_input$subgrafica_ssc2
  } else if (tipo == "C5") {
    subgrafica <- user_input$subgrafica_c52
  } else if (tipo == "AXA") {
    subgrafica <- user_input$subgrafica_axa2
  }
  if (!is.null(datos)) {
    if (nrow(datos) != 0) {
      if (tipo == 'PGJ' || tipo == 'SSC') {
        if (subgrafica == 'Sin Categoría')
          max <- ceiling(max(count(datos , wday(timestamp))$n) / 10) * 10
        else if (subgrafica == 'Delito')
          max <-
            ceiling(max(count(datos , wday(timestamp) , delito)$n) / 10) * 10
      } else if (tipo == 'C5') {
        if (subgrafica == 'Sin Categoría')
          max <- ceiling(max(count(datos , wday(timestamp))$n) / 10) * 10
        else if (subgrafica == 'Incidente C4')
          max <-
            ceiling(max(count(
              datos , wday(timestamp) , incidente_c4
            )$n) / 10) * 10
        else if (subgrafica == 'Clase del Incidente')
          max <-
            ceiling(max(count(
              datos , wday(timestamp) , clas_con_f_alarma
            )$n) / 10) * 10
        else if (subgrafica == 'Tipo de Entrada')
          max <-
            ceiling(max(count(
              datos , wday(timestamp) , tipo_entrada
            )$n) / 10) * 10
      } else if (tipo == 'AXA') {
        if (subgrafica == 'Sin Categoría')
          max <- ceiling(max(count(datos , wday(timestamp))$n) / 10) * 10
        else if (subgrafica == 'Causa del Siniestro')
          max <-
            ceiling(max(count(
              datos , wday(timestamp) , causa_siniestro
            )$n) / 10) * 10
        else if (subgrafica == 'Tipo de Vehículo')
          max <-
            ceiling(max(count(
              datos , wday(timestamp) , tipo_vehiculo
            )$n) / 10) * 10
        else if (subgrafica == 'Rol del Lesionado')
          max <-
            ceiling(max(count(
              datos , wday(timestamp) , relacion_lesionados
            )$n) / 10) * 10
      }
    }
  }
  # =
  if (!is.null(datos)) {
    if (user_input$tiempo_grafica2 == 'Mañana (6AM - 12PM)')
      datos <-
        filter(datos , hour(timestamp) %in% c(6, 7, 8, 9, 10, 11, 12))
    else if (user_input$tiempo_grafica2 == 'Tarde (1PM - 9PM)')
      datos <-
        filter(datos , hour(timestamp) %in% c(13, 14, 15, 16, 17, 18, 19, 20, 21))
    else if (user_input$tiempo_grafica2 == 'Noche (10PM - 5AM)')
      datos <-
        filter(datos , hour(timestamp) %in% c(22, 23, 0, 1, 2, 3, 4, 5))
  }
  # =
  if (nrow(datos) == 0) {
    cuenta <- data.frame(ref = 1 ,
                         categoria = 'Sin Datos' ,
                         n = 0)
    for (i in seq(7)) {
      if (nrow(cuenta[cuenta$ref == i, ]) == 0)
        cuenta[nrow(cuenta) + 1, ] <- c(i , 'Sin Datos' , 0)
    }
  } else {
    if (tipo == "PGJ") {
      if (subgrafica == 'Sin Categoría') {
        cuenta <-
          count(datos , wday(timestamp)) %>% rename('ref' = 'wday(timestamp)')
        for (i in seq(7)) {
          if (nrow(cuenta[cuenta$ref == i, ]) == 0)
            cuenta[nrow(cuenta) + 1, ] <- c(i , 0)
        }
        cuenta$categoria <- 'PGJ'
      } else if (subgrafica == 'Delito') {
        cuenta <-
          count(datos , wday(timestamp) , delito) %>% rename('ref' = 'wday(timestamp)' , 'categoria' =
                                                               'delito')
        for (i in seq(7)) {
          if (nrow(cuenta[cuenta$ref == i, ]) == 0) {
            cuenta <- cuenta %>% add_row(ref = i, n = 0)
          }
        }
        cuenta$categoria <-
          str_to_title(cuenta$categoria , locale = 'es')
      }
    } else if (tipo == "SSC") {
      if (subgrafica == 'Sin Categoría') {
        cuenta <-
          count(datos , wday(timestamp)) %>% rename('ref' = 'wday(timestamp)')
        for (i in seq(7)) {
          if (nrow(cuenta[cuenta$ref == i, ]) == 0) {
            cuenta <- cuenta %>% add_row(ref = i, n = 0)
          }
        }
        cuenta$categoria <- 'SSC'
      } else if (subgrafica == 'Tipo de Evento') {
        cuenta <-
          count(datos , wday(timestamp) , tipo_de_evento) %>% rename('ref' = 'wday(timestamp)' , 'categoria' =
                                                                       'tipo_de_evento')
        for (i in seq(7)) {
          for (cat in unique(cuenta$categoria)) {
            if (nrow(cuenta[cuenta$ref == i &
                            cuenta$categoria == cat, ]) == 0)
              cuenta[nrow(cuenta) + 1, ] <- c(i , cat , 0)
          }
        }
        cuenta$categoria <-
          str_to_title(cuenta$categoria , locale = 'es')
      } else if (subgrafica == 'Identidad') {
        cuenta <-
          count(datos , wday(timestamp)) %>% rename('ref' = 'wday(timestamp)')
        weekdays <- unique(cuenta$ref)
        cuenta <-
          data.frame(
            ref = as.integer() ,
            categoria = as.character() ,
            n = as.integer() ,
            stringsAsFactors = FALSE
          )
        for (wd in weekdays) {
          tmp2 <- filter(datos , wday(timestamp) == wd)
          if (nrow(tmp2) != 0) {
            tmp2 <-
              as.data.frame(table(unlist(
                strsplit(tmp2$identidad , ' ')
              )) , stringsAsFactors = FALSE) %>% rename('categoria' = 'Var1' , 'n' = 'Freq')
            tmp2$ref <- wd
            tmp2 <- tmp2 %>% select(ref , categoria , n)
            cuenta <- rbind(cuenta , tmp2)
          }
        }
        # =====
        for (i in seq(7)) {
          for (cat in unique(cuenta$categoria)) {
            if (nrow(cuenta[cuenta$ref == i &
                            cuenta$categoria == cat, ]) == 0)
              cuenta[nrow(cuenta) + 1, ] <- c(i , cat , 0)
          }
        }
        cuenta$categoria <-
          str_to_title(cuenta$categoria , locale = 'es')
      }
    } else if (tipo == "C5") {
      if (subgrafica == 'Sin Categoría') {
        cuenta <-
          count(datos , wday(timestamp)) %>% rename('ref' = 'wday(timestamp)')
        for (i in seq(7)) {
          if (nrow(cuenta[cuenta$ref == i, ]) == 0) {
            cuenta <- cuenta %>% add_row(ref = i, n = 0)
          }
        }
        cuenta$categoria <- 'C5'
      }
      else if (subgrafica == 'Incidente C4') {
        cuenta <-
          count(datos , wday(timestamp) , incidente_c4) %>% rename('ref' = 'wday(timestamp)' , 'categoria' =
                                                                     'incidente_c4')
        for (i in seq(7)) {
          for (cat in unique(cuenta$categoria)) {
            if (nrow(cuenta[cuenta$ref == i &
                            cuenta$categoria == cat, ]) == 0)
              cuenta[nrow(cuenta) + 1, ] <- c(i , cat , 0)
          }
        }
        cuenta$categoria <-
          str_to_title(cuenta$categoria , locale = 'es')
      }
      else if (subgrafica == 'Clase del Incidente') {
        cuenta <-
          count(datos , wday(timestamp) , clas_con_f_alarma) %>% rename('ref' = 'wday(timestamp)' , 'categoria' =
                                                                          'clas_con_f_alarma')
        for (i in seq(7)) {
          for (cat in unique(cuenta$categoria)) {
            if (nrow(cuenta[cuenta$ref == i &
                            cuenta$categoria == cat, ]) == 0)
              cuenta[nrow(cuenta) + 1, ] <- c(i , cat , 0)
          }
        }
        cuenta$categoria <-
          str_to_title(cuenta$categoria , locale = 'es')
      }
      else if (subgrafica == 'Tipo de Entrada') {
        cuenta <-
          count(datos , wday(timestamp) , tipo_entrada) %>% rename('ref' = 'wday(timestamp)' , 'categoria' =
                                                                     'tipo_entrada')
        for (i in seq(7)) {
          for (cat in unique(cuenta$categoria)) {
            if (nrow(cuenta[cuenta$ref == i &
                            cuenta$categoria == cat, ]) == 0)
              cuenta[nrow(cuenta) + 1, ] <- c(i , cat , 0)
          }
        }
        cuenta$categoria <-
          str_to_title(cuenta$categoria , locale = 'es')
      }
    } else if (tipo == "AXA") {
      if (subgrafica == 'Sin Categoría') {
        cuenta <-
          count(datos , wday(timestamp)) %>% rename('ref' = 'wday(timestamp)')
        for (i in seq(7)) {
          if (nrow(cuenta[cuenta$ref == i, ]) == 0) {
            cuenta <- cuenta %>% add_row(ref = i, n = 0)
          }
        }
        cuenta$categoria <- 'AXA'
      }
      else if (subgrafica == 'Causa del Siniestro') {
        cuenta <-
          count(datos , wday(timestamp) , causa_siniestro) %>% rename('ref' = 'wday(timestamp)' , 'categoria' =
                                                                        'causa_siniestro')
        for (i in seq(7)) {
          for (cat in unique(cuenta$categoria)) {
            if (nrow(cuenta[cuenta$ref == i &
                            cuenta$categoria == cat, ]) == 0)
              cuenta[nrow(cuenta) + 1, ] <- c(i , cat , 0)
          }
        }
        cuenta$categoria <-
          str_to_title(cuenta$categoria , locale = 'es')
      }
      else if (subgrafica == 'Tipo de Vehículo') {
        cuenta <-
          count(datos , wday(timestamp) , tipo_vehiculo) %>% rename('ref' = 'wday(timestamp)' , 'categoria' =
                                                                      'tipo_vehiculo')
        for (i in seq(7)) {
          for (cat in unique(cuenta$categoria)) {
            if (nrow(cuenta[cuenta$ref == i &
                            cuenta$categoria == cat, ]) == 0)
              cuenta[nrow(cuenta) + 1, ] <- c(i , cat , 0)
          }
        }
        cuenta$categoria <-
          str_to_title(cuenta$categoria , locale = 'es')
      }
      else if (subgrafica == 'Rol del Lesionado') {
        cuenta <-
          count(datos , wday(timestamp) , relacion_lesionados) %>% rename('ref' =
                                                                            'wday(timestamp)' , 'categoria' = 'relacion_lesionados')
        for (i in seq(7)) {
          for (cat in unique(cuenta$categoria)) {
            if (nrow(cuenta[cuenta$ref == i &
                            cuenta$categoria == cat, ]) == 0)
              cuenta[nrow(cuenta) + 1, ] <- c(i , cat , 0)
          }
        }
        cuenta$categoria <-
          str_to_title(cuenta$categoria , locale = 'es')
      }
    }
  }
  
  
  # =
  cuenta$etiqueta <- cuenta$ref
  cuenta$etiqueta[cuenta$etiqueta == 1] <- 'Domingo'
  cuenta$etiqueta[cuenta$etiqueta == 2] <- 'Lunes'
  cuenta$etiqueta[cuenta$etiqueta == 3] <- 'Martes'
  cuenta$etiqueta[cuenta$etiqueta == 4] <- 'Miércoles'
  cuenta$etiqueta[cuenta$etiqueta == 5] <- 'Jueves'
  cuenta$etiqueta[cuenta$etiqueta == 6] <- 'Viernes'
  cuenta$etiqueta[cuenta$etiqueta == 7] <- 'Sábado'
  # =
  cuenta$ref <- as.integer(cuenta$ref)
  cuenta$n <- as.integer(cuenta$n)
  cuenta <- cuenta[order(cuenta$ref), ]
  # =
  count_final <-
    rbind(count_final , cuenta %>% select(n , ref , etiqueta , categoria))
  
  return(count_final)
}