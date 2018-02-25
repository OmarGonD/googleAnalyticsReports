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





ga_lineschart_sessions_by_device <- function(view_id, title = "Weekday sessions by hour", x_title = "hour", y_title = "",
                                      legend_title = "sessions", start_date = "2017-01-01",end_date = "2018-01-31",
                                      label_size = 3) {


  gar_auth()

  data <- google_analytics(viewId = view_id,
                                date_range = c(start_date, end_date),
                                metrics = "sessions",
                                dimensions = c("date","deviceCategory"),
                                anti_sample = TRUE)


  gg <- ggplot(data, mapping = aes(x = date, y = sessions, colour = deviceCategory)) +
    geom_line() +
    theme_ipsum()

  return(gg)

}
