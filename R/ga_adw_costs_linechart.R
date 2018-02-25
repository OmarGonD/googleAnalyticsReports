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

ga_adw_cost_linechart <- function(data, title, x_title = "fecha", y_title = "inversión",
                                  label_size = 3, by_adnetwork = F) {

  data$date <- as.Date(data$date)

  if(by_adnetwork) {

    data_line <- curacao_inversion_adwords %>%
      group_by(date, adNetwork) %>%
      summarise(adCost = sum(adCost))


    adw_cost_line_chart <- ggplot(data_line, aes(date, adCost)) +
      geom_line(aes(colour = adNetwork)) +
      scale_colour_manual(values=c(`Google Display` = "#1a8cff", `Google Search` = "red")) +
      theme_ipsum() +
      labs(title = title, x = x_title, y = y_title) +
      expand_limits(y = max(data_line$adCost) + round(max(data_line$adCost)*70/100)) +
      scale_y_continuous(labels = comma)


  } else {



    data_line <- curacao_inversion_adwords %>%
                 group_by(date) %>%
                 summarise(adCost = sum(adCost))


    adw_cost_line_chart <- ggplot(data_line, aes(x=date, y=adCost)) +
                           geom_line(color="#FFBB33") +
                           theme_ipsum() +
                           labs(title = title, x = x_title, y = y_title) +
                           expand_limits(y = max(data_line$adCost) + round(max(data_line$adCost)*70/100)) +
                           scale_y_continuous(labels = comma)


  }

  return(adw_cost_line_chart)

}
