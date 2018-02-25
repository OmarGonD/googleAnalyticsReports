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



ga_get_adw_costs_by_campaign <- function(view_id, start_date,
                                        final_date, language = "en") {


  ga_auth()



  data <- google_analytics(view_id,
                           date_range = c(start_date, final_date),
                           metrics = c("adCost"),
                           dimensions = c("date", "adDistributionNetwork",
                                          "sourceMedium", "campaign", "adGroup"),
                           anti_sample = TRUE)


  #We use ga_clean_data_sessions because of the "sourceMedium" dimension
  data <- googleAnalyticsReports::ga_clean_data_sessions(data, language)


  data$campaign <- gsub("LA CURACAO - ", "", data$campaign)

  data$campaign <- gsub(" DSA - SEARCH -", "", data$campaign)

  data$campaign <- gsub("SEARCH -", "", data$campaign)

  data$campaign <- gsub("SEARCH -", "", data$campaign)

  data$campaign <- gsub("- SEARCH", "", data$campaign)

  data$campaign <- gsub("LaCuracao - GDN -", "", data$campaign)


  data$campaign <- gsub("DISPLAY -", "", data$campaign)

  data$campaign <- gsub("Brand/EM -", "", data$campaign)

  data$campaign <- gsub("LaCuracao - Search - ", "", data$campaign)

  data$campaign <- trimws(data$campaign, which = 'both')

  ## Cleaning adNetWorks

  data$adNetwork <- ifelse(grepl("Google Search|Search partners",
                                 data$adDistributionNetwork), "Google Search", data$adDistributionNetwork)


  data$adNetwork <- ifelse(grepl("Content",
                                 data$adDistributionNetwork), "Google Display", data$adNetwork)




  message("#=========================================#")
  message("Returns Adwords data (as metric is adCost)")
  message(paste("Sources of data:",unique(data$sources)))
  message("#=========================================#")

  return(data)

}
