#' Cleans GA Data
#'
#' Cleans all source inputs from GA API.
#' @param data a data frame from GA API. It must contain the column: ga:sourceMedium,
#' as the package works with this column to generate the ouputs.
#' @param language Choose a language for your final_source column outputs.
#' Available languages: en, es, fr. More to add in the near future.
#' @importFrom tidyr separate
#' @importFrom magrittr %>%
#' @examples ga_clean_data(my_data, language="es")
#' @return The function returns the data frame with a new final_source column with correct output ready to plot.
#' @export

ga_clean_data <- function(data, language = "en") {

  data <- data %>%
    separate(sourceMedium, into = c("source", "medium"), sep = "\\/")


  data$medium <- as.character(data$medium)

  data$source <- as.character(data$source)

  data$sessions <- as.numeric(data$sessions)


  ### Remove white spaces adelante y detr?s


  data$medium <- trimws(data$medium, which = "both")

  data$source <- trimws(data$source, which = "both")


  data$fuente <- NA

  for (i in 1:nrow(data)) {


    ### PATH PARTS

    spam.path <- paste(c("site.*", ".*event.*", ".*free.*", ".*theguardlan.*",".*.\\org",
                         ".*guardlink.*", ".*torture.*", ".*forum.*", ".*buy.*",
                         ".*share.*", ".*buttons.*", ".*pyme\\.lavoztx\\.com\\.*",
                         ".*amezon.*", ".*porn.*", "quality", "trafficgenius\\.xyz",
                         "gametab\\.myplaycity\\.com", "login.*", "mega.*", "blog",
                         "[0-9]{3}\\.[0-9]{2}.*", ".*\\:.*", ".*\\.xyz", "online", "internet"),
                       collapse="|")



    adsense.path <- paste(c("tpc.googlesyndication.com",
                            "googleads[.]g[.]doubleclick[.]net"),
                          collapse="|")




    adwords.path <- paste(c("cpc", "search",
                            "ccp","google_display",
                            "cpm","cpv","youtube.*","video.*",
                            "google", "google_blast","(not set)"),
                          collapse="|")




    email.path <- paste(c(".*mail.*", "newsletter"
    ),
    collapse="|")




    referral.path <- paste(c(".*google\\.com\\.pe.*",
                             ".*google\\.co\\.ve.*",
                             ".*google\\.com\\.br.*",
                             ".*google\\.com\\.bo.*",
                             ".*google\\.com\\.ar.*",
                             ".*google\\.com.*",
                             "sodimac.com.pe",
                             "falabella.com.pe",
                             "beneficios.gruporomero.com.pe",
                             "somosdata.net","shop.lenovo.com",
                             "canonexperience.pe", "lg.com", "deperu.com"
    ),
    collapse="|")



    redes.sociales.path <- paste(c(".*fac?e.*",
                                   ".*twitt?.*","tw.*", "pp.*"),
                                 collapse="|")



    ritmo.romantica.path <- paste(c("ritmo.*"
    ),
    collapse="|")



    prensmart.path <- paste(c("prensmart.*"
    ),
    collapse="|")

    organic.path <- paste(c("start.iminent.com",".*search.*",
                            "websearch.com","crawler.com|allmyweb.com"),
                          collapse="|")



    otros.path <- paste(c("web", "popup", "contenido"),
                        collapse="|")


    #direct.path <- "//(direct//).*"

    ### GREPL PART
    adsense <- grepl(adsense.path, data$source[i], ignore.case = T)


    adwords.medium <- grepl(adwords.path,data$medium[i], ignore.case = T)

    adwords.source <- grepl(adwords.path,data$source[i], ignore.case = T)


    email.medium <- grepl(email.path,data$medium[i], ignore.case = T)

    email.source <- grepl(email.path,data$source[i], ignore.case = T)


    referral.medium <- grepl("referral", data$medium[i],
                             ignore.case = T)

    referral.source <- grepl(referral.path, data$source[i],
                             ignore.case = T)


    spam <- grepl(spam.path, data$source[i],
                  ignore.case = T)



    redes.sociales <- grepl(redes.sociales.path, data$source[i],
                            ignore.case = T)


    ritmo.romantica <- grepl(ritmo.romantica.path, data$source[i],
                             ignore.case = T)



    prensmart <- grepl(prensmart.path, data$source[i],
                       ignore.case = T)

    organic <- grepl(organic.path, data$source[i], ignore.case = T)



    otros <- grepl(otros.path, data$medium[i], ignore.case = T)



    ### Conditional part

    ### Directo tiene un espacio en blanco

    if (data$source[i] == "(direct)") {
      if (language == "en") {
        data$fuente[i] <- "direct"
      }
      else if (language == "es") {
        data$fuente[i] <- "directo"
      }
    }


    else if (referral.source | otros) {
      if (language == "en") {
        data$fuente[i] <- "references"
      }
      else if (language == "es") {
        data$fuente[i] <- "referencias"
      }
    }


    else if (data$medium[i] == "organic" |
             organic) {
      if (language == "en") {
        data$fuente[i] <- "organic"
      }
      else if (language == "es") {
        data$fuente[i] <- "organico"
      }
    }

    else if (adwords.source
             & adwords.medium) {

      if (language == "en") {
        data$fuente[i] <- "adwords"
      }
      else if (language == "es") {
        data$fuente[i] <- "adwords"
      }
    }



    else if (adsense) {

      data$fuente[i] <- "adsense"
    }


    else if (email.medium | email.source) {

      data$fuente[i] <- "email"
    }



    else if (redes.sociales) {

      if (language == "en") {
        data$fuente[i] <- "social media"
      }
      else if (language == "es") {
        data$fuente[i] <- "redes sociales"
      }

    }

    else if (ritmo.romantica) {

      data$fuente[i] <- "ritmo romantica"
    }


    else if (prensmart) {

      data$fuente[i] <- "prensmart"

    }


    else if (spam) {

      data$fuente[i] <- "spam"
    }

    else {
      data$fuente[i] <- "spam"
    }
  }

  return(data)

}

