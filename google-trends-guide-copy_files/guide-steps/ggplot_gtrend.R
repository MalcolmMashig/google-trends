# The objective is to replicate the two main visuals 
# that Google Trends supplies: the line and bar graph
# with multiple TJL search term variations provided

# Load required packages --------------------------------------------------

library(tidyverse)
library(gtrendsR)
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

# Specify search terms and date (timeline of tjl 'Square' data) 
# Download 2019-02-10-ggplot-gtrend.csv from data folder
# if you wish to use the csv I used (but replace with your local path)
# Notice that quoting terms makes a difference
# Ex. The Juice Laundry vs. "The Juice Laundry"
# But capitalization would not make a difference
# Ex. the juice laundry vs. The Juice Laundry

search_terms <- c('the juice laundry', '"the juice laundry"', 'juice laundry',
                  '"juice laundry"', 'TJL')
time_span <- "2016-10-11 2018-12-31"
csv <- "/Users/malcolm_mashig/Box Sync/google-trends-analysis/data/2019-02-10-ggplot-gtrend.csv"

# If you are NOT using my csv, run gtrends to obtain list of data frames
# It takes a while

gtrends_list <- gtrends(keyword = search_terms, geo = "US", time = time_span,
                        gprop = "web")

# NOTE - csv is from gtrends that was run at 11:57 pm on 2019-02-10
# Write csv to record your sample of data (different after time)

write_csv(gtrends_list[["interest_over_time"]], 
          path = "2019-02-10-ggplot-gtrend.csv")

# If using your own csv, create tidy table

gtrend <- gtrends_list[["interest_over_time"]] %>% 
  as_tibble() %>% 
  rename('relative_interest' = 'hits', 'week_of' = 'date', 
         'search_term' = 'keyword') %>% 
  select(c('week_of', 'search_term', 'relative_interest'))

# Or, if you are using my csv, read it in as tidy table

gtrend <- read_csv(csv) %>% 
  as_tibble() %>% 
  rename('relative_interest' = 'hits', 'week_of' = 'date', 
         'search_term' = 'keyword') %>% 
  select(c('week_of', 'search_term', 'relative_interest'))

# Replicate a neat google trend line graph
# Notice that titles should state a conclusion

scale_color_tech <- function(theme="airbnb", tech_key = list(
  airbnb = c("#FF5A5F", "#FFB400", "#007A87",  "#FFAA91", "#7B0051"),
  facebook = c("#3b5998", "#6d84b4", "#afbdd4", "#d8dfea"),
  google = c("#5380E4", "#E12A3C", "#FFBF03", "#00B723", "#8440a3"),
  etsy = c("#F14000", "#67B6C3", "#F0DA47", "#EBEBE6", "#D0D0CB"),
  twitter = c("#55ACEE", "#292f33", "#8899a6", "#e1e8ed"),
  X23andme = c("#3595D6","#92C746","#F2C100","#FF6D19", "#6F3598")
)) {
  
  scale_color_manual(values=tech_key[[theme]])
  
}

ggplot(gtrend, aes(x = week_of, 
                   y = relative_interest, 
                   color = search_term)) + 
  geom_line() +
  theme_tech(theme = 'google') + 
  scale_color_tech(theme = 'google') +
  labs(subtitle = 'The search term, Juice Laundry, consistently 
       recieved greatest interest from Oct 2016 thru 2018', 
       x = 'Month', 
       y = 'Relative Interest', 
       color = 'Search Term') + 
  scale_x_datetime(date_labels = "%m/%Y", date_breaks = "2 months") +
  theme(legend.position = 'bottom', legend.direction = 'vertical', 
        axis.text.x = element_text(angle = 45, hjust = 1)) +
  guides(color = guide_legend(nrow = 2))

ggplot(gtrend, aes(x = week_of, 
                   y = relative_interest, 
                   color = search_term)) + geom_line() + labs(x = 'Month', 
       y = 'Relative Interest', 
       color = 'Search Term')


## Notice that the juice laundry line does not show
## because it is the same line as Juice Laundry

# Summarize the average interest and round to avoid a bunch of decimals

avg_trend <- gtrend %>% 
  group_by(search_term) %>% 
  summarise(round(mean(relative_interest))) %>% 
  rename('avg_interest' = 'round(mean(relative_interest))')

# Plot bar graph with stat = 'identity' to avoid a count (allowing y variable)
# Use geom_text to label interest over bars
# Entered manual colors from ggtech theme page

bar_graph <- ggplot(avg_trend, aes(x = search_term, y = avg_interest)) + 
  geom_bar(stat = 'identity', fill = c("#5380E4", "#E12A3C", 
                                       "#FFBF03", "#00B723")) +
  geom_text(aes(label = avg_interest, vjust = -1)) +
  theme_tech(theme = 'google') +
  scale_fill_tech(theme = 'google') +
  labs(subtitle = "Avg Relative Interest", 
       x = 'Search Term', 
       y = 'Average Interest') +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  ylim(0, 100)

## Again, notice juice laundry and Juice Laundry averages are equal

## Now you have the two main visuals that Google Trends gives you
## stored as objects

# Arrange them side by side

grid.arrange(bar_graph, line_graph, ncol = 2, widths = c(2, 5))

## If you get an error like 'polygon edge not found', restart R 
## and try again
## If that does not work, update your ggplot2 pkg as well









       
