lista_textos<- list(
  bases_de_datos= "A continuación, encontrará información detallada sobre \
  las Bases de Datos utilizadas en esta aplicación, a modo de conocer más \
  a fondo su función original en el organismo generador y su utilidad para \
  los objetivos de la SEMOVI.",
  objetivo_base_datos_FGJ_1 = "A través del Ministerio Público, tiene las \
  atribuciones de investigar los delitos de orden común, y perseguir a \
  los imputados. Promoviendo la pronta, expedita y debida procuración de \
  Justicia.",
  objetivo_base_datos_FGJ_2 = "Esta fuente recaba una gran parte de \
  información que se complementa en el lugar de investigación como cada \
  uno de los campos pertenecientes a su base de datos.",
  objetivo_base_datos_FGJ_3 = "Esta fuente se considera fundamental debido a \
  que un accidente vial puede resultar en la comisión de delitos como \
  daños, lesiones o incluso homicidio (no intencional). Por lo cual le \
  corresponderá a la FGJ tomar la investigación y con ello la \
  recopilación de información.",
  objetivo_base_datos_FGJ_4 = "Para lo anterior, el Ministerio Público quien \
  coordina la investigación, recaba información de las entrevistas a \
  víctimas o imputados, las policías o bien de los peritos.",
  objetivo_base_datos_SSC_1 = "Sus atribuciones en la Ciudad de México, \
  encaminan las acciones dirigidas a salvaguardar la integridad y \
  patrimonio de las personas, prevenir la comisión de delitos e \
  infracciones a las disposiciones gubernativas y de policía, así como a \
  preservar las libertades, el orden y la paz públicos.",
  objetivo_base_datos_SSC_2 = "La información que tiene la SSC está en \
  función a la atención que se brinda a través de la policía, por lo cual \
  pueden allegarse de información que sólamente es posible recuperar \
  cuando el incidente vial es atendido en campo.",
  objetivo_base_datos_SSC_3 = "En la cadena de operaciones, son el primer \
  contacto físico con la ciudadanía que se encuentre involucrada en un \
  accidente vial, por lo cual tienen la facilidad de recabar información \
  casi al momento del evento.",
  objetivo_base_datos_SSC_4 = "A través de esta atención que brindan, los \
  policías, obtienen información del accidente, la cual se pasa a través \
  de formatos homologados a las áreas correspondientes de captura.",
  objetivo_base_datos_C5_1 = "Entre las atribuciones que tiene son las de \
  proveer información a la Jefa de Gobierno para la oportuna e inmediata \
  toma de decisiones, a través de video monitoreo de la ciudad, la \
  administración del Servicio de Atención de llamadas de emergencia 9-1-1 \
  CDMX, así como Denuncia Anónima 089 y LOCATEL.",
  objetivo_base_datos_C5_2 = "La información que se tiene corresponde a los \
  reportes hechos por la ciudadanía directamente, por lo cual la \
  información que puede ser pública es la fecha y hora, ubicación, la \
  clasificación interna que se realiza. Existe una alta probabilidad de \
  que esta institución tenga más reportes que las otras, debido a que \
  algunos de estos, no tienen continuidad ante la policía o la PGJ, claro \
  está, cuando no hay personas fallecidas o lesionadas.",
  objetivo_base_datos_C5_3 = "La integración de C5, ayuda a reducir la \
  brecha de reportes, ya que suele ser el primer contacto no físico con \
  alguna autoridad ante un accidente vial.",
  objetivo_base_datos_C5_4 = "Para ello, las y los operadores de C5 \
  toman la información directa de la ciudadanía y realizan una \
  clasificación de los eventos.",
  objetivo_base_datos_AXA_1 = "Es una aseguradora multirramo de origen \
  francés con presencia en 64 países",
  objetivo_base_datos_AXA_2 = "Esta fuente, contiene información \
  referente a sus clientes asegurados, sobre los datos generales, así \
  como un desglose sobre causas y entorno que intervino en el accidente",
  objetivo_base_datos_AXA_3 = "A través de “Fundación Axa” se suman \
  generando un convenio de colaboración para la integración de su \
  información, cuidando como siempre, la protección de datos personales \
  de sus clientes",
  objetivo_base_datos_AXA_4 = "El personal que atiende a sus \
  asegurados, se recopila la información la cual es capturada en un \
  sistema de registro"

) 

#' infoBdUI UI Function
#'
#' @description Function that generates the user interface (UI) where the 
#' information about data sources is display  
#'
#'
#'
#'
#' @importFrom shiny NS tagList
mod_infoBdUI_ui <- function (id) {
  ns <- NS(id)
  tagList(
    fluidRow(column(6, actionButton(inputId = ns("boton_ver_visualizador"), label = "Regresar a Visualizador", icon = icon("globe-americas"), style = "background-color: #00AA5A; color: white; border-color: ; font-size: 12pt;"))),
    tags$div(style = "height: 20px;"),
    shinydashboard::box(
      width = 12,
      tags$div(
        style = "text-align: justify; font-size: 12pt; color: #697070;",
        tags$p(strong("Bases de Datos"), style = "font-size: 18pt; color: #848888; text-align: left;"),
        tags$p(lista_textos$bases_de_datos)
      ),
      tabsetPanel(
        tabPanel(
          title = "PGJ",
          fluidRow(
            column(
              6,
              tags$div(style = "height: 15px;"),
              tags$div(
                style = "font-size: 18pt; color: #848888; text-align: left;",
                tags$p(
                  tags$img(src = "www/fgj.png", style = "height: 85px; float: right;"),
                  strong("Fiscalía General de Justicia (FGJ)")
                )
              ),
              tags$div(style = "height: 15px;"),
              tags$p(strong("Objetivo de la Base de Datos"), style = "font-size: 14pt; color: #848888; text-align: left;"),
              tags$div(
                style = "text-align: justify; font-size: 12pt; color: #697070;",
                tags$ul(
                  tags$li(lista_textos$objetivo_base_datos_FGJ_1),
                  tags$li(lista_textos$objetivo_base_datos_FGJ_2),
                  tags$li(lista_textos$objetivo_base_datos_FGJ_3),
                  tags$li(lista_textos$objetivo_base_datos_FGJ_4)
                ),
                tags$p(
                  style = "font-size: 10pt;",
                  strong("Referencia"), " – ", tags$a("Ley Orgánica de la Procuraduría General de Justicia del Distrito Federal", href = "http://data.consejeria.cdmx.gob.mx/images/leyes/leyes/LEY_ORGANICA_DE_LA_PROCURADURIA_GRAL_DE_JUSTICIA_DEL_DF_1.pdf")
                )
              ),
              tags$div(style = "height: 15px;"),
              tags$p(strong("Información de la Base de Datos"), style = "font-size: 14pt; color: #848888; text-align: left;"),
              tags$div(
                style = "text-align: justify; font-size: 12pt; color: #697070;",
                tags$ul(
                  tags$li(strong("Fuente"), " – ", tags$a("Datos Abiertos de la CDMX", href = "https://datos.cdmx.gob.mx/explore/dataset/carpetas-de-investigacion-pgj-de-la-ciudad-de-mexico/")),
                  tags$li(strong("Número de Registros"), " – ", textOutput(outputId = "pgj_cuantos", inline = TRUE)),
                  tags$li(strong("Periodo Temporal"), " – ", textOutput(outputId = "pgj_cuando1", inline = TRUE), " a ", textOutput(outputId = "pgj_cuando2", inline = TRUE))
                )
              ),
              tags$div(style = "height: 15px;")
            ),
            column(
              6,
              tags$div(style = "height: 15px;"),
              tags$p(strong("Diccionario de Datos"), style = "font-size: 14pt; color: #848888; text-align: left;"),
              # ===== Tabla PGJ =====
              tags$table(
                style = "width: 100%; font-size: 10pt;", class = "diccionario",
                tags$col(width = "17%"), tags$col(width = "58%"), tags$col(width = "25%"),
                tags$tr(
                  class = "diccionario dicc_header",
                  tags$th("Nombre de la Variable", class = "diccionario dicc_center"), tags$th("Descripción", class = "diccionario dicc_center"), tags$th("Tipo o Categorías", class = "diccionario dicc_center")
                ),
                tags$tr(tags$td("ao_hechos", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Año en que ocurrió el hecho", class = "diccionario"),
                        tags$td("Entero", class = "diccionario"),
                        class = "diccionario"
                ),
                tags$tr(tags$td("mes_hechos", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Mes en el que ocurrió el hecho", class = "diccionario"),
                        tags$td("Texto", class = "diccionario"),
                        class = "diccionario"
                ),
                tags$tr(tags$td("fecha_hechos", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Día, mes, año y hora en el que ocurrió el hecho", class = "diccionario"),
                        tags$td("Texto, en formato “aaaa-mm-dd hh:mm” (24 hrs)", class = "diccionario"),
                        class = "diccionario"
                ),
                tags$tr(
                  tags$td("ao_inicio", class = "diccionario dicc_center dicc_rndm"),
                  tags$td("Año en el cual se abrió la carpeta de investigación", class = "diccionario"),
                  tags$td("Entero", class = "diccionario")
                ),
                tags$tr(tags$td("mes_inicio", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Mes en el cual se abrió la carpeta de investigación", class = "diccionario"),
                        tags$td("Texto", class = "diccionario"),
                        class = "diccionario"
                ),
                tags$tr(tags$td("fecha_inicio", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Día, mes, año y hora en el cual se abrió la carpeta de investigación", class = "diccionario"),
                        tags$td("Texto, en formato “aaaa-mm-dd hh:mm” (24 hrs)", class = "diccionario"),
                        class = "diccionario"
                ),
                tags$tr(tags$td("delito", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Tipo penal con base en Código Penal de la CDMX", class = "diccionario"),
                        tags$td("8 Tipos Penales (", tags$span(id = "bd_delitos-pgj", tags$u("Ver"), style = "color: #00AA5A;"), ")", class = "diccionario"),
                        class = "diccionario"
                ),
                tags$tr(tags$td("fiscalia", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Entidad pública encargada de la investigación", class = "diccionario"),
                        tags$td("24 fiscalías", class = "diccionario"),
                        class = "diccionario"
                ),
                tags$tr(tags$td("agencia", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Clave de la agencia encargada de la investigación", class = "diccionario"),
                        tags$td("89 agencias", class = "diccionario"),
                        class = "diccionario"
                ),
                tags$tr(tags$td("unidad_investigacion", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Clave con unidad de investigación detallando si existieron detenidos", class = "diccionario"),
                        tags$td("20 claves", class = "diccionario"),
                        class = "diccionario"
                ),
                tags$tr(tags$td("categoria_delito", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Categoría del delito con base en Código Penal de la CDMX", class = "diccionario"),
                        tags$td("1 categoría (Delito de Bajo Impacto)", class = "diccionario"),
                        class = "diccionario"
                ),
                tags$tr(tags$td("calle_hechos", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Nombre de la calle del hecho", class = "diccionario"),
                        tags$td("12,336 calles", class = "diccionario"),
                        class = "diccionario"
                ),
                tags$tr(tags$td("calle_hechos2", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Segunda referencia al lugar donde ocurrieron los hechos", class = "diccionario"),
                        tags$td("8,581 calles", class = "diccionario"),
                        class = "diccionario"
                ),
                tags$tr(tags$td("colonia_hechos", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Nombre de la colonia del hecho", class = "diccionario"),
                        tags$td("1,370 colonias", class = "diccionario"),
                        class = "diccionario"
                ),
                tags$tr(tags$td("alcaldia_hechos", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Nombre de la alcaldia del hecho", class = "diccionario"),
                        tags$td("16 alcaldías", class = "diccionario"),
                        class = "diccionario"
                ),
                tags$tr(tags$td("longitud", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Coordenada X", class = "diccionario"),
                        tags$td("Numérico", class = "diccionario"),
                        class = "diccionario"
                ),
                tags$tr(tags$td("latitud", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Coordenada Y", class = "diccionario"),
                        tags$td("Numérico", class = "diccionario"),
                        class = "diccionario"
                )
              )
              # =====
            )
          )
        ),
        tabPanel(
          title = "SSC",
          fluidRow(
            column(
              6,
              tags$div(style = "height: 15px;"),
              tags$div(
                style = "font-size: 18pt; color: #848888; text-align: left;",
                tags$p(
                  tags$img(src = "www/ssc.png", style = "height: 85px; float: right;"),
                  strong("Secretaría de Seguridad Ciudadana (SSC)")
                )
              ),
              tags$div(style = "height: 15px;"),
              tags$p(strong("Objetivo de la Base de Datos"), style = "font-size: 14pt; color: #848888; text-align: left;"),
              tags$div(
                style = "text-align: justify; font-size: 12pt; color: #697070;",
                tags$ul(
                  tags$li(lista_textos$objetivo_base_datos_SSC_1),
                  tags$li(lista_textos$objetivo_base_datos_SSC_2),
                  tags$li(lista_textos$objetivo_base_datos_SSC_3),
                  tags$li(lista_textos$objetivo_base_datos_SSC_4)
                ),
                tags$p(
                  style = "font-size: 10pt;",
                  strong("Referencia"), " – ", tags$a("Ley Orgánica de la Secretaría de Seguridad Pública del Distrito Federal", href = "http://data.consejeria.cdmx.gob.mx/images/leyes/leyes/LEY_ORGANICA_DE_LA_SECRETARIA_DE_SEGURIDAD_PUBLICA_DEL_DF_1.pdf")
                )
              ),
              tags$div(style = "height: 15px;"),
              tags$p(strong("Información de la Base de Datos"), style = "font-size: 14pt; color: #848888; text-align: left;"),
              tags$div(
                style = "text-align: justify; font-size: 12pt; color: #697070;",
                tags$ul(
                  tags$li(strong("Fuente"), " – ", tags$a("Datos Abiertos de la CDMX", href = "https://datos.cdmx.gob.mx/explore/dataset/hechos-de-transito-registrados-por-la-ssc-serie-para-comparaciones-interanuales-")),
                  tags$li(strong("Número de Registros"), " – ", textOutput(outputId = "ssc_cuantos", inline = TRUE)),
                  tags$li(strong("Periodo Temporal"), " – ", textOutput(outputId = "ssc_cuando1", inline = TRUE), " a ", textOutput(outputId = "ssc_cuando2", inline = TRUE))
                )
              ),
              tags$div(style = "height: 15px;")
            ),
            column(
              6,
              tags$div(style = "height: 15px;"),
              tags$p(strong("Diccionario de Datos"), style = "font-size: 14pt; color: #848888; text-align: left;"),
              # ===== Tabla SSC =====
              tags$table(
                style = "width: 100%; font-size: 10pt;", class = "diccionario",
                tags$col(width = "17%"), tags$col(width = "58%"), tags$col(width = "25%"),
                tags$tr(
                  class = "diccionario dicc_header",
                  tags$th("Nombre de la Variable", class = "diccionario dicc_center"), tags$th("Descripción", class = "diccionario dicc_center"), tags$th("Tipo o Categorías", class = "diccionario dicc_center")
                ),
                tags$tr(tags$td("no_folio", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Número de folio único asignado a cada registro", class = "diccionario"),
                        tags$td("Entero", class = "diccionario"),
                        class = "diccionario"
                ),
                tags$tr(tags$td("fecha_evento", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Fecha en la cual ocurrió el incidente vial", class = "diccionario"),
                        tags$td('Texto en formato "aa-mm-dd"', class = "diccionario"),
                        class = "diccionario"
                ),
                tags$tr(tags$td("año_evento", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Año en el cual ocurrió el incidente vial", class = "diccionario"),
                        tags$td("Entero", class = "diccionario"),
                        class = "diccionario"
                ),
                tags$tr(tags$td("mes_evento", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Mes en el cual ocurrió el incidente vial", class = "diccionario"),
                        tags$td("12 meses", class = "diccionario"),
                        class = "diccionario"
                ),
                tags$tr(tags$td("hora_evento", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Hora en la cual ocurrió el incidente vial", class = "diccionario"),
                        tags$td('Texto en formato "hh:mm"', class = "diccionario"),
                        class = "diccionario"
                ),
                tags$tr(tags$td("condicion", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Detalla si la víctima principal resultó lesionada o falleció en el incidente", class = "diccionario"),
                        tags$td("Texto (Lesionado y Occiso)", class = "diccionario"),
                        class = "diccionario"
                ),
                tags$tr(tags$td("tipo_evento", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Descripción del tipo de incidente vial ocurrido", class = "diccionario"),
                        tags$td("6 Tipos de Eventos (", tags$span(id = "bd_evento-ssc", tags$u("Ver"), style = "color: #00AA5A;"), ")", class = "diccionario"),
                        class = "diccionario"
                ),
                tags$tr(tags$td("coordenada_x", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Longitud del incidente", class = "diccionario"),
                        tags$td("Numérico", class = "diccionario"),
                        class = "diccionario"
                ),
                tags$tr(tags$td("coordenada_y", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Latitud del incidente", class = "diccionario"),
                        tags$td("Numérico", class = "diccionario"),
                        class = "diccionario"
                ),
                tags$tr(tags$td("punto_1", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Calle de referencia en la cual ocurrió el incidente", class = "diccionario"),
                        tags$td("Texto", class = "diccionario"),
                        class = "diccionario"
                ),
                tags$tr(tags$td("punto_2", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Calle secundaria de referencia en la cual ocurrió el incidente", class = "diccionario"),
                        tags$td("Texto", class = "diccionario"),
                        class = "diccionario"
                ),
                tags$tr(tags$td("colonia", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Colonia dentro de la cual ocurrió el incidente", class = "diccionario"),
                        tags$td("Texto", class = "diccionario"),
                        class = "diccionario"
                ),
                tags$tr(tags$td("alcaldia", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Alcaldía dentro de la cual ocurrió el incidente", class = "diccionario"),
                        tags$td("16 Alcaldías", class = "diccionario"),
                        class = "diccionario"
                ),
                tags$tr(tags$td("tipo_interseccion", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Intersección sobre la cual ocurrió el incidente", class = "diccionario"),
                        tags$td("Texto (Cruz, Curva, Desnivel, Gaza, Glorieta, Ramas Múltiples, Recta, T o Y)", class = "diccionario"),
                        class = "diccionario"
                ),
                tags$tr(tags$td("tipo_vehiculo", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Descripción de los vehículos involucrados en el incidente. Cada uno se encuentra descrito en columnas diferentes", class = "diccionario"),
                        tags$td("15 Tipos de Vehículos (", tags$span(id = "bd_vehiculo-ssc", tags$u("Ver"), style = "color: #00AA5A;"), ")", class = "diccionario"),
                        class = "diccionario"
                ),
                tags$tr(tags$td("marca_vehiculo", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Marca de los vehículos involucrados en el incidente. Cada marca se encuentra descrita en columnas diferentes", class = "diccionario"),
                        tags$td("Texto", class = "diccionario"),
                        class = "diccionario"
                ),
                tags$tr(tags$td("lesiones", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Descripción detallada de las lesiones sufridas por la víctima principal del incidente", class = "diccionario"),
                        tags$td("Texto", class = "diccionario"),
                        class = "diccionario"
                ),
                tags$tr(tags$td("Edades de Occisos / Lesionados", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Conjunto de columnas que describen las edades", class = "diccionario"),
                        tags$td("15 Tipos de Vehículos (", tags$span(id = "bd_vehiculo-ssc", tags$u("Ver"), style = "color: #00AA5A;"), ")", class = "diccionario"),
                        class = "diccionario"
                )
              )
            )
          )
        ),
        tabPanel(
            title = "C5",
            fluidRow(
              column(
                6,
                tags$div(style = "height: 15px;"),
                tags$div(
                  style = "font-size: 18pt; color: #848888; text-align: left;",
                  tags$p(
                    tags$img(src = "www/c5.png", style = "height: 85px; float: right;"),
                    strong("Centro de Comando, Control, Cómputo, Comunicaciones y Contacto Ciudadano de la Ciudad de México (C5)")
                  )
                ),
                tags$div(style = "height: 15px;"),
                tags$p(strong("Objetivo de la Base de Datos"), style = "font-size: 14pt; color: #848888; text-align: left;"),
                tags$div(
                  style = "text-align: justify; font-size: 12pt; color: #697070;",
                  tags$ul(
                    tags$li(lista_textos$objetivo_base_datos_C5_1),
                    tags$li(lista_textos$objetivo_base_datos_C5_2),
                    tags$li(lista_textos$objetivo_base_datos_C5_3),
                    tags$li(lista_textos$objetivo_base_datos_C5_4)
                  ),
                  tags$p(
                    style = "font-size: 10pt;",
                    strong("Referencia"), " – ", tags$a("Manual Administrativo del C5", href = "https://www.c5.cdmx.gob.mx/storage/app/uploads/public/5be/b2e/318/5beb2e31874de742733714.pdf")
                  )
                ),
                tags$div(style = "height: 15px;"),
                tags$p(strong("Información de la Base de Datos"), style = "font-size: 14pt; color: #848888; text-align: left;"),
                tags$div(
                  style = "text-align: justify; font-size: 12pt; color: #697070;",
                  tags$ul(
                    tags$li(strong("Fuente"), " – ", tags$a("Datos Abiertos de la CDMX", href = "https://datos.cdmx.gob.mx/explore/dataset/incidentes-viales-c5")),
                    tags$li(strong("Número de Registros"), " – ", textOutput(outputId = "c5_cuantos", inline = TRUE)),
                    tags$li(strong("Periodo Temporal"), " – ", textOutput(outputId = "c5_cuando1", inline = TRUE), " a ", textOutput(outputId = "c5_cuando2", inline = TRUE))
                  )
                ),
                tags$div(style = "height: 15px;")
              ),
              column(
                6,
                tags$div(style = "height: 15px;"),
                tags$p(strong("Diccionario de Datos"), style = "font-size: 14pt; color: #848888; text-align: left;"),
                # ===== Tabla C5 =====
                tags$table(
                  style = "width: 100%; font-size: 10pt;", class = "diccionario",
                  tags$col(width = "17%"), tags$col(width = "58%"), tags$col(width = "25%"),
                  tags$tr(
                    class = "diccionario dicc_header",
                    tags$th("Nombre de la Variable", class = "diccionario dicc_center"), tags$th("Descripción", class = "diccionario dicc_center"), tags$th("Tipo o Categorías", class = "diccionario dicc_center")
                  ),
                  tags$tr(tags$td("folio", class = "diccionario dicc_center dicc_rndm"),
                    tags$td("Código único alfa numérico que se la asigna a cada uno de los incidentes, compuesto por dos iniciales del Centro que recibió la emergencia, fecha en formato AA/MM/DD y número consecutivo de ingreso", class = "diccionario"),
                    tags$td("Texto Alfanumérico Variable", class = "diccionario"),
                    class = "diccionario"
                  ),
                  tags$tr(tags$td("fecha_creacion", class = "diccionario dicc_center dicc_rndm"),
                    tags$td("Fecha de apertura del folio del evento", class = "diccionario"),
                    tags$td('Fecha en formato "aaaa-mm-dd"', class = "diccionario"),
                    class = "diccionario"
                  ),
                  tags$tr(tags$td("hora_creacion", class = "diccionario dicc_center dicc_rndm"),
                    tags$td("Hora de apertura del folio del evento", class = "diccionario"),
                    tags$td('Hora en formato "hh:mm:ss"', class = "diccionario"),
                    class = "diccionario"
                  ),
                  tags$tr(tags$td("dia_semana", class = "diccionario dicc_center dicc_rndm"),
                    tags$td("Día de apertura del folio", class = "diccionario"),
                    tags$td("7 días", class = "diccionario"),
                    class = "diccionario"
                  ),
                  tags$tr(tags$td("fecha_cierre", class = "diccionario dicc_center dicc_rndm"),
                    tags$td("Fecha de cierre del folio del evento", class = "diccionario"),
                    tags$td('Fecha en formato "aaaa-mm-dd"', class = "diccionario"),
                    class = "diccionario"
                  ),
                  tags$tr(tags$td("año_cierre", class = "diccionario dicc_center dicc_rndm"),
                    tags$td("Año de cierre del folio del evento", class = "diccionario"),
                    tags$td("Número Entero", class = "diccionario"),
                    class = "diccionario"
                  ),
                  tags$tr(tags$td("mes_cierre", class = "diccionario dicc_center dicc_rndm"),
                    tags$td("Mes de cierre del folio del evento", class = "diccionario"),
                    tags$td("12 meses", class = "diccionario"),
                    class = "diccionario"
                  ),
                  tags$tr(tags$td("hora_cierre", class = "diccionario dicc_center dicc_rndm"),
                    tags$td("Hora de cierre del folio del evento", class = "diccionario"),
                    tags$td('Hora en formato "hh:mm:ss"', class = "diccionario"),
                    class = "diccionario"
                  ),
                  tags$tr(tags$td("delegacion_inicio", class = "diccionario dicc_center dicc_rndm"),
                    tags$td("Alcaldía donde inicialmente se reportó el incidente", class = "diccionario"),
                    tags$td("16 alcaldías", class = "diccionario"),
                    class = "diccionario"
                  ),
                  tags$tr(tags$td("incidente_c4", class = "diccionario dicc_center dicc_rndm"),
                    tags$td("Tipo de incidente", class = "diccionario"),
                    tags$td("21 Incidentes Posibles (", tags$span(id = "bd_incidentes-c5", tags$u("Ver"), style = "color: #00AA5A;"), ")", class = "diccionario"),
                    class = "diccionario"
                  ),
                  tags$tr(tags$td("latitud", class = "diccionario dicc_center dicc_rndm"),
                    tags$td("Coordenada Y", class = "diccionario"),
                    tags$td("Numérico", class = "diccionario"),
                    class = "diccionario"
                  ),
                  tags$tr(tags$td("longitud", class = "diccionario dicc_center dicc_rndm"),
                    tags$td("Coordenada X", class = "diccionario"),
                    tags$td("Numérico", class = "diccionario"),
                    class = "diccionario"
                  ),
                  tags$tr(tags$td("codigo_cierre", class = "diccionario dicc_center dicc_rndm"),
                    tags$td("Código que fue asignado al incidente en el cierre", class = "diccionario"),
                    tags$td("Texto, 2 Categorías (", tags$span(id = "bd_cierre-c5", tags$u("Ver"), style = "color: #00AA5A;"), ")", class = "diccionario"),
                    class = "diccionario"
                  ),
                  tags$tr(tags$td("clas_con_f_alarma", class = "diccionario dicc_center dicc_rndm"),
                    tags$td("Clasificación del Incidente", class = "diccionario"),
                    tags$td("Texto, 4 Categorías (", tags$span(id = "bd_clas-c5", tags$u("Ver"), style = "color: #00AA5A;"), ")", class = "diccionario"),
                    class = "diccionario"
                  ),
                  tags$tr(tags$td("tipo_entrada", class = "diccionario dicc_center dicc_rndm"),
                    tags$td("Medio por el cual se dio aviso del incidente", class = "diccionario"),
                    tags$td("Texto, 6 Categorías (", tags$span(id = "bd_entrada-c5", tags$u("Ver"), style = "color: #00AA5A;"), ")", class = "diccionario"),
                    class = "diccionario"
                  ),
                  tags$tr(tags$td("delegacion_cierre", class = "diccionario dicc_center dicc_rndm"),
                    tags$td("Alcaldía donde cierra el folio del incidente", class = "diccionario"),
                    tags$td("16 alcaldías", class = "diccionario"),
                    class = "diccionario"
                  )
                )
                # =====
              )
            )
          ),
        tabPanel(
          title = "AXA",
          fluidRow(
            column(
              6,
              tags$div(style = "height: 15px;"),
              tags$div(
                style = "font-size: 18pt; color: #848888; text-align: left;",
                tags$p(
                  tags$img(src = "www/axa.png", style = "height: 85px; float: right;"),
                  strong("AXA México")
                )
              ),
              tags$div(style = "height: 15px;"),
              tags$p(strong("Objetivo de la Base de Datos"), style = "font-size: 14pt; color: #848888; text-align: left;"),
              tags$div(
                style = "text-align: justify; font-size: 12pt; color: #697070;",
                tags$ul(
                  tags$li(lista_textos$objetivo_base_datos_AXA_1),
                  tags$li(lista_textos$objetivo_base_datos_AXA_2),
                  tags$li(lista_textos$objetivo_base_datos_AXA_3),
                  tags$li(lista_textos$objetivo_base_datos_AXA_4)
                )
              ),
              tags$div(style = "height: 15px;"),
              tags$p(strong("Información de la Base de Datos"), style = "font-size: 14pt; color: #848888; text-align: left;"),
              tags$div(
                style = "text-align: justify; font-size: 12pt; color: #697070;",
                tags$ul(
                  tags$li(strong("Fuente"), " – ", tags$a("Instituto Internacional de Ciencia de Datos", href = "http://i2ds.org/datos-abiertos-percances-viales/")),
                  tags$li(strong("Número de Registros"), " – ", textOutput(outputId = "axa_cuantos", inline = TRUE)),
                  tags$li(strong("Periodo Temporal"), " – ", textOutput(outputId = "axa_cuando1", inline = TRUE), " a ", textOutput(outputId = "axa_cuando2", inline = TRUE))
                )
              ),
              tags$div(style = "height: 15px;")
            ),
            column(
              6,
              tags$div(style = "height: 15px;"),
              tags$p(strong("Diccionario de Datos"), style = "font-size: 14pt; color: #848888; text-align: left;"),
              # ===== Tabla AXA =====
              tags$table(
                style = "width: 100%; font-size: 10pt;", class = "diccionario",
                tags$col(width = "17%"), tags$col(width = "58%"), tags$col(width = "25%"),
                tags$tr(
                  class = "diccionario dicc_header",
                  tags$th("Nombre de la Variable", class = "diccionario dicc_center"), tags$th("Descripción", class = "diccionario dicc_center"), tags$th("Tipo o Categorías", class = "diccionario dicc_center")
                ),
                tags$tr(tags$td("siniestro", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Identificador único del percance vial", class = "diccionario"),
                        tags$td("Entero", class = "diccionario"),
                        class = "diccionario"
                ),
                tags$tr(tags$td("calle", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Nombre de la calle donde ocurrió el siniestro", class = "diccionario"),
                        tags$td("Texto", class = "diccionario"),
                        class = "diccionario"
                ),
                tags$tr(tags$td("colonia", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Nombre de la colonia donde ocurrió el siniestro", class = "diccionario"),
                        tags$td("Texto", class = "diccionario"),
                        class = "diccionario"
                ),
                tags$tr(tags$td("codigo_postal", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Ubicación postal del percance vial", class = "diccionario"),
                        tags$td("Texto (Número Entero que puede iniciar con cero)", class = "diccionario"),
                        class = "diccionario"
                ),
                tags$tr(tags$td("alcaldia", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Nombre de la alcaldia donde ocurrió el siniestro", class = "diccionario"),
                        tags$td("Texto", class = "diccionario"),
                        class = "diccionario"
                ),
                tags$tr(tags$td("causa_siniestro", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Descripción del tipo de percance ocurrido", class = "diccionario"),
                        tags$td("7 Causas Posibles (", tags$span(id = "bd_siniestro-axa", tags$u("Ver"), style = "color: #00AA5A;"), ")", class = "diccionario"),
                        class = "diccionario"
                ),
                tags$tr(tags$td("tipo_vehiculo", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Vehículo involucrado en el percance vial", class = "diccionario"),
                        tags$td("4 Vehículos Posibles (", tags$span(id = "bd_vehiculo-axa", tags$u("Ver"), style = "color: #00AA5A;"), ")", class = "diccionario"),
                        class = "diccionario"
                ),
                tags$tr(tags$td("color", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Color del vehículo asegurado", class = "diccionario"),
                        tags$td("Texto", class = "diccionario"),
                        class = "diccionario"
                ),
                tags$tr(tags$td("modelo", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Año del vehículo asegurado", class = "diccionario"),
                        tags$td("Entero", class = "diccionario"),
                        class = "diccionario"
                ),
                tags$tr(tags$td("nivel_dano_vehiculo", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Grado de daño al vehículo en el percance vial", class = "diccionario"),
                        tags$td("Texto (Alto, Medio, Bajo y Sin Daños)", class = "diccionario"),
                        class = "diccionario"
                ),
                tags$tr(tags$td("punto_impacto", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Parte del vehículo donde ocurrió el daño", class = "diccionario"),
                        tags$td("Texto (Frontal, Trasero, Lateral Derecho o Lateral Izquierdo)", class = "diccionario"),
                        class = "diccionario"
                ),
                tags$tr(tags$td("ao", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Año en que se registró el percance vial. No necesariamente corresponde al año de ocurrencia", class = "diccionario"),
                        tags$td("Entero", class = "diccionario"),
                        class = "diccionario"
                ),
                tags$tr(tags$td("mes", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Mes en que registró el percance vial. No necesariamente corresponde al mes de ocurrencia", class = "diccionario"),
                        tags$td("Entero", class = "diccionario"),
                        class = "diccionario"
                ),
                tags$tr(tags$td("dia_numero", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Día en que registró el percance. No necesariamente correpsonde al día de ocurrencia", class = "diccionario"),
                        tags$td("Entero", class = "diccionario"),
                        class = "diccionario"
                ),
                tags$tr(tags$td("dia", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Día de la semana en la que se registró el percance", class = "diccionario"),
                        tags$td("7 días de la semana", class = "diccionario"),
                        class = "diccionario"
                ),
                tags$tr(tags$td("hora", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Hora de ocurrencia del percance vial. No necesariamente correpsonde a la hora de ocurrencia", class = "diccionario"),
                        tags$td("Entero", class = "diccionario"),
                        class = "diccionario"
                ),
                tags$tr(tags$td("lesionados", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Cantidad de personas lesionadas en el siniestro", class = "diccionario"),
                        tags$td("Entero", class = "diccionario"),
                        class = "diccionario"
                ),
                tags$tr(tags$td("edad_lesionado", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Corresponde a la edad de cada lesionado", class = "diccionario"),
                        tags$td("Entero", class = "diccionario"),
                        class = "diccionario"
                ),
                tags$tr(tags$td("relacion_lesionados", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Rol que posee el lesionado del percance, especificando si es asegurado o no", class = "diccionario"),
                        tags$td("6 Roles Posibles (", tags$span(id = "bd_rol-axa", tags$u("Ver"), style = "color: #00AA5A;"), ")", class = "diccionario"),
                        class = "diccionario"
                ),
                tags$tr(tags$td("genero_lesionado", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Corresponde al género de cada lesionado", class = "diccionario"),
                        tags$td("Texto", class = "diccionario"),
                        class = "diccionario"
                ),
                tags$tr(tags$td("nivel_lesionado", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Grado de la lesión sufrida", class = "diccionario"),
                        tags$td("Texto (Alto, Medio, Bajo y Sin Lesión)", class = "diccionario"),
                        class = "diccionario"
                ),
                tags$tr(tags$td("hospitalizado", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Confirma si cada lesionado fue o no hospitalizado", class = "diccionario"),
                        tags$td("Booleano", class = "diccionario"),
                        class = "diccionario"
                ),
                tags$tr(tags$td("fallecido", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Confirma si cada lesionado falleció o no en el siniestro", class = "diccionario"),
                        tags$td("Booleano", class = "diccionario"),
                        class = "diccionario"
                ),
                tags$tr(tags$td("Variables Booleanas", class = "diccionario dicc_center dicc_rndm"),
                        tags$td("Conjunto de datos que describren a detalle las variables involucradas en el incidente", class = "diccionario"),
                        tags$td("18 Variables (", tags$span(id = "bd_boolean-axa", tags$u("Ver"), style = "color: #00AA5A;"), ")", class = "diccionario"),
                        class = "diccionario"
                )
              )
              # =====
            )
          )
        )
        
      )
    )
  )
}

#' infoBdUI Server Function
#'
#' The function that controls the tabs 
#' 
#' @param input shiny Parameter where the inputs from the UI are store
#' 
#' @param output shiny parameter where the id are reference to display in the UI  
#' 
#' @param session shiny parameter to store the session 
mod_infoBdUI_server <- function(input, output, session, parent) {
  ns <- session$ns
  observeEvent(input$boton_ver_visualizador, {
    shinydashboard::updateTabItems(parent,
                                   inputId = "tabs",
                                   selected = "visualizador"
    )
  })
}

## To be copied in the UI
# mod_infoBdUI_ui("infoBdUI_ui_1")

## To be copied in the server
# callModule(mod_infoBdUI_server, "infoBdUI_ui_1")
