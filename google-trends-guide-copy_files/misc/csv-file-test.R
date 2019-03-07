
library(tidyverse)

tjl <- list.files()
tjl

folder <- "https://raw.githubusercontent.com/MalcolmMashig/google-trends/master/tjl/2019-02-18-tjl-sample.csv"

library(httr)

nuts <-read.csv(text= GET("https://raw.githubusercontent.com/MalcolmMashig/google-trends/master/tjl/2019-02-18-tjl-sample.csv"))
nuts

library(repmis)

tjl <- source_data(folder)

read_csv("https://raw.githubusercontent.com/MalcolmMashig/google-trends/master/tjl/2019-02-18-tjl-sample.csv")

setwd("https://github.com/GCOM7140/google-trends-analysis/tree/master/google-trends-guide_files/samples/tjl")

list.files("https://github.com/MalcolmMashig/google-trends/tree/master/tjl", pattern = "-tjl-sample.csv")

x <- list(download.file("https://github.com/MalcolmMashig/google-trends/tree/master/tjl", destfile = "-tjl-sample.csv"))
x

library(devtools)

raw <- "https://raw.githubusercontent.com/MalcolmMashig/google-trends/master/tjl/2019-"
tjl <- "-tjl-sample.csv"



X1 <- read_csv(paste0(raw, "02-18", tjl)) %>% select(hits)
X1

ui <- "https://github.com/MalcolmMashig/google-trends/blob/master/tjl-gtrends-ui.png"

download.file(ui)

library(RCurl)

x <- getURLContent("https://github.com/MalcolmMashig/google-trends/blob/master/tjl-gtrends-ui.png")
x

   