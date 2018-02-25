#' Cleans GA Data
#'
#' Cleans all source inputs from GA API.
#' @param data a data frame from GA API. It must contain the column: ga:sourceMedium,
#' as the package works with this column to generate the ouputs.
#' @param language Choose a language for your sources column outputs.
#' Available languages: en, es, fr. More to add in the near future.
#' @import dplyr
#' @importFrom tidyr separate
#' @importFrom magrittr %>%
#' @examples ga_clean_data(my_data, language="es")
#' @return The function returns the data frame with a new sources column with correct output ready to plot.
#' @export

ga_clean_data_adnetwork <- function(data) {


  data$adNetwork <- ifelse(grepl("Google Search|Search partners",
                                 data$adDistributionNetwork), "Google Search", data$adDistributionNetwork)



  data$adNetwork <- ifelse(grepl("Content",
                                 data$adDistributionNetwork), "Google Display", data$adNetwork)


  return(data)

}

