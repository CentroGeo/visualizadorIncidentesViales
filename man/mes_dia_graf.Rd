% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mod_graficas.R
\name{mes_dia_graf}
\alias{mes_dia_graf}
\title{Graficas Mes Dia Function}
\usage{
mes_dia_graf(dataframe_rec_in, input)
}
\arguments{
\item{dataframe_rec_in}{The reactive function that returns a dataframe}

\item{input}{shiny parameter where the inputs from the UI are store
and the month or day graph is selected}
}
\value{
The render plot selected in the UI
}
\description{
Generates the graph of the "Incidentes viales" by month or daily
}
