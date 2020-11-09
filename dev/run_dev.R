# Set options here
# TRUE = production mode, FALSE = development mode
options(golem.app.prod = FALSE)
options(shiny.maxRequestSize = 510 * 1024^2)
shinyOptions(cache = memoryCache(size = 20e7))

options("Actualizar_datos" = TRUE)
# Detach all loaded packages and clean your environment
golem::detach_all_attached()
rm(list=ls(all.names = TRUE))

# Document and reload your package
golem::document_and_reload()

# Run the application
run_app()