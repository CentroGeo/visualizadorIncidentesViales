
app_server <- function( input, output, session ) {
  # List the first level callModules here
  callModule(mod_mapa_server, "mapa_ui_1")
  #data_out<- callModule(mod_DBSelector_server, "DBSelector_ui_1")
  # print(data_out) 
  # print(data_out[[1]]())
   #output$tabla_FGJ <- DT::renderDataTable({data_out[[1]]()})
   #output$tabla_SSC <- DT::renderDataTable({data_out[[2]]()})
   #output$tabla_AXA <- DT::renderDataTable({data_out[[3]]()})
  # 
  inter_bar_call <- callModule(mod_bar_server, "bar_ui_1")
  data_out<- callModule(mod_DBSelector_server, "DBSelector_ui_1", inter_bar_call)
  # print(head(data_out()))
  
  output$tabla_todos <- DT::renderDataTable({data_out()})
  
}
