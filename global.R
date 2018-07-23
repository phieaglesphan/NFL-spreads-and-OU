setwd("C:/Users/maxbs/Documents/R/NFL Shiny Project Directory/NFLSpreads/data")
nfl = read.csv('NFL_Spreads_clean.csv',stringsAsFactors = F)

library(tidyverse)
library(shiny)
library(shinydashboard)
library(DT)

Select_All=c(sort(unique(nfl$team_home)))
teams=c(Select_All, sort(unique(nfl$team_home)))


intro="The NFL is the highest-grossing sports league in the world. In 2017, the NFL generated approximately $14 billion USD. In July of 2018, 
Forbes reported that 29 of the NFL's 32 teams are included in their list of the 50 most valuable sports franchises in the world. The American Gaming Association, 
a casino lobbying group, projects that Americans bet $4.76 billion on Super Bowl LII in 2018, with more than 97% of that figure 
represented by illegally placed bets. In May of 2018, the U.S. Supreme Court lifted the federal ban on sports gambling. States will gradually legalize 
sports gambling over the next few years, and the industry could very well evolve to become unrecognizable from what it is today. As of the writing of this,
the two most common aspects of the game to place bets on are the winner of the game, and the final score of the game. Since not every matchup between two 
opponents is an even match, this can be offset by the spread. The spread is essentially a number of points handicapped to the perceived underdog, so as to make 
the bet of who is going to win the game one that can be made with even money. The over/under bet is simpler: it's a figure that represents the total score of the 
two teams combined."

thedata="This application is primarily interested in examining the error found by comparing the realized results of game scores to the offered lines by 
Las Vegas, and attempting to isolate a small handful of variables to identify trends and predict error. This application uses a dataset of every regular 
season and postseason NFL game since the 1979 season through the Super Bowl in 2018 (the culmination of the 2017 season). In addition to descriptive data of 
the NFL games and their results, the data includes what Las Vegas sports books offered as Spreads (including the favorite team, of course) as well as the 
Over/Under line. In both the spreads and O/U analysis, there is an important variable called Error. Error can be positive or negative.
In the case of the spreads, positive Error means the favorite covered the spread, while negative Error means the underdog covered the spread. In the case of 
the Over/Under, positive means the teams combined to score more than the over/under line, while negative means the teams scored less than the over/under line. 
We would expect error to be 0, but the data proves that to not always be the case."

note="Bet on the underdog to cover the spread! Don't only look towards the most recent Super Bowl Champion Philadelphia Eagles, who were underdogs in all 3 of 
their playoff games -  take a look at the first chart on the spreads page, showing that nearly 400 more games saw the underdog cover the spread than the favorite. 
Further more, the 'Error' variable, (the same one used in the Spread histogram and Two-Sided Error charts) is expected to average 0 as we examine more 
games because we assume 'Vegas knows,' but instead a simple t test shows that the average Error is -0.35 points and is statistically significant. Another 
note is to look at spreads from the 2014 season...what happened? If there ever was a year of the underdog, that's it. Unfortunately, we can't easily come to 
a similar conclusion for the Over/Under. While we can see that the under has been correct more times than the over, a t test of the error shows the mean to 
be +0.65 and statistically significant."

