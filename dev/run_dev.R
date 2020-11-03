# Set options here
options(golem.app.prod = FALSE) # TRUE = production mode, FALSE = development mode
##options(shiny.maxRequestSize=150*1024^2)
########To set new upload file size
options(shiny.maxRequestSize=510*1024^2)

options( "Actualizar_datos" = FALSE)
# Detach all loaded packages and clean your environment
golem::detach_all_attached()
# rm(list=ls(all.names = TRUE))

# Document and reload your package
golem::document_and_reload()

# Run the application
run_app()