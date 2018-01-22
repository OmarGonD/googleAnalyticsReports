library(readr)
library(usethis)

gadata <- read_csv("data-raw/gadata.csv")

gadata_heatmap <- read_csv("data-raw/gadata-heatmap.csv")

usethis::use_data(gadata, overwrite = TRUE)
usethis::use_data(gadata_heatmap, overwrite = TRUE)
