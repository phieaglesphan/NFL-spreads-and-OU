setwd("C:/Users/maxbs/Documents/R/NFL Shiny Project Directory/NFLSpreads/data")
nfl = read.csv('NFL_Spreads_clean.csv',stringsAsFactors = F)

library(tidyverse)
library(shiny)
library(shinydashboard)
library(DT)

teams=c("Select All", sort(unique(nfl$team_home)))