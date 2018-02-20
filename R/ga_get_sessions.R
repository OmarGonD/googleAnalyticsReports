#' GA Monthly linechart graphic - sessions
#'
#' Cleans all source inputs from GA API.
#' @param data a data frame from GA API. It must contain the column: ga:sourceMedium,
#' as the package works with this column to generate the ouputs.
#' @param language Choose a language for your sources column outputs.
#' Available languages: en, es, fr. More to add in the near future.
#' @importFrom tidyr separate
#' @import ggplot2
#' @import hrbrthemes
#' @import scales
#' @import viridis
#' @import ggthemes
#' @importFrom dplyr group_by summarise
#' @importFrom forcats fct_reorder
#' @importFrom magrittr %>%
#' @examples ga_clean_data(my_data, language="es")
#' @return The function returns the data frame with a new sources column with correct output ready to plot.
#' @export



ga_get_sessions <- function(view_id, start_date = "2017-01-01",
                            final_date = "2018-01-31") {


  ga_auth()

  data <- google_analytics_4(my_id,
                           date_range = c(start_date, final_date),
                           metrics = "sessions",
                           dimensions = c("date", "hour", "deviceCategory", "sourceMedium"),
                           anti_sample = TRUE)


  data <- googleAnalyticsReports::ga_clean_data_sessions(data)

  return(data)

}
