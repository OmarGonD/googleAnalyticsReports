#' GA Monthly linechart graphic - sessions
#'
#' Cleans all source inputs from GA API.
#' @param data a data frame from GA API. It must contain the column: ga:sourceMedium,
#' as the package works with this column to generate the ouputs.
#' @param language Choose a language for your sources column outputs.
#' Available languages: en, es, fr. More to add in the near future.
#' @importFrom dplyr group_by summarise
#' @importFrom googleAnalyticsR google_analytics
#' @examples ga_get_pageviews(view_id = 123456789, start_date = "2018-01-01", final_date = "2018-01-31")
#' @return The function returns the data frame with a new sources column with correct output ready to plot.
#' @export




ga_get_pageviews <- function(view_id, start_date = start_date,
                             final_date = final_date) {


  gar_auth()

  data <- google_analytics(view_id,
                               date_range = c(start_date, final_date),
                               metrics = "pageviews",
                               dimensions = c("date", "hour", "deviceCategory", "sourceMedium", "pagePath"),
                               anti_sample = TRUE)


  data <- googleAnalyticsReports::ga_clean_data_pageviews(data)

  return(data)


}



