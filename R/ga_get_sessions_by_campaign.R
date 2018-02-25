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



ga_get_sessions_by_campaign <- function(view_id, start_date,
                            final_date, device_category = F, language = "en") {


  ga_auth()

  if(device_category) {

      message("#===================#")
      message("Returns data with only sessions, but also hour and deviceCategory")
      message("#===================#")

      data <- google_analytics(view_id,
                                 date_range = c(start_date, final_date),
                                 metrics = c("sessions"),
                                 dimensions = c("date","hour", "deviceCategory",
                                                "sourceMedium", "campaign", "adGroup"),
                                 anti_sample = TRUE)


  } else {

      message("#===================#")
      message("Returns data with not only sessions but impressions and adClicks")
      message("#===================#")

      data <- google_analytics(view_id,
                              date_range = c(start_date, final_date),
                              metrics = c("impressions", "adClicks","sessions"),
                              dimensions = c("date", "sourceMedium","adDistributionNetwork",
                                             "campaign", "adGroup", "adDisplayUrl", "adDestinationUrl",
                                             "adMatchedQuery", "adKeywordMatchType"),
                              anti_sample = TRUE)

  }


  data <- googleAnalyticsReports::ga_clean_data_sessions(data, language)

  data <- googleAnalyticsReports::ga_clean_data_sessions_adnetwork(data)

  return(data)

}
