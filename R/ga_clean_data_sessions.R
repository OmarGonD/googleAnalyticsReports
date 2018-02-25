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

ga_clean_data_sessions <- function(data, language = "en", remove_spam = TRUE) {


  #data$sourceMedium <- sub('.*www.', "", data$sourceMedium)

  #data$sourceMedium <- gsub("(www\\.$|\\.com.*)", "", data$sourceMedium)

  data$sourceMedium <- sub("^(.+)www\\.(.+)\\.com.+","\\1\\2", data$sourceMedium)

  data$date <- as.Date(data$date)

  data$anio <- lubridate::year(data$date)

  data$mes <- lubridate::month(data$date, label = T)



  data <- data %>%
    separate(sourceMedium, into = c("source", "medium"), sep = "\\/")


  data$medium <- as.character(data$medium)

  data$source <- as.character(data$source)

  #data$pageviews <- as.numeric(data$pageviews)


  ### Remove white spaces adelante y detr?s


  data$medium <- trimws(data$medium, which = "both")

  data$source <- trimws(data$source, which = "both")


  data$sources <- NA

  # language <- "en"

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




    adwords.path <- paste(c("cpc", "search", "GoogleSearch",
                            "ccp","google_display",
                            "cpm","cpv",".*youtube.*","video.*",
                            "google", "google_blast","(not set)"),
                          collapse="|")




    email.path <- paste(c(".*mail.*", "newsletter", 'outlook[.]live'
    ),
    collapse="|")




    referral.path <- paste(c(".*google\\.com\\.pe.*",
                             ".*google\\.co\\.ve.*",
                             ".*google\\.com\\.br.*",
                             ".*google\\.com\\.bo.*",
                             ".*google\\.com\\.ar.*",
                             ".*google\\.com\\.es.*",
                             "sodimac\\.com\\.pe", "adonde\\.com",
                             "falabella\\.com\\.pe", "taringa\\.net",
                             "larepublica\\.pe", "panasonic\\.com",
                             "elpopular\\.pe", "forosperu\\.net",
                             ".*toshiba\\.com", "claroideas\\.com",
                             "tiendeo\\.pe", "diariocorreo\\.pe",
                             "messenger\\.com", "hp\\.com",
                             "pricingcompass\\.com", "trome\\.pe",
                             "visa-infinite\\.com", "atv\\.pe",
                             "ripley\\.com\\.pe", "wapa\\.pe", "depor\\.com",
                             "cyberdays\\.net\\.pe", "latinamerica\\.brother\\.com",
                             "nikonperu\\.com", "keep\\.google\\.com",
                             "elpais\\.com", "promociones\\.net\\.pe",
                             "latina\\.pe", "carsa\\.com\\.pe",
                             "zona\\.pagoefectivo\\.pe", "advanceperu\\.com",
                             "picodi\\.com", "http\\:\\/\\/nssjaen\\.com\\/",
                             "terra\\.com\\.pe", ".*blogspot\\.com",
                             "los40\\.radio\\.es", "brother\\.com\\.pe",
                             "gestion\\.pe", "getpocket\\.com",
                             "peruhardware\\.net", "efe\\.com\\.pe",
                             "peru21\\.pe", "cyberdays\\.pe",
                             "samsung\\.com", "imacosa\\.com",
                             "LaRepublica", "libero\\.pe", "hiraoka\\.com\\.pe",
                             "hyundaielectronics\\.com\\.pe", "oster\\.com\\.pe",
                             "beneficios\\.gruporomero\\.com\\.pe",
                             "somosdata\\.net","shop\\.lenovo\\.com",
                             "canonexperience\\.pe", "lg\\.com", "deperu\\.com"
    ),
    collapse="|")


    onesignal.path <- ".*OneSignal.*"

    criteo.path <- ".*criteo.*"


    redes.sociales.path <- paste(c(".*fac?e.*",
                                   ".*twitt?.*","tw.*", "pp.*", ".*instagram.*"),
                                 collapse="|")



    ritmo.romantica.path <- paste(c("ritmo.*"
    ),
    collapse="|")



    prensmart.path <- paste(c("prensmart.*"
    ),
    collapse="|")

    organic.path <- paste(c("start.iminent.com","\\.search.*", "zapmeta\\.pe",
                            "duckduckgo\\.com", "izito\\.pe", "qwant\\.com",
                            "findgofind\\.co", "teoma\\.com", "google\\.com.*",
                            "bing\\.com", "smarter\\.com",
                            "websearch.com","crawler.com|allmyweb.com", "google\\.es",  "ecosia\\.org"),
                          collapse="|")



    otros.path <- paste(c("web", "popup", "contenido"),
                        collapse="|")


    #direct.path <- "//(direct//).*"

    ### GREPL PART
    adsense <- grepl(adsense.path, data$source[i], ignore.case = T)


    adwords.medium <- grepl(adwords.path,data$medium[i], ignore.case = T)

    adwords.source <- grepl(adwords.path,data$source[i], ignore.case = T)

    criteo.source <- grepl(criteo.path,data$source[i], ignore.case = T)

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

    organic.medium <- grepl("organic", data$medium[i],
                             ignore.case = T)


    onesignal.source <- grepl(onesignal.path,data$source[i], ignore.case = T)




    otros <- grepl(otros.path, data$medium[i], ignore.case = T)



    ### Conditional part

    ### Directo tiene un espacio en blanco

    if (data$source[i] == "(direct)") {
      if (language == "en") {
        data$sources[i] <- "direct"
      }
      else if (language == "es") {
        data$sources[i] <- "directo"
      }
    }


    else if (referral.source | otros) {
      if (language == "en") {
        data$sources[i] <- "references"
      }
      else if (language == "es") {
        data$sources[i] <- "referencias"
      }
    }


    else if (onesignal.source) {
      if (language == "en") {
        data$sources[i] <- "onesignal"
      }
      else if (language == "es") {
        data$sources[i] <- "onesignal"
      }
    }

    else if (criteo.source) {
      if (language == "en") {
        data$sources[i] <- "criteo"
      }
      else if (language == "es") {
        data$sources[i] <- "criteo"
      }
    }


    else if (organic.medium | organic) {

      if (language == "en") {
        data$sources[i] <- "organic"
      }
      else if (language == "es") {
        data$sources[i] <- "organico"
      }
    }

    #else if (organic) {

     # data$sources[i] <- "organic"

    #}

    else if (adwords.source
             & adwords.medium) {

      if (language == "en") {
        data$sources[i] <- "adwords"
      }
      else if (language == "es") {
        data$sources[i] <- "adwords"
      }
    }



    else if (adsense) {

      data$sources[i] <- "adsense"
    }


    else if (email.medium | email.source) {

      data$sources[i] <- "email"
    }



    else if (redes.sociales) {

      if (language == "en") {
        data$sources[i] <- "social media"
      }
      else if (language == "es") {
        data$sources[i] <- "redes sociales"
      }

    }

    else if (ritmo.romantica) {

      data$sources[i] <- "ritmo romantica"
    }


    else if (prensmart) {

      data$sources[i] <- "prensmart"

    }


    else if (spam) {

      data$sources[i] <- "spam"
    }

    else {
      data$sources[i] <- "spam"
    }
  }


  if(remove_spam) {

    data <- data %>%
            filter(sources != 'spam')
  }

  return(data)

}

