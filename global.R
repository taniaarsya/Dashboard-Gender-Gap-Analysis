library(shiny)
library(shinydashboard)
library(tidyverse)
library(plotly)
library(glue)
library(scales)
library(DT)

# read data
workers <- read_csv("jobs_gender.csv")

# preprocessing data
workers_clean <- workers %>% 
  drop_na(total_earnings_male, total_earnings_female) %>% 
  select(-wage_percent_of_male)

# tema yang sudah dicustom
theme_algoritma <- theme(legend.key = element_rect(fill="black"),
                         legend.background = element_rect(color="white",
                                                          fill="#263238"),
                         plot.subtitle = element_text(size=6, color="white"),
                         panel.background = element_rect(fill="#dddddd"),
                         panel.border = element_rect(fill=NA),
                         panel.grid.minor.x = element_blank(),
                         panel.grid.major.x = element_blank(),
                         panel.grid.major.y = element_line(color="darkgrey",
                                                           linetype=2),
                         panel.grid.minor.y = element_blank(),
                         plot.background = element_rect(fill="#263238"),
                         text = element_text(color="white"),
                         axis.text = element_text(color="white")
                         
)