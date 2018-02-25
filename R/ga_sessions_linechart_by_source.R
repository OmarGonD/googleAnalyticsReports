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

ga_sessions_linechart_by_source <- function(data, title, subtitle, x_title, y_title,
                                    source, sources_details = F) {






  if(sources_details) {




    data_source <- data %>%
      select(date, sessions, sources) %>%
      group_by(date, sources) %>%
      summarise(sessions = sum(sessions)) %>%
      filter(sources == source, !is.na(sessions))

    data_others <- data %>%
      select(date, sessions, sources) %>%
      filter(sources != source, !is.na(sessions)) %>%
      group_by(date, sources) %>%
      summarise(sessions = sum(sessions))


    linechart_sessions_by_source <- ggplot(data_others, aes(date, sessions, color = sources)) +
      geom_line(alpha = 0.6, linetype = "longdash") +
      geom_line(data = data_source, aes(date, sessions), colour="red", size = 0.8) +
      labs(title = title, subtitle = subtitle,
           x = x_title, y = y_title) +
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
      #geom_text(vjust = -0.4, size = label_size) +
      expand_limits(y = max(data$sessions) + round(max(data$sessions)*50/100)) +
      theme_ipsum()


    return(linechart_sessions_by_source)

  } else {



    if(source == "direct") {

      data_source <- data %>%
        select(date, sessions, sources) %>%
        group_by(date, sources) %>%
        summarise(sessions = sum(sessions)) %>%
        filter(sources == "direct", !is.na(sessions))

      data_others <- data %>%
        select(date, sessions, sources) %>%
        filter(sources != "direct", !is.na(sessions)) %>%
        group_by(date) %>%
        summarise(sessions = sum(sessions))

    } else if(source == "directo") {

      data_source <- data %>%
        select(date, sessions, sources) %>%
        group_by(date, sources) %>%
        summarise(sessions = sum(sessions)) %>%
        filter(sources == "directo", !is.na(sessions))

      data_others <- data %>%
        select(date, sessions, sources) %>%
        filter(sources != "directo", !is.na(sessions)) %>%
        group_by(date) %>%
        summarise(sessions = sum(sessions))

    } else if(source == "references") {

      data_source <- data %>%
        select(date, sessions, sources) %>%
        group_by(date, sources) %>%
        summarise(sessions = sum(sessions)) %>%
        filter(sources == "references", !is.na(sessions))

      data_others <- data %>%
        select(date, sessions, sources) %>%
        filter(sources != "references", !is.na(sessions)) %>%
        group_by(date) %>%
        summarise(sessions = sum(sessions))

    } else if(source == "referencias") {

      data_source <- data %>%
        select(date, sessions, sources) %>%
        group_by(date, sources) %>%
        summarise(sessions = sum(sessions)) %>%
        filter(sources == "referencias", !is.na(sessions))

      data_others <- data %>%
        select(date, sessions, sources) %>%
        filter(sources != "referencias", !is.na(sessions)) %>%
        group_by(date) %>%
        summarise(sessions = sum(sessions))


    } else if(source == "social media") {

      data_source <- data %>%
        select(date, sessions, sources) %>%
        group_by(date, sources) %>%
        summarise(sessions = sum(sessions)) %>%
        filter(sources == "social media", !is.na(sessions))

      data_others <- data %>%
        select(date, sessions, sources) %>%
        filter(sources != "social media", !is.na(sessions)) %>%
        group_by(date) %>%
        summarise(sessions = sum(sessions))

    } else if(source == "redes sociales") {

      data_source <- data %>%
        select(date, sessions, sources) %>%
        group_by(date, sources) %>%
        summarise(sessions = sum(sessions)) %>%
        filter(sources == "redes sociales", !is.na(sessions))

      data_others <- data %>%
        select(date, sessions, sources) %>%
        filter(sources != "redes sociales", !is.na(sessions)) %>%
        group_by(date) %>%
        summarise(sessions = sum(sessions))

    } else if(source == "organic") {

      data_source <- data %>%
        select(date, sessions, sources) %>%
        group_by(date, sources) %>%
        summarise(sessions = sum(sessions)) %>%
        filter(sources == "organic", !is.na(sessions))

      data_others <- data %>%
        select(date, sessions, sources) %>%
        filter(sources != "organic", !is.na(sessions)) %>%
        group_by(date) %>%
        summarise(sessions = sum(sessions))

    } else if(source == "organico") {

      data_source <- data %>%
          select(date, sessions, sources) %>%
          group_by(date, sources) %>%
          summarise(sessions = sum(sessions)) %>%
          filter(sources == "organico", !is.na(sessions))

        data_others <- data %>%
          select(date, sessions, sources) %>%
          filter(sources != "organico", !is.na(sessions)) %>%
          group_by(date) %>%
          summarise(sessions = sum(sessions))

    } else {

      data_source <- data %>%
        select(date, sessions, sources) %>%
        group_by(date, sources) %>%
        summarise(sessions = sum(sessions)) %>%
        filter(sources == source, !is.na(sessions))

      data_others <- data %>%
        select(date, sessions, sources) %>%
        filter(sources != source, !is.na(sessions)) %>%
        group_by(date) %>%
        summarise(sessions = sum(sessions))

    }


        linechart_sessions_by_source <- ggplot() +
                                        geom_line(data = data_source, aes(date, sessions), colour="red") +
                                        geom_line(data = data_others, aes(date, sessions), colour = "grey40") +
                                        labs(title = title,
                                             x = x_title, y = y_title) +
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
                                        #geom_text(vjust = -0.4, size = label_size) +
                                        expand_limits(y = max(data$sessions) + round(max(data$sessions)*50/100)) +
                                        theme_ipsum()

        return(linechart_sessions_by_source)

    }

}
