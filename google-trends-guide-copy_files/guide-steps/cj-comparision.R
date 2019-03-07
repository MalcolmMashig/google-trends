remove.packages('gtrendsR')
devtools::install_github("PMassicotte/gtrendsR")
library(gtrendsR)
library(tidyverse)
library(gridExtra)
library(ggtech)
library(extrafont)

# Download and import fonts for google graphs later

download.file(
  "http://social-fonts.com/assets/fonts/product-sans/product-sans.ttf", 
  "/Library/Fonts/product-sans.ttf", 
  method="curl"
)
font_import(pattern = 'product-sans.ttf', prompt=FALSE)

search_terms <- c('Corner Juice', '"Corner Juice"')
time_span <- "2016-10-08 2018-12-31"

gtrends_list <- gtrends(keyword = search_terms, geo = "US", time = time_span,
                        gprop = "web")

write_csv(gtrends_list[["interest_over_time"]], 
          path = "2019-02-17-cj-gtrend.csv")

gtrend <- gtrends_list[["interest_over_time"]] %>% 
  as_tibble() %>% 
  rename('relative_interest' = 'hits', 'week_of' = 'date', 
         'search_term' = 'keyword') %>% 
  select(c('week_of', 'search_term', 'relative_interest'))
