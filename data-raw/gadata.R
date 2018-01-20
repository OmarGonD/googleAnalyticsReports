library(readr)
library(usethis)

gadata <- read_csv("data-raw/gadata.csv")

usethis::use_data(gadata, overwrite = TRUE)
