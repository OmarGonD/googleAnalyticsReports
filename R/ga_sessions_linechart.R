#' GA Monthly sessions graphic
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
#' @importFrom dplyr group_by summarise
#' @importFrom forcats fct_reorder
#' @importFrom magrittr %>%
#' @examples ga_clean_data(my_data, language="es")
#' @return The function returns the data frame with a new sources column with correct output ready to plot.
#' @export

ga_sessions_linechart <- function(data, title = "Sessions by source - evolution by source", x_title = "date", y_title = "sessions",
                                    label_size = 3) {

  data$date <- as.Date(data$date)

  data_line <- data %>%
    group_by(date, sources) %>%
    summarise(sessions = sum(sessions))


  data_line_chart <- ggplot(data_line, aes(date, sessions, color=sources)) +
                     geom_line() +
                     theme_ipsum() +
                     scale_color_ipsum() +
                     labs(title = title, x = x_title, y = y_title)


  return(data_line_chart)

}
