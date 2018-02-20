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
#' @return Top pagevies by source. Will include more than n rows if there are ties.
#' @export


ga_pageviews_barchart_top_n <- function(data, top_n = 6, title = "Pageviews by source", x_title = "", y_title = "",
                                             subtitle = '', legend_title = "",
                                             label_size = 3) {


  ga_data_top_n <- data %>%
    group_by(sources, pagePath) %>%
    summarise(pageviews = sum(pageviews)) %>%
    arrange(-pageviews) %>%
    top_n(top_n)
    # %>%
    # mutate(pagePath = factor(pagePath,
    #                          levels = rev(pagePath)))


  gg <- ggplot(ga_data_top_n, mapping = aes(x = pagePath, y = pageviews,
                                     fill = sources, label = pageviews)) +
    geom_bar(stat = "identity") +
    coord_flip() +
    facet_wrap(~ sources) +
    theme_ipsum() +
    scale_fill_ipsum() +
    labs(title = title,
         subtitle = subtitle) +
    theme(axis.ticks.y = element_blank(),
          legend.position="none") +
    geom_text(hjust = -0.4, size = 3) +
    expand_limits(y = max(ga_data_top_n$pageviews) + round(max(ga_data_top_n$pageviews)*70/100))

    return(gg)

}
