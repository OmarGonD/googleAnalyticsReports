# googleAnalyticsReports

The goal of googleAnalyticsReports is to clean data from GA API before plotting. 

This package expects that the user already has data from GA, and especially, that this data has a column: `sourceMedium` to work on. 

You could use the `googleAnalyticsR` from Mark Edmonson to make a call like the following to the `GA API`:

```r 

library(googleAnalyticsR)

ga_auth()

my_accounts <- ga_account_list()
View(my_accounts)

my_id <- 123456789 #use your view id here 

start_date <- "2018-01-01"
final_date <- "2018-01-31"

my_data <- google_analytics_4(my_id, 
                              date_range = c(start_date, final_date),
                              metrics = "sessions",
                              dimensions = c("date", "sourceMedium"))

```



The main functions are:

`ga_clean_data()`  #cleans the sourceMedium column 

`ga_*` functions to generate plots using ggplot2 as plotting library.



## Example

This is a basic example which shows you how to solve a common problem:

``` r
## use data sample for demostration

data(gadata)

cleaned_data <- ga_clean_data(gadata)

head(cleaned_data)

```

