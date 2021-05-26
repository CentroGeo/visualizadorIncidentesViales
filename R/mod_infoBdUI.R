lista_textos <- list(
  bases_de_datos = "A continuación, encontrará información detallada sobre \
  las Bases de Datos utilizadas en esta aplicación, a modo de conocer más \
  a fondo su función original en el organismo generador y su utilidad para \
  los objetivos de la SEMOVI.",
  objetivo_base_datos_FGJ_1 = "A través del Ministerio Público, tiene las atribuciones \
  de investigar los delitos de orden común cometidos en la Ciudad de México y perseguir \
  a los imputados promoviendo la pronta, expedita y debida procuración de Justicia.",
  objetivo_base_datos_FGJ_2 = "Gran parte de la información recabada por esta dependencia, \
  se complementa en el lugar de investigación",
  objetivo_base_datos_FGJ_3 = "Esta fuente de información es fundamental debido a que un \
  incidente vial puede resultar en la comisión de delitos por hechos de tránsito como daños, \
  lesiones o incluso homicidio (no intencional). En tanto, la FGJ es el organismo facultado \
  para llevar a cabo la investigación de los delitos mencionados y de recopilar la información 
  derivada de los mismos. El Ministerio Público es quien coordina la investigación y recaba \
  la información a través de las entrevistas a víctimas, imputados, primeros respondientes \
  (en general elementos de la policía de la SSC) y peritos. ",

  objetivo_base_datos_SSC_1 = "Sus atribuciones en la Ciudad de México, encaminan las \
  acciones dirigidas a salvaguardar la integridad y patrimonio de las personas, prevenir \
  la comisión de delitos e infracciones a las disposiciones gubernativas y de policía, \
  así como a preservar las libertades, el orden y la paz públicos.",
  objetivo_base_datos_SSC_2 = "La información que tiene la SSC está en función a la atención \
  que se brinda a través de la policía, por lo cual pueden allegarse de información que sólamente\
   es posible recopilar cuando el incidente vial es atendido en campo.",
  objetivo_base_datos_SSC_3 = "En la cadena de operaciones, son el primer contacto físico con \
  la ciudadanía que se encuentra involucrada en un incidente vial, por lo que tienen la \
  facilidad de recabar información casi al momento del evento.",
  replicar_resultados_ssc_intro = "Se toma como partida la base no comparativa ya que estamos analizando \
  los datos a partir de 2019. Para obtrener los incidentes base (a partir de donde se calculan los demás)\
  necesitamos filtrar los que no contengan datos válidos en fechas y coordenadas.\
  Además, no se consideran aquellos incidentes en donde el campo 'unidad_a_cargo'\
  tenga el valor 'SD'",
  objetivo_base_datos_C5_1 = "Proveer información a la Jefa de Gobierno de la \
  CDMX para la oportuna inmediata toma de decisiones.",
  objetivo_base_datos_C5_2 = "Captación de información en distintas materias, \
  como procuración de justicia, seguridad ciudadana, urgencias médicas y movilidad, \
  mediante la integración y análisis de la información captada a través de sus diferentes \
  medios de entrada como el Servicio de Atención de Llamadas a Emergencias 9-1-1  así como \
  Denuncia Anónima 089 .",
  objetivo_base_datos_C5_3 = "La información que se tiene corresponde a los reportes tomados \
  por las y los operadores del C5 con información directa de la ciudadanía. Tales operadores \
  realizan la clasificación de los eventos.",
  objetivo_base_datos_C5_4 = "Utilizar la información captada para difundir índices delictivos, \
  zonas peligrosas, intersecciones viales más conflictivas y percances viales, entre otros.",
  objetivo_base_datos_C5_5 = "Esta dependencia cuenta con más reportes por hechos de tránsito, debido a que cuando \
  no hay personas fallecidas o lesionadas a consecuencia de ellos, no tienen continuidad\
   ante la policía o la FGJ.",
  objetivo_base_datos_AXA_1 = "Es una aseguradora multirramo de origen \
  francés con presencia en 57 países.",
  objetivo_base_datos_AXA_2 = "Esta fuente, contiene información referente a los siniestros \
  reportados por sus asegurados, sin incluir datos personales. \
  La base incluye los siniestros georreferenciados, así como el desglose sobre causas y\
   entorno que intervino en el incidente.",
  objetivo_base_datos_AXA_3 = "Desde 2019, AXA Seguros se suma a través de un convenio \
  de colaboración para la integración de su información, garantizando la protección \
  de datos personales.",
  objetivo_base_datos_AXA_4 = "El personal que atiende a sus \
  asegurados, se recopila la información la cual es capturada en un \
  sistema de registro único.",
  ## ==============Introduccion ==========================
  bases_de_datos_fix_1_0 = "Para llevar a cabo el análisis y seguimiento de \
  las tendencias de los hechos de tránsito ocurridos en la Ciudad de México, \
  la Secretaría de Movilidad (SEMOVI) hace uso de la información de cuatro \
  fuentes de datos abiertos: la Secretaría de Seguridad Ciudadana (SSC), \
  el Centro de Comando, Control, Cómputo, Comunicaciones y Contacto \
  Ciudadano de la Ciudad de México (C5), la Fiscalía General de Justicia de \
  la Ciudad de México (FGJ) y AXA Seguros. Es importante subrayar que",
  bases_de_datos_fix_1_1 = "la SEMOVI no es responsable de generar los datos \
  provistos",
  bases_de_datos_fix_1_2 = ", sino que ",
  bases_de_datos_fix_1_3 = "cada una de las instituciones mencionadas produce\
   su información cumpliendo objetivos distintos y haciendo uso de \
   diferentes metodologías",
  bases_de_datos_fix_1_4 = ", lo que se refleja en lo reportado por cada \
  institución.",

  bases_de_datos_fix_2 = "En lo que a la SSC respecta, su base de datos \
  reporta exclusivamente los hechos de tránsito que derivaron en personas \
  lesionadas y/o fallecidas; un registro corresponde a un hecho de \
  tránsito con una o varias víctimas. A lo largo del tiempo la SSC ha \
  sufrido diversos cambios en sus metodologías de recolección y \
  procesamiento de información. Durante el primer semestre de 2018 su base \
  de datos se alimentaba de los reportes realizados por las unidades médicas \
  de apoyo del ERUM y la Cruz Roja Mexicana, y los reportes por fallecimiento \
  de cualquier unidad médica sin importar fuera pública o privada; para el \
  segundo semestre la fuente de ingreso de información cambió a las \
  frecuencias de radio a través del Puesto de Mando de la SSC, permaneciendo \
  esta metodología durante todo el 2019 y enero de 2020. Para febrero de 2020 \
  el Puesto de Mando se incorporó al C5 para integrar y mejorar la \
  coordinación de atención a emergencias en la Ciudad, convirtiendo a esta \
  última junto con los reportes ciudadanos de hechos de tránsito con muertes, \
  a través de redes sociales, en su nueva fuente de acopio y recolección de \
  información relacionada con los incidentes viales. Para hacer comparables \
  2021 y 2020 con 2019 es necesario eliminar aquellos hechos que fueron \
  reportados pero no corroborados en sitio(*).",

  bases_de_datos_fix_3 = "El Centro de Comando, Control, Cómputo, \
  Comunicaciones y Contacto Ciudadano (C5)  registra todos aquellos reportes \
  por incidentes viales ingresados a través de sus diferentes canales de \
  emergencia (llamadas al 911, botones de auxilio y equipos de radio de \
  policía, entre otros(**)), sin hacer distinción entre incidentes sin víctimas \
  (“lamineros”) y aquellos que derivaron en personas lesionadas y/o \
  fallecidas. Son de interés sólo aquellos reportes afirmativos, es decir, \
  aquellos en los que la unidad de atención a emergencias fue despachada, \
  llegó al lugar de los hechos y confirmó la emergencia reportada en el lugar \
  de los hechos por un policía o por las cámaras del Centro de Comando y \
  Control (C2) y los reportes en los que el incidente reportado es afirmativo \
  y se añade información adicional al evento. Los registros de la base de \
  datos de esta dependencia corresponden a reportes por hechos de tránsito \
  con víctimas o sin víctimas, sin embargo, no es posible conocer el total de \
  víctimas involucradas en cada reporte, por lo que los indicadores total de \
  personas lesionadas y total de personas fallecidas están calculados con \
  base en el número de reportes por hechos de tránsito con víctimas.",

  bases_de_datos_fix_4 = "La FGJ reporta únicamente los incidentes por los \
  cuales se abrió una carpeta de investigación en las agencias del \
  Ministerio Público por delitos relacionados con percances de tránsito. Su \
  base de datos se compone por los registros de las víctimas relacionadas con \
  dichos incidentes por lo que para analizar el total de carpetas de \
  investigación es necesario eliminar aquellos folios duplicados, debido a que \
  una carpeta de investigación puede corresponder a una o más víctimas e \
  inclusive a uno o más delitos. Es importante destacar que es necesario solo \
  tomar en cuenta aquellos incidentes ocurridos en la Ciudad de México.",

  bases_de_datos_fix_5 = "La información de AXA Seguros corresponde a todos \
  los siniestros viales en los que se ven involucrados los vehículos \
  asegurados por esta compañía. Incluye aquellos siniestros en donde hubo \
  personas lesionadas y/o fallecidas, así como los incidentes comúnmente \
  denominados “lamineros”. Su base de datos se compone por los registros de \
  las víctimas relacionadas con dichos percances, por lo que para analizar el \
  total de siniestros es necesario eliminar los folios duplicados.",

  bases_de_datos_pie_1 = "* UNIDAD A CARGO = SD",

  bases_de_datos_pie_2 = "** A partir de octubre de 2020 se agregó el tipo de \
  entrada APLICATIVOS, mismos que deben ser eliminados con el objetivo de \
  hacer comparativo 2021 con 2020 y 2019.",



##### =========== FGJ Replicar ==================================
  ### FGJ SIN Lesionados
  hechos_sin_lesionadas_FGJ = "Son todos aquellos registros que cumplen \
  #con las siguientes condiciones:",
  replicar_sin_lesionadas_FGJ_1 = "Tomar en cuenta todos los hechos de \
  tránsito, sin importar si la longitud y latitud corresponde con las de \
  la CDMX (es posible que existan errores en las coordenadas). No \
  obstante el campo Alcaldía debe corresponder con las alcaldías de la \
  CDMX, no tomar en cuenta los registros de un municipio correspondiente \
  a una entidad distinta de la Ciudad de México.",
  replicar_sin_lesionadas_FGJ_2 = "idCarpeta sin duplicados",
  replicar_sin_lesionadas_FGJ_3 = "Año_hecho: corresponda con el año de \
  análisis",
  replicar_sin_lesionadas_FGJ_4 = "Mes_hecho: corresponda con el mes o \
  los meses de análisis",
  replicar_sin_lesionadas_FGJ_5 = "Delito: corresponda con las siguientes \
  categorías:",
  categoria_FGJ_sin_lesionados_a = "DAÑO EN PROPIEDAD AJENA CULPOSA POR \
  TRÁNSITO VEHICULAR A AUTOMOVIL",
  categoria_FGJ_sin_lesionados_b = "DAÑO EN PROPIEDAD AJENA CULPOSA POR \
  TRÁNSITO VEHICULAR A BIENES INMUEBLES",
  categoria_FGJ_sin_lesionados_c = "DAÑO EN PROPIEDAD AJENA CULPOSA POR \
  TRÁNSITO VEHICULAR A VIAS DE COMUNICACION",
  replicar_sin_lesionadas_FGJ_6 = "CalidadJuridica: con valor distinto a\
   'CADAVER'",
  ### FGJ Decesos
  hechos_decesos_FGJ = "Son todos aquellos registros que cumplen con las \
  siguientes condiciones",
  replicar_decesos_FGJ_1 = "Tomar en cuenta todos los hechos de tránsito, \
  sin importar si la longitud y latitud corresponde con las de la CDMX (es \
  posible que existan errores en las coordenadas). No obstante el campo \
  Alcaldía debe corresponder con las alcaldías de la CDMX, no tomar en \
  cuenta los registros de un municipio correspondiente a una entidad \
  distinta de la Ciudad de México",
  replicar_decesos_FGJ_2 = "Año_hecho: corresponda con el año de análisis",
  replicar_decesos_FGJ_3 = "Mes_hecho: corresponda con el mes o los \
  meses de análisis",
  replicar_decesos_FGJ_4 = "Delito: corresponda con las siguientes categorías:",
  categoria_FGJ_decesos_a = "HOMICIDIO CULPOSO POR TRÁNSITO VEHICULAR",
  categoria_FGJ_decesos_b = "HOMICIDIO CULPOSO POR TRÁNSITO VEHICULAR \
  (ATROPELLADO)",
  categoria_FGJ_decesos_c = "HOMICIDIO CULPOSO POR TRÁNSITO VEHICULAR \
  (CAIDA)",
  categoria_FGJ_decesos_d = "HOMICIDIO CULPOSO POR TRÁNSITO \
  VEHICULAR (COLISION)",
  categoria_FGJ_decesos_e = "LESIONES CULPOSAS POR TRANSITO VEHICULAR",
  categoria_FGJ_decesos_f = "LESIONES CULPOSAS POR TRANSITO VEHICULAR EN \
  COLISION",
  categoria_FGJ_decesos_g = "DAÑO EN PROPIEDAD AJENA CULPOSA POR TRÁNSITO \
  VEHICULAR A AUTOMOVIL",
  categoria_FGJ_decesos_h = "DAÑO EN PROPIEDAD AJENA CULPOSA POR TRÁNSITO \
  VEHICULAR A BIENES INMUEBLES",
  categoria_FGJ_decesos_i = "DAÑO EN PROPIEDAD AJENA CULPOSA POR TRÁNSITO \
  VEHICULAR A VIAS DE COMUNICACION",
  replicar_decesos_FGJ_5 = "CalidadJuridica: con valor igual a 'CADAVER'",
  ### FGJ Lesionados
  hechos_lesionados_FGJ = "Son todos aquellos registros que cumplen con \
  las siguientes condiciones:",
  replicar_lesionados_FGJ_1 = "Tomar en cuenta todos los hechos de tránsito, \
  sin importar si la longitud y latitud corresponde con las de la CDMX (es \
  posible que existan errores en las coordenadas). No obstante el campo \
  Alcaldía debe corresponder con las alcaldías de la CDMX, no tomar en cuenta \
  los registros de un municipio correspondiente a una entidad distinta de \
  la Ciudad de México.",
  replicar_lesionados_FGJ_2 = "Año_hecho: corresponda con el año de análisis",
  replicar_lesionados_FGJ_3 = "Mes_hecho: corresponda con el mes o los meses \
  de análisis",
  replicar_lesionados_FGJ_4 = "Delito: corresponda con las siguientes \
  categorías:",
  replicar_lesionados_FGJ_5 = "CalidadJuridica: diferente de CADAVER",
  categoria_FGJ_lesionados_a = "LESIONES CULPOSAS POR TRANSITO VEHICULAR",
  categoria_FGJ_lesionados_b = "LESIONES CULPOSAS POR TRANSITO VEHICULAR \
  EN COLISION",
  ## FGJ Heat map
  heatmap_FGJ_día_hora = "Son todos aquellos registros que cumplen con \
  las siguientes condiciones",
  replicar_FGJ_heatmap_1 =  "Tomar en cuenta todos los hechos de tránsito, \
  sin importar si la longitud y latitud corresponde con las de la CDMX (es \
  posible que existan errores en las coordenadas). No obstante el campo \
  Alcaldía debe corresponder con las alcaldías de la CDMX, no tomar en cuenta \
  los registros de un municipio correspondiente a una entidad distinta de \
  la Ciudad de México.",
  replicar_FGJ_heatmap_2 = "idCarpeta: sin duplicados",
  replicar_FGJ_heatmap_3 = "Año_hecho: corresponda con el año de análisis",
  replicar_FGJ_heatmap_4 = "Mes_hecho: corresponda con el mes o los meses \
  de análisis",
  replicar_FGJ_heatmap_5 = "Delito: corresponda con las categorías \
  correspondientes",
  replicar_FGJ_heatmap_6 = "Para la hora de ocurrencia del hecho de tránsito, \
  tomamos en cuenta el campo HoraHecho",
  ##### =========== AXA Replicar ==================================
  ### AXA SIN Lesionados
  personas_sin_lesionadas_AXA = "Son todos aquellos registros que cumplen \
  con las siguientes condiciones",
  replicar_sin_lesionadas_AXA_1 = "SINIESTRO: sin duplicados",
  replicar_sin_lesionadas_AXA_2 = "AÑO: corresponda con el año de análisis",
  replicar_sin_lesionadas_AXA_3 = "MES: corresponda con el mes o los meses \
  de análisis",
  replicar_sin_lesionadas_AXA_4 = "Tomar en cuenta aquellos registros en \
  los que LESIONADOS igual a cero",
  ### AXA Decesos
  hechos_decesos_AXA = " Son todos aquellos registros que cumplen con \
  las siguientes condiciones:",
  replicar_decesos_AXA_1 = "AÑO: corresponda con el año de análisis",
  replicar_decesos_AXA_2 = "MES: corresponda con el mes o los meses \
  de análisis",
  replicar_decesos_AXA_3 = "Contabilizar aquellos registros en los que \
  FALLECIDO sea igual a Sí",
  ### AXA Lesionados
  hechos_lesionados_AXA = "Son todos aquellos registros que cumplen con \
  las siguientes condiciones",
  replicar_lesionados_AXA_1 = "AÑO: corresponda con el año de análisis",
  replicar_lesionados_AXA_2 = "MES: corresponda con el mes o los meses \
  de análisis",
  replicar_lesionados_AXA_3 = "Tomar en cuenta la sumatoria de aquellos \
  registros en los que LESIONADOS sea mayor a cero",
  ## AXA Heat map
  heatmap_AXA_día_hora = "Son todos aquellos registros que cumplen con \
  las siguientes condiciones",
  replicar_AXA_heatmap_1 = "SINIESTRO: sin duplicados",
  replicar_AXA_heatmap_2 = "AÑO: corresponda con el año de análisis",
  replicar_AXA_heatmap_3 = "MES: corresponda con el mes o los meses \
  de análisis",
  replicar_AXA_heatmap_4 = "Para la hora de ocurrencia del hecho de \
  tránsito, tomamos en cuenta el campo HORA",
  
  ####========================C5 Replicar========================
  ### C5 Sin Lesioonados
  hechos_sin_lesionadas_c5 = "Son todos aquellos registros \
  que cumplen con las siguientes condiciones:",
  replicar_sin_lesionadas_c5_1 = "folio: folio no repetido",
  replicar_sin_lesionadas_c5_2 = "Tomar en cuenta todos los \
  hechos de tránsito, sin importar si la longitud y latitud \
  corresponde con las de la CDMX (es posible que existan errores en \
  las coordenadas)",
  replicar_sin_lesionadas_c5_3 = "fecha_creación: corresponda con el mes \
  o los meses y, el año de análisis",
  replicar_sin_lesionadas_c5_4 = "codigo_cierre: sea (A) La unidad de atención\
   a emergencias fue despachada, llegó al lugar de los hechos y \
   confirmó la emergencia reportada o (I) El incidente reportado es \
   afirmativo y se añade información adicional al evento",
  replicar_sin_lesionadas_c5_5 = "Incidente_c4: corresponda con las \
  siguientes categorías:",
  categorias_c5_a = "accidente-choque sin lesionados",
  categorias_c5_b = "detención ciudadana-accidente automovilístico",
  categorias_c5_c = "accidente-ciclista",
  categorias_c5_d = "accidente-ferroviario",
  categorias_c5_e = "accidente-monopatín",
  categorias_c5_f = "accidente-motociclista",
  categorias_c5_g = "accidente-otros",
  categorias_c5_h = "accidente-choque con prensados",
  categorias_c5_i = "accidente-persona atrapada / desbarrancada",
  categorias_c5_j = "accidente-vehiculo atrapado",
  categorias_c5_k = "accidente-vehículo atrapado-varado",
  categorias_c5_l = "accidente-vehiculo desbarrancado",
  categorias_c5_m = "accidente-volcadura",
  ### C5 Decesos
  hechos_decesos_c5 =  "Son todos aquellos registros que cumplen \
  con las siguientes condiciones:",
  replicar_decesos_c5_1 =  "Tomar en cuenta todos los hechos de \
  tránsito, sin importar si la longitud y latitud corresponde con las \
  de la CDMX (es posible que existan errores en las coordenadas)",
  replicar_decesos_c5_2 = "fecha_creación: corresponda con el mes o \
  los meses y, el año de análisis",
  replicar_decesos_c5_3 = "codigo_cierre: sea (A) La unidad de atención \
  a emergencias fue despachada, llegó al lugar de los hechos y confirmó \
  la emergencia reportada o (I) El incidente reportado es afirmativo y se \
  añade información adicional al evento",
  replicar_decesos_c5_4 = "Tomar en cuenta los registros en donde \
  incidente_c4 corresponda con cadáver-atropellado y cadáver-accidente \
  automovilístico",
  ##C5 Lesionados
  hechos_lesionados_c5 = "Son todos aquellos registros que cumplen con las \
  siguientes condiciones:",
  replicar_lesionados_c5_1 = "Tomar en cuenta todos los hechos de \
  tránsito, sin importar si la longitud y latitud corresponde con las \
  de la CDMX (es posible que existan errores en las coordenadas)",
  replicar_lesionados_c5_2 = "fecha_creación: corresponda con el mes o \
  los meses y, el año de análisis",
  replicar_lesionados_c5_3 = "codigo_cierre: sea (A) La unidad de \
  atención a emergencias fue despachada, llegó al lugar de los hechos y \
  confirmó la emergencia reportada o (I) El incidente reportado es afirmativo \
  y se añade información adicional al evento",
  replicar_lesionados_c5_4 = "Tomar en cuenta los registros en donde \
  incidente_c4 corresponda con accidente-choque con lesionados, detención \
  ciudadana-atropellado, lesionado-atropellado, y lesionado-accidente \
  automovilístico",
  ## C5 Heat map
  heatmap_c5_día_hora = "Son todos aquellos registros que cumplen con \
  las siguientes condiciones",
  replicar_c5_heatmap_1 = "folio: folio no repetido",
  replicar_c5_heatmap_2 = "Tomar en cuenta todos los hechos de tránsito, \
  sin importar si la longitud y latitud corresponde con las de la CDMX \
  (es posible que existan errores en las coordenadas)",
  replicar_c5_heatmap_3 = "fecha_creación: corresponda con el mes o \
  los meses y, el año de análisis",
  replicar_c5_heatmap_4 = "codigo_cierre: sea (A) La unidad de \
  atención a emergencias fue despachada, llegó al lugar de los hechos y \
  confirmó la emergencia reportada o (I) El incidente reportado es \
  afirmativo y se añade información adicional al evento",
  replicar_c5_heatmap_5 = "Incidente_c4: corresponda con las categorías \
  correspondientes",
  replicar_c5_heatmap_6 = "Para la hora de ocurrencia del hecho de \
  tránsito, tomamos en cuenta el campo hora_creación",
  
  ### =============== SSC Replicar ================================
  ### SSC Sin Lesionados
  hechos_transito_scc = "Son todos aquellos registros que cumplen con \
  las siguientes condiciones",
  replicar_scc_hechos_transito_1 = "Tomar en cuenta todos los hechos de \
  tránsito, sin importar si la longitud y latitud (coordenada) corresponde \
  con las de la CDMX (es posible que existan errores en las coordenadas)",
  replicar_scc_hechos_transito_2 = "AÑO_EVENTO: corresponda con el año de \
  análisis",
  replicar_scc_hechos_transito_3 = "MES_EVENTO: corresponda con el mes o \
  los meses de análisis",
  replicar_scc_hechos_transito_4 = "Campo TOTAL OCCISOS igual a cero y \
  campo TOTAL LESIONADOS igual a cero",
  hechos_decesos_scc = "Son todos aquellos registros que cumplen con las \
  siguientes condiciones",
  ### SSC Decesos
  replicar_scc_eventos_decesos_1 = "Tomar en cuenta todos los hechos de \
  tránsito, sin importar si la longitud y latitud corresponde con las de \
  la CDMX (es posible que existan errores en las coordenadas)",
  replicar_scc_eventos_decesos_2 = "AÑO_EVENTO: corresponda con el \
  año de análisis",
  replicar_scc_eventos_decesos_3 = "MES_EVENTO: corresponda con el \
  mes o los meses de análisis",
  replicar_scc_eventos_decesos_4 = "Campo TOTAL OCCISOS distinto de cero",
  ### SSC Lesionados
  hechos_lesionados_scc = "Son todos aquellos registros que cumplen \
  con las siguientes condiciones:",
  replicar_scc_personas_lesionadas_1 = "Tomar en cuenta todos los hechos \
  de tránsito, sin importar si la longitud y latitud (coordenada) \
  corresponde con las de la CDMX (es posible que existan errores en \
  las coordenadas)",
  replicar_scc_personas_lesionadas_2 = "AÑO_EVENTO: corresponda con el \
  año de análisis",
  replicar_scc_personas_lesionadas_3 = "MES_EVENTO: corresponda con el \
  mes o los meses de análisis",
  replicar_scc_personas_lesionadas_4 = "Campo TOTAL LESIONADOS distinto \
  de cero",
  ### SSC Heatmap
  heatmap_ssc_día_hora = "Son todos aquellos registros que cumplen con \
  las siguientes condiciones:",
  replicar_scc_heatmap_1 = "Tomar en cuenta todos los hechos de \
  tránsito, sin importar si la longitud y latitud (coordenada) \
  corresponde con las de la CDMX (es posible que existan errores en \
  las coordenadas)",
  replicar_scc_heatmap_2 = "AÑO_EVENTO: corresponda con el año de \
  análisis",
  replicar_scc_heatmap_3 = "MES_EVENTO: corresponda con el mes o \
  los meses de análisis",
  replicar_scc_heatmap_4 = "Para la hora de ocurrencia del hecho de \
  tránsito tomar en cuenta el campo HORA2"
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
mod_infoBdUI_ui <- function(id) {
  ns <- NS(id)
  tagList(
    fluidRow(
      column(
        6,
        actionButton(
          inputId = ns("boton_ver_visualizador"),
          label = "Regresar a Visualizador",
          icon = icon("globe-americas"),
          style = "background-color: #00AA5A; color: white; border-color: ; font-size: 12pt;"
        )
      )
    ),
    tags$div(style = "height: 20px;"),
    shinydashboard::box(
      width = 12,
      #tags$div(
      #  style = "text-align: justify; font-size: 12pt; color: #697070;",
      #  tags$p(strong("Bases de Datos"),
      #    style = "font-size: 18pt; color: #848888; text-align: left;"
      #  ),
      #  tags$p(lista_textos$bases_de_datos)
      #),
      tabsetPanel(
        tabPanel(
          title = "Introduccion",
          fluidRow(
            column(
              12,
              tags$div(style = "height: 15px;"),
              tags$div(
                style = "font-size: 18pt; color: #848888; text-align: center;",
                tags$p(
                  strong("Detalle de las bases de datos de hechos de tránsito")
                )
              ),
              tags$div(
                style = "text-align: justify; font-size: 12pt; color: #697070;",
                tags$p(lista_textos$bases_de_datos_fix_1_0,
                        strong(lista_textos$bases_de_datos_fix_1_1),
                        lista_textos$bases_de_datos_fix_1_2,
                        strong(lista_textos$bases_de_datos_fix_1_3),
                        lista_textos$bases_de_datos_fix_1_4
                      ),


                tags$p(lista_textos$bases_de_datos_fix_2),
                tags$p(lista_textos$bases_de_datos_fix_3),
                tags$p(lista_textos$bases_de_datos_fix_4),
                tags$p(lista_textos$bases_de_datos_fix_5)
              ),
              tags$footer(lista_textos$bases_de_datos_pie_1,
                      align = "right",
                      style = "bottom:0;
                              font-size: 5pt
                              height:8px; /* Height of the footer */
                              color: #697070;
                              padding: 15px;
                              background-color: #fff;"
              ),
              tags$footer(lista_textos$bases_de_datos_pie_2,
                      align = "right",
                      style = "bottom:0;
                              font-size: 5pt
                              height:8px; /* Height of the footer */
                              color: #697070;
                              padding: 15px;
                              background-color: #fff;"
              )
            ),
          )
        ),
        tabPanel(
          title = "FGJ",
          fluidRow(
            column(
              6,
              tags$div(style = "height: 15px;"),
              tags$div(
                style = "font-size: 18pt; color: #848888; text-align: left;",
                tags$p(
                  tags$img(
                    src = "www/fgj.png",
                    style = "height: 85px; float: right;"
                  ),
                  strong("Fiscalía General de Justicia (FGJ)")
                )
              ),
              tags$div(style = "height: 15px;"),
              tags$p(
                strong("Objetivo de la Base de Datos"),
                style = "font-size: 14pt; color: #848888; text-align: left;"
              ),
              tags$div(
                style = "text-align: justify; font-size: 12pt; color: #697070;",
                tags$ul(
                  tags$li(lista_textos$objetivo_base_datos_FGJ_1),
                  tags$li(lista_textos$objetivo_base_datos_FGJ_2),
                  tags$li(lista_textos$objetivo_base_datos_FGJ_3)
                ),
                tags$p(
                  style = "font-size: 10pt;",
                  strong("Referencia"),
                  " – ",
                  tags$a(
                    "Ley Orgánica de la Procuraduría General de Justicia del Distrito Federal",
                    href = "http://data.consejeria.cdmx.gob.mx/images/leyes/leyes/LEY_ORGANICA_DE_LA_PROCURADURIA_GRAL_DE_JUSTICIA_DEL_DF_1.pdf"
                  ),
                ),
                tags$p(
                    style = "font-size: 10pt;",
                    strong("Fuente"),
                    " – ",
                    tags$a(
                      "Datos Abiertos de la CDMX",
                      href = "https://datos.cdmx.gob.mx/dataset/victimas-en-carpetas-de-investigacion-fgj"
                    ),
                ),
                tags$p(
                    style = "font-size: 10pt;",
                    strong("Diccionario de datos"),
                    " – ",
                    tags$a(
                      "Diccionario de datos de Víctimas en Carpetas de Investigación",
                      href = "https://datos.cdmx.gob.mx/dataset/victimas-en-carpetas-de-investigacion-fgj/resource/10235569-f4a9-4876-9465-9780887df8e2"
                    ),
                )
              ),
              tags$div(style = "height: 15px;"),
              tags$p(strong("Replicar estos resultados"),
                style = "font-size: 14pt; color: #848888; text-align: left;"
              ),
              tags$p(
                style = "font-size: 12pt; color: #848888; text-align: left;",
                strong("Base de referencia"),
                " : ",
                "Toma como referencia la base de FGJ"
              ),
              tags$p(
                style = "font-size: 12pt; color: #848888; text-align: left;",
                strong("Hechos de tránsito sin victimas"),
                " : ",
                lista_textos$hechos_sin_lesionadas_FGJ,
                tags$div(
                  style = "text-align: justify; font-size: 12pt; color: #697070;",
                  tags$ul(
                    tags$li(lista_textos$replicar_sin_lesionadas_FGJ_1),
                    tags$li(lista_textos$replicar_sin_lesionadas_FGJ_2),
                    tags$li(lista_textos$replicar_sin_lesionadas_FGJ_3),
                    tags$li(lista_textos$replicar_sin_lesionadas_FGJ_4),
                    tags$li(
                      lista_textos$replicar_sin_lesionadas_FGJ_5,
                      tags$ul(
                        tags$li(lista_textos$categoria_FGJ_sin_lesionados_a),
                        tags$li(lista_textos$categoria_FGJ_sin_lesionados_b),
                        tags$li(lista_textos$categoria_FGJ_sin_lesionados_c)
                      )
                    ),
                    tags$li(lista_textos$replicar_sin_lesionadas_FGJ_6)
                  )
                )
              ),
              tags$div(style = "height: 15px;")
            ),
            column(
              6,
              tags$div(style = "height: 15px;"),
              tags$p(
                style = "font-size: 12pt; color: #848888; text-align: left;",
                strong("Hechos de tránsito con decesos"),
                " : ",
                lista_textos$hechos_decesos_FGJ,
                tags$div(
                  style = "text-align: justify; font-size: 12pt; color: #697070;",
                  tags$ul(
                    tags$li(lista_textos$replicar_decesos_FGJ_1),
                    tags$li(lista_textos$replicar_decesos_FGJ_2),
                    tags$li(lista_textos$replicar_decesos_FGJ_3),
                    tags$li(
                      lista_textos$replicar_decesos_FGJ_4,
                      tags$ul(
                        tags$li(lista_textos$categoria_FGJ_decesos_a),
                        tags$li(lista_textos$categoria_FGJ_decesos_b),
                        tags$li(lista_textos$categoria_FGJ_decesos_c),
                        tags$li(lista_textos$categoria_FGJ_decesos_d),
                        tags$li(lista_textos$categoria_FGJ_decesos_f),
                        tags$li(lista_textos$categoria_FGJ_decesos_g),
                        tags$li(lista_textos$categoria_FGJ_decesos_h),
                        tags$li(lista_textos$categoria_FGJ_decesos_i)
                      )
                    ),
                    tags$li(lista_textos$replicar_decesos_FGJ_5)
                  )
                )
              ),
              tags$p(
                style = "font-size: 12pt; color: #848888; text-align: left;",
                strong("Hechos de tránsito con lesionados"),
                " : ",
                lista_textos$hechos_lesionados_FGJ,
                tags$div(
                  style = "text-align: justify; font-size: 12pt; color: #697070;",
                  tags$ul(
                    tags$li(lista_textos$replicar_lesionados_FGJ_1),
                    tags$li(lista_textos$replicar_lesionados_FGJ_2),
                    tags$li(lista_textos$replicar_lesionados_FGJ_3),
                    tags$li(
                      lista_textos$replicar_lesionados_FGJ_4,
                      tags$ul(
                        tags$li(lista_textos$categoria_FGJ_lesionados_a),
                        tags$li(lista_textos$categoria_FGJ_lesionados_b)                        
                      )
                    ),
                    tags$li(lista_textos$replicar_lesionados_FGJ_5)
                  )
                )
              ),
              tags$p(
                style = "font-size: 12pt; color: #848888; text-align: left;",
                strong("Ocurrencia de hechos de tránsito dia y hora"),
                " : ",
                lista_textos$heatmap_FGJ_día_hora,
                tags$div(
                  style = "text-align: justify; font-size: 12pt; color: #697070;",
                  tags$ul(
                    tags$li(lista_textos$replicar_FGJ_heatmap_1),
                    tags$li(lista_textos$replicar_FGJ_heatmap_2),
                    tags$li(lista_textos$replicar_FGJ_heatmap_3),
                    tags$li(lista_textos$replicar_FGJ_heatmap_4),
                    tags$li(lista_textos$replicar_FGJ_heatmap_5),
                    tags$li(lista_textos$replicar_FGJ_heatmap_6)
                  )
                )
              )
              # =====
            )
          )
        ),
        # ==================SSC=================================
        tabPanel(
          title = "SSC",
          fluidRow(
            column(
              6,
              tags$div(style = "height: 15px;"),
              tags$div(
                style = "font-size: 18pt; color: #848888; text-align: left;",
                tags$p(
                  tags$img(
                    src = "www/ssc.png",
                    style = "height: 85px; float: right;"
                  ),
                  strong("Secretaría de Seguridad Ciudadana (SSC)")
                )
              ),
              tags$div(style = "height: 15px;"),
              tags$p(strong("Objetivo de la Base de Datos"),
                style = "font-size: 14pt; color: #848888; text-align: left;"
              ),
              tags$div(
                style = "text-align: justify; font-size: 12pt; color: #697070;",
                tags$ul(
                  tags$li(lista_textos$objetivo_base_datos_SSC_1),
                  tags$li(lista_textos$objetivo_base_datos_SSC_2),
                  tags$li(lista_textos$objetivo_base_datos_SSC_3)
                ),
                tags$p(
                  style = "font-size: 10pt;",
                  strong("Referencia"),
                  " – ",
                  tags$a(
                    "Ley Orgánica de la Secretaría de Seguridad Pública del Distrito Federal",
                    href = "http://data.consejeria.cdmx.gob.mx/images/leyes/leyes/LEY_ORGANICA_DE_LA_SECRETARIA_DE_SEGURIDAD_PUBLICA_DEL_DF_1.pdf"
                  )
                ),
                tags$p(
                  style = "font-size: 10pt;",
                  strong("Fuente"),
                  " – ",
                  tags$a(
                    tags$a("Datos Abiertos de la CDMX",
                      href = "https://datos.cdmx.gob.mx/dataset/hechos-de-transito-reportados-por-ssc-base-ampliada-no-comparativa"
                    )
                  )
                ),
                tags$p(
                  style = "font-size: 10pt;",
                  strong("Diccionario de datos"),
                  " – ",
                  tags$a(
                    tags$a("Diccionario de hechos de tránsito",
                      href = "https://datos.cdmx.gob.mx/dataset/hechos-de-transito-reportados-por-ssc-base-ampliada-no-comparativa/resource/3ea0519c-9690-4cfa-ab46-b84dccba5886"
                    )
                  )
                ),
              ),
              tags$div(style = "height: 15px;"),
              tags$p(strong("Replicar estos resultados"),
                style = "font-size: 14pt; color: #848888; text-align: left;"
              ),
              tags$p(lista_textos$replicar_resultados_ssc_intro,
                style = "font-size: 12pt; color: #848888; text-align: left;"
              ),
              tags$p(
                style = "font-size: 12pt; color: #848888; text-align: left;",
                strong("Hechos de tránsito con decesos:"),
                lista_textos$hechos_decesos_scc,
                tags$div(
                  style = "text-align: justify; font-size: 12pt; color: #697070;",
                  tags$ul(
                    tags$li(lista_textos$replicar_scc_eventos_decesos_1),
                    tags$li(lista_textos$replicar_scc_eventos_decesos_2),
                    tags$li(lista_textos$replicar_scc_eventos_decesos_3),
                    tags$li(lista_textos$replicar_scc_eventos_decesos_4)
                  )
                )
              ),
            ),
            column(
              6,
              tags$div(style = "height: 15px;"),
              tags$p(
                style = "font-size: 12pt; color: #848888; text-align: left;",
                strong("Ocurrencia de hechos de tránsito dia y hora:"),
                lista_textos$heatmap_ssc_día_hora,
                tags$div(
                  style = "text-align: justify; font-size: 12pt; color: #697070;",
                  tags$ul(
                    tags$li(lista_textos$replicar_scc_heatmap_1),
                    tags$li(lista_textos$replicar_scc_heatmap_2),
                    tags$li(lista_textos$replicar_scc_heatmap_3),
                    tags$li(lista_textos$replicar_scc_heatmap_4)
                  )
                )
              ),
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
                  tags$img(
                    src = "www/c5.png",
                    style = "height: 85px; float: right;"
                  ),
                  strong("Centro de Comando, Control, Cómputo, Comunicaciones y Contacto Ciudadano de la Ciudad de México (C5)")
                )
              ),
              tags$div(style = "height: 15px;"),
              tags$p(strong("Objetivo de la Base de Datos"),
                style = "font-size: 14pt; color: #848888; text-align: left;"
              ),
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
                  strong("Referencia"),
                  " – ",
                  tags$a("Manual Administrativo del C5",
                    href = "https://www.c5.cdmx.gob.mx/storage/app/uploads/public/5be/b2e/318/5beb2e31874de742733714.pdf"
                  )
                ),
                tags$p(
                  style = "font-size: 10pt;",
                  strong("Fuente"),
                  " – ",
                  tags$a(
                    "Datos Abiertos de la CDMX",
                    href = "https://datos.cdmx.gob.mx/dataset/incidentes-viales-c5"
                  )
                ),
                tags$p(
                  style = "font-size: 10pt;",
                  strong("Diccionario de datos"),
                  " – ",
                  tags$a(
                    "Diccionario de datos de incidentes viales",
                    href = "https://datos.cdmx.gob.mx/dataset/incidentes-viales-c5/resource/49b5360c-5922-46bd-b4f8-ed0225d5ddbf"
                  )
                ),
              ),
              #Aqui va el texto para reproducir los datos
              tags$div(style = "height: 15px;"),
              tags$p(strong("Replicar estos resultados"),
                style = "font-size: 14pt; color: #848888; text-align: left;"
              ),
              tags$p(
                style = "font-size: 12pt; color: #848888; text-align: left;",
                strong("Base de referencia"),
                " : ",
                "Toma como referencia la base de ",
                "Incidentes viales reportados por C5"
                #tag$a("Incidentes viales reportados por C5",
                #  href = "https://datos.cdmx.gob.mx/explore/dataset/incidentes-viales-c5/table/?disjunctive.incidente_c4"
                #)
              ),
              tags$p(
                style = "font-size: 12pt; color: #848888; text-align: left;",
                strong("Hechos de tránsito sin victimas: "),
                " : ",
                lista_textos$hechos_sin_lesionadas_c5,
                tags$div(
                  style = "text-align: justify; font-size: 12pt; color: #697070;",
                  tags$ul(
                    tags$li(lista_textos$replicar_sin_lesionadas_c5_1 ),
                    tags$li(lista_textos$replicar_sin_lesionadas_c5_2 ),
                    tags$li(lista_textos$replicar_sin_lesionadas_c5_3 ),
                    tags$li(lista_textos$replicar_sin_lesionadas_c5_4 ),
                    tags$li(
                      lista_textos$replicar_sin_lesionadas_c5_5,
                      tags$ul(
                        tags$li(lista_textos$categorias_c5_a),
                        tags$li(lista_textos$categorias_c5_b),
                        tags$li(lista_textos$categorias_c5_c),
                        tags$li(lista_textos$categorias_c5_d),
                        tags$li(lista_textos$categorias_c5_e),
                        tags$li(lista_textos$categorias_c5_f),
                        tags$li(lista_textos$categorias_c5_g),
                        tags$li(lista_textos$categorias_c5_h),
                        tags$li(lista_textos$categorias_c5_i),
                        tags$li(lista_textos$categorias_c5_j),
                        tags$li(lista_textos$categorias_c5_k),
                        tags$li(lista_textos$categorias_c5_l),
                        tags$li(lista_textos$categorias_c5_m)
                      )
                    )
                  )
                ),
              ),
            ),
            column(
              6,
              tags$div(style = "height: 15px;"),
              tags$p(
                style = "font-size: 12pt; color: #848888; text-align: left;",
                strong("Hechos de tránsito con decesos"),
                " : ",
                lista_textos$hechos_decesos_c5,
                tags$div(
                  style = "text-align: justify; font-size: 12pt; color: #697070;",
                  tags$ul(
                    tags$li(lista_textos$replicar_decesos_c5_1),
                    tags$li(lista_textos$replicar_decesos_c5_2),
                    tags$li(lista_textos$replicar_decesos_c5_3),
                    tags$li(lista_textos$replicar_decesos_c5_4)
                  )
                ),
              ),
              tags$p(
                style = "font-size: 12pt; color: #848888; text-align: left;",
                strong("Hechos de tránsito con lesionados"),
                " : ",
                lista_textos$hechos_lesionados_c5,
                tags$div(
                  style = "text-align: justify; font-size: 12pt; color: #697070;",
                  tags$ul(
                    tags$li(lista_textos$replicar_lesionados_c5_1),
                    tags$li(lista_textos$replicar_lesionados_c5_2),
                    tags$li(lista_textos$replicar_lesionados_c5_3),
                    tags$li(lista_textos$replicar_lesionados_c5_4)
                  )
                ),
              ),
              tags$p(
                style = "font-size: 12pt; color: #848888; text-align: left;",
                strong("Ocurrencia de hechos de tránsito dia y hora"),
                " : ",
                lista_textos$hechos_lesionados_c5,
                tags$div(
                  style = "text-align: justify; font-size: 12pt; color: #697070;",
                  tags$ul(
                    tags$li(lista_textos$replicar_c5_heatmap_1),
                    tags$li(lista_textos$replicar_c5_heatmap_2),
                    tags$li(lista_textos$replicar_c5_heatmap_3),
                    tags$li(lista_textos$replicar_c5_heatmap_4),
                    tags$li(lista_textos$replicar_c5_heatmap_5),
                    tags$li(lista_textos$replicar_c5_heatmap_6)
                  )
                ),
              ),

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
                  tags$img(
                    src = "www/axa.png",
                    style = "height: 85px; float: right;"
                  ),
                  strong("AXA México")
                )
              ),
              tags$div(style = "height: 15px;"),
              tags$p(
                strong("Objetivo de la Base de Datos"),
                style = "font-size: 14pt; color: #848888; text-align: left;"
              ),
              tags$div(
                style = "text-align: justify; font-size: 12pt; color: #697070;",
                tags$ul(
                  tags$li(lista_textos$objetivo_base_datos_AXA_1),
                  tags$li(lista_textos$objetivo_base_datos_AXA_2),
                  tags$li(lista_textos$objetivo_base_datos_AXA_3),
                  tags$li(lista_textos$objetivo_base_datos_AXA_4)
                )
              ),
              tags$p(
                style = "font-size: 10pt;",
                strong("Fuente"),
                " – ",
                tags$a("Instituto Internacional de Ciencia de Datos",
                    href = "https://i2ds.org/datos-abiertos/"
                )
              ),
              tags$p(
                style = "font-size: 10pt;",
                strong("Diccionario de datos"),
                " – ",
                tags$a("Diccionario de percances viales AXA Seguros",
                    href = "https://files.i2ds.org/OpenDataAxaMx/diccionario-percances-viales-axa-1.xlsx"
                )
              ),
              tags$div(style = "height: 15px;"),
              tags$p(strong("Replicar estos resultados"),
                style = "font-size: 14pt; color: #848888; text-align: left;"
              ),
              tags$p(
                style = "font-size: 12pt; color: #848888; text-align: left;",
                strong("Base de referencia"),
                " : ",
                "Toma como referencia la base de AXA Seguros (AXA)"
              ),
              tags$p(
                style = "font-size: 12pt; color: #848888; text-align: left;",
                strong("Hechos de tránsito sin victimas"),
                " : ",
                lista_textos$personas_sin_lesionadas_AXA,
                tags$div(
                  style = "text-align: justify; font-size: 12pt; color: #697070;",
                  tags$ul(
                    tags$li(lista_textos$replicar_sin_lesionadas_AXA_1),
                    tags$li(lista_textos$replicar_sin_lesionadas_AXA_2),
                    tags$li(lista_textos$replicar_sin_lesionadas_AXA_3),
                    tags$li(lista_textos$replicar_sin_lesionadas_AXA_4)
                  )
                )
              ),
              tags$p(
                style = "font-size: 12pt; color: #848888; text-align: left;",
                strong("Hechos de tránsito con decesos"),
                " : ",
                lista_textos$hechos_decesos_AXA,
                tags$div(
                  style = "text-align: justify; font-size: 12pt; color: #697070;",
                  tags$ul(
                    tags$li(lista_textos$replicar_decesos_AXA_1),
                    tags$li(lista_textos$replicar_decesos_AXA_2),
                    tags$li(lista_textos$replicar_decesos_AXA_3)
                  )
                )
              ),
            ),
            column(
              6,
              tags$div(style = "height: 15px;"),
              tags$p(
                style = "font-size: 12pt; color: #848888; text-align: left;",
                strong("Hechos de tránsito con lesionados"),
                " : ",
                lista_textos$hechos_lesionados_AXA,
                tags$div(
                  style = "text-align: justify; font-size: 12pt; color: #697070;",
                  tags$ul(
                    tags$li(lista_textos$replicar_lesionados_AXA_1),
                    tags$li(lista_textos$replicar_lesionados_AXA_2),
                    tags$li(lista_textos$replicar_lesionados_AXA_3)
                  )
                )
              ),
              tags$p(
                style = "font-size: 12pt; color: #848888; text-align: left;",
                strong("Ocurrencia de hechos de tránsito dia y hora"),
                " : ",
                lista_textos$heatmap_AXA_día_hora,
                tags$div(
                  style = "text-align: justify; font-size: 12pt; color: #697070;",
                  tags$ul(
                    tags$li(lista_textos$replicar_AXA_heatmap_1),
                    tags$li(lista_textos$replicar_AXA_heatmap_2),
                    tags$li(lista_textos$replicar_AXA_heatmap_3),
                    tags$li(lista_textos$replicar_AXA_heatmap_4)
                  )
                )
              )
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