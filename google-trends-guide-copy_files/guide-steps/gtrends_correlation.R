# Must download development version

remove.packages('gtrendsR')
devtools::install_github("PMassicotte/gtrendsR")
library(gtrendsR)
library(tidyverse)

# Decode q parameter in URL (before comma)

URLdecode("q=%2Fg%2F12m9gwg0k")

# insert decoded search term key as topic

search_terms <- c("/g/12m9gwg0k", "The Juice Laundry", '"The Juice Laundry"',
                  "Juice Laundry", '"Juice Laundry"')

gtrends_list <- gtrends(keyword = search_terms, 
                        geo = "US", time = "2016-10-08 2018-12-31")

write_csv(gtrends_list[["interest_over_time"]], "2019-02-17-tjl-sample.csv")

# rename /g/12m9gwg0k value to TJL Topic

x <- gtrends_list[["interest_over_time"]]

x[x$keyword == "/g/12m9gwg0k", "keyword"] <- "TJL Topic"

# Spread so that we can test correlation

y <- x %>% spread(key = "keyword", value = "hits")

cor(y[,9], y[, 8])

cor(y[,9], y[, 7])

cor(y[,9], y[, 6])

cor(y[,9], y[, 5])

cor(y[,9], y[, 4]) # Highest Correlation is "Juice Laundry"

ggplot(x, aes(date, hits, color = keyword)) + geom_line()
