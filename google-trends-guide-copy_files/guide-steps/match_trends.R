# The objective is to compare google trends data and gtrendsR data
# And to ensure they are identical
# Note -- google trends takes a new sample every so often
# So you must run gtrendsR when you download the google trends csv
# if you want them to match
# Here, you can either run your own test to see if they match by downloading
# a new csv and running gtrendsR yourself
# Or, you can use the csv files provided in the data folder that I used

# Required packages

library(tidyverse)
library(gtrendsR)

# Specify google trend csv file path, search term(s), and timespan (2018 here)
# Download 2019-02-09-google-trends-homepage.csv found in 
# the data folder and replace the path below with your own local path
# csv downloaded at https://bit.ly/2GzmiWc
# Or provide your new csv path if you are running your own test

csv <- "/Users/malcolm_mashig/Downloads/2019-02-09-google-trends-homepage.csv"
search_term <- '"juice laundry"'
time_span <- "2018-01-01 2018-12-31"

# Read in google trends csv 
# If you want to run your own test with a new csv (not the one provided),
# you must specify column type so that it matches gtrends

o <- read_csv(csv, skip = 2)

google_trend <- read_csv(
  csv, skip = 3, 
  col_names = c('week_of', 'relative_interest')
  # col_types = cols('relative_interest' = col_integer())
  ) %>% 
  as_tibble() %>% 
  mutate('search_term' = search_term) %>% 
  select(c('week_of', 'search_term', 'relative_interest'))

# Run gtrends to obtain list of data frames (at 5 PM, 2019-02-09)

gtrends_list <- gtrends(
  search_term,  geo = "US", time = time_span
)

# Optional -- write a csv, if you are not using the one provided, to save 
# gtrendsR data you use (remember, its a different sample each time)

write_csv(gtrends_list[["interest_over_time"]], paste0(Sys.Date(), "-google-trends-gtrendsr.csv"))

# If you are running your own test with new csv file, convert gtrends 
# interest_over_time into data table that matches google trend

gtrend <- gtrends_list[["interest_over_time"]] %>% 
  as_tibble() %>%
  select('relative_interest' = hits)

# If you are not running your own test, download the csv I used
# named '2019-02-09-google-trends-gtrendsr.csv' in the data folder
# and insert your local path

gtrendsr_csv <- '/Users/malcolm_mashig/Box Sync/google-trends-analysis/data/2019-02-09-google-trends-gtrendsr.csv'

# and read it in

gtrend <- read_csv(gtrendsr_csv) %>% 
  select('relative_interest' = hits)

# Prove that the relative_interest columns match

identical(google_trend[, 3], gtrend[, 1])

## TRUE

# We have shown that gtrendsR is reliable in extracting the exact data 
# from Google Trends

