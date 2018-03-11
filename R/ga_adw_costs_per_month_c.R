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
#' @importFrom magrittr %>%
#' @examples ga_clean_data(my_data, language="es")
#' @return The function returns the data frame with a new sources column with correct output ready to plot.
#' @export

ga_adw_cost_per_month_c <- function(data, adnetwork_selected, title, subtitle, x_title, y_title,
                                    year_selected = 2018, bars_fill = "#FFBB33",
                                    label_size = 3, top_n = 5, y_axis_size = 16) {



  # data$month <- factor(data$month, levels = c("nov", "dec"), ordered = T)

  subtitle <- paste("Red publicitaria:", adnetwork_selected)



  data_top_n <- curacao_inversion_adwords %>%
    group_by(year, month, adNetwork, campaign) %>%
    summarise(adCost= sum(adCost)) %>%
    filter(adNetwork == adnetwork_selected) %>%
    filter(year == year_selected) %>%
    arrange(-adCost) %>%
    top_n(top_n)




  data_top_n$campaign <- fct_reorder(data_top_n$campaign, data_top_n$adCost)


  monthly_adw_cost_c <- ggplot(data_top_n, aes(x=campaign, y = adCost, label = comma(round(adCost, digits = 2)))) +
                        geom_bar(stat = "identity", fill = bars_fill, colour = "white") +
                        #facet_grid(month ~ adNetwork) +
                        facet_wrap(year ~ month, scales = "free_y", ncol = 1) +
                        labs(title = title, subtitle = subtitle,
                             x = x_title, y = y_title) +
                        scale_y_continuous(labels = comma) +
                        coord_flip() +
                        geom_text(hjust = -0.4, size = label_size) +
                        expand_limits(y = max(data_top_n$adCost) + round(max(data_top_n$adCost)*50/100)) +
                        theme_ipsum() +
                        theme(legend.position = 'none',
                              axis.text.y = element_text(colour="grey20",size=y_axis_size,hjust=1,vjust=0,face="plain"))



  return(monthly_adw_cost_c)



}
