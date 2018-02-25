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

ga_adw_costs_per_month <- function(data, title, subtitle, x_title, y_title,
                                  label_size = 4, bars_fill = "#FFBB33") {



  # data$month <- factor(data$month, levels = c("nov", "dec"), ordered = T)

  data <- data %>%
          group_by(year, month) %>%
          summarise(adCost = sum(adCost))



  monthly_costs <- ggplot(data, aes(x=month, y = adCost, label = comma(adCost))) +
    geom_bar(stat = "identity", fill = bars_fill, colour = "white") +
    labs(title = title, subtitle = subtitle,
         x = x_title, y = y_title) +
    facet_wrap(~ year, scales = "free_y", ncol = 1) +
    #facet_grid(. ~ anio) +
    theme(axis.text.x = element_text(colour="grey20",size=18,hjust=.5,vjust=.5,face="plain"),
          axis.text.y = element_text(colour="grey20",size=18,hjust=1,vjust=0,face="plain"),
          axis.title.x = element_text(colour="grey20",size=12,angle=0,hjust=.5,vjust=0,face="plain"),
          axis.title.y = element_text(colour="grey20",size=12,angle=90,hjust=.5,vjust=.5,face="plain"),
          plot.title = element_text(face = "bold", vjust=2, size = 22),
          legend.title = element_text(colour="grey40", size=8, face="bold"),
          legend.text = element_text(colour="grey10", size=12, face="bold"),
          strip.text.x = element_text(size = 22,
                                      hjust = 0.5, vjust = 0.5)) +
    scale_y_continuous(labels = comma) +
    geom_text(vjust = -0.4, size = label_size) +
    expand_limits(y = max(data$adCost) + round(max(data$adCost)*50/100)) +
    theme_ipsum()

  return(monthly_costs)

}
