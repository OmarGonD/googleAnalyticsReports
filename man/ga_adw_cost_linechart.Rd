% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ga_adw_costs_linechart.R
\name{ga_adw_cost_linechart}
\alias{ga_adw_cost_linechart}
\title{GA Monthly sessions graphic}
\usage{
ga_adw_cost_linechart(data, title, x_title = "fecha",
  y_title = "inversión", label_size = 3, by_adnetwork = F)
}
\arguments{
\item{data}{a data frame from GA API. It must contain the column: ga:sourceMedium,
as the package works with this column to generate the ouputs.}

\item{language}{Choose a language for your sources column outputs.
Available languages: en, es, fr. More to add in the near future.}
}
\value{
The function returns the data frame with a new sources column with correct output ready to plot.
}
\description{
Cleans all source inputs from GA API.
}
\examples{
ga_clean_data(my_data, language="es")
}
