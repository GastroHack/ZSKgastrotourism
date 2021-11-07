#include packages
library(shinydashboard)
library(shiny)
library(shinydashboard)
library(tidyverse)
library(leaflet)
library(leaflet.extras)
library(dplyr)
library(magrittr)
library(DT)
library(data.table)
library(scales)

library(lubridate)
library(readxl)

library(plotly)

library(tidyr)
library(sqldf)
library(stringi)
library(shinyjs)


# login details to AWS
Sys.setenv(
  "AWS_ACCESS_KEY_ID" = "",
  "AWS_SECRET_ACCESS_KEY" = "",
  "AWS_DEFAULT_REGION" = "eu-west-2")
get_bucket(bucket ='')


data1 <- read.csv("./data/data12.csv")
data1$month <- dmy(data1$month)
data1$season <- factor(data1$season)
data1$type <- factor(data1$type)

saveRDS(data1, file="./data/data12.rds")
