

#################################################################### LOAD DATA ####################################################################

# data is found at https://www.kaggle.com/tobycrabtree/nfl-scores-and-betting-data/home and selecting the 'spreadspoke_scores' set

setwd("C:/Users/maxbs/Documents/R/NFL Shiny Project Directory/NFLSpreads/data")
spreads = read.csv(file='spreadspoke_scores.csv',header=T,stringsAsFactors = F)
library(dplyr)

names(nfl)

###############################################################   CLEANING THE DATA SET   ############################################################

# drop (incomplete) weather columns data
spreads = spreads %>% select(-weather_humidity,-weather_temperature,-weather_wind_mph)

# spread and O/U data began in 1979 so we only observe this data
spreads = spreads %>% filter(schedule_season>=1979); nrow(spreads) == 9643 #confirm dataset is right size

#Replace the erroneous SD tag with proper LAC for 1 chargers case
spreads[spreads$team_favorite_id=='SD',"team_favorite_id"]<-'LAC'
#Do the same for LAR associated with the raiders (supposed to be rams)
spreads[((spreads$team_favorite_id=='LAR'&(spreads$team_away=='Los Angeles Raiders'|spreads$team_home=='Los Angeles Raiders') & spreads$schedule_week!=3)),"team_favorite_id"]<-'OAK'

#making the team names uniform
spreads[spreads$team_home=='Baltimore Colts',"team_home"]<-'Indianapolis Colts'
spreads[spreads$team_away=='Baltimore Colts',"team_away"]<-'Indianapolis Colts'
spreads[spreads$team_home=='Houston Oilers',"team_home"]<-'Tennessee Titans'
spreads[spreads$team_away=='Houston Oilers',"team_away"]<-'Tennessee Titans'
spreads[spreads$team_home=='Tennessee Oilers',"team_home"]<-'Tennessee Titans'
spreads[spreads$team_away=='Tennessee Oilers',"team_away"]<-'Tennessee Titans'
spreads[spreads$team_home=='Los Angeles Raiders',"team_home"]<-'Oakland Raiders'
spreads[spreads$team_away=='Los Angeles Raiders',"team_away"]<-'Oakland Raiders'
spreads[spreads$team_home=='Phoenix Cardinals',"team_home"]<-'Arizona Cardinals'
spreads[spreads$team_away=='Phoenix Cardinals',"team_away"]<-'Arizona Cardinals'
spreads[spreads$team_home=='San Diego Chargers',"team_home"]<-'Los Angeles Chargers'
spreads[spreads$team_away=='San Diego Chargers',"team_away"]<-'Los Angeles Chargers'
spreads[spreads$team_home=='St. Louis Cardinals',"team_home"]<-'Arizona Cardinals'
spreads[spreads$team_away=='St. Louis Cardinals',"team_away"]<-'Arizona Cardinals'
spreads[spreads$team_home=='St. Louis Rams',"team_home"]<-'Los Angeles Rams'
spreads[spreads$team_away=='St. Louis Rams',"team_away"]<-'Los Angeles Rams'


# making team names match favorite column
spreads[spreads$team_home=='Arizona Cardinals',"team_home"]<-'ARI'
spreads[spreads$team_away=='Arizona Cardinals',"team_away"]<-'ARI'
spreads[spreads$team_home=='Atlanta Falcons',"team_home"]<-'ATL'
spreads[spreads$team_away=='Atlanta Falcons',"team_away"]<-'ATL'
spreads[spreads$team_home=='Baltimore Ravens',"team_home"]<-'BAL'
spreads[spreads$team_away=='Baltimore Ravens',"team_away"]<-'BAL'
spreads[spreads$team_home=='Buffalo Bills',"team_home"]<-'BUF'
spreads[spreads$team_away=='Buffalo Bills',"team_away"]<-'BUF'
spreads[spreads$team_home=='Carolina Panthers',"team_home"]<-'CAR'
spreads[spreads$team_away=='Carolina Panthers',"team_away"]<-'CAR'
spreads[spreads$team_home=='Chicago Bears',"team_home"]<-'CHI'
spreads[spreads$team_away=='Chicago Bears',"team_away"]<-'CHI'
spreads[spreads$team_home=='Cincinnati Bengals',"team_home"]<-'CIN'
spreads[spreads$team_away=='Cincinnati Bengals',"team_away"]<-'CIN'
spreads[spreads$team_home=='Cleveland Browns',"team_home"]<-'CLE'
spreads[spreads$team_away=='Cleveland Browns',"team_away"]<-'CLE'
spreads[spreads$team_home=='Dallas Cowboys',"team_home"]<-'DAL'
spreads[spreads$team_away=='Dallas Cowboys',"team_away"]<-'DAL'
spreads[spreads$team_home=='Denver Broncos',"team_home"]<-'DEN'
spreads[spreads$team_away=='Denver Broncos',"team_away"]<-'DEN'
spreads[spreads$team_home=='Detroit Lions',"team_home"]<-'DET'
spreads[spreads$team_away=='Detroit Lions',"team_away"]<-'DET'
spreads[spreads$team_home=='Green Bay Packers',"team_home"]<-'GB'
spreads[spreads$team_away=='Green Bay Packers',"team_away"]<-'GB'
spreads[spreads$team_home=='Houston Texans',"team_home"]<-'HOU'
spreads[spreads$team_away=='Houston Texans',"team_away"]<-'HOU'
spreads[spreads$team_home=='Indianapolis Colts',"team_home"]<-'IND'
spreads[spreads$team_away=='Indianapolis Colts',"team_away"]<-'IND'
spreads[spreads$team_home=='Jacksonville Jaguars',"team_home"]<-'JAX'
spreads[spreads$team_away=='Jacksonville Jaguars',"team_away"]<-'JAX'
spreads[spreads$team_home=='Kansas City Chiefs',"team_home"]<-'KC'
spreads[spreads$team_away=='Kansas City Chiefs',"team_away"]<-'KC'
spreads[spreads$team_home=='Los Angeles Chargers',"team_home"]<-'LAC'
spreads[spreads$team_away=='Los Angeles Chargers',"team_away"]<-'LAC'
spreads[spreads$team_home=='Los Angeles Rams',"team_home"]<-'LAR'
spreads[spreads$team_away=='Los Angeles Rams',"team_away"]<-'LAR'
spreads[spreads$team_home=='Miami Dolphins',"team_home"]<-'MIA'
spreads[spreads$team_away=='Miami Dolphins',"team_away"]<-'MIA'
spreads[spreads$team_home=='Minnesota Vikings',"team_home"]<-'MIN'
spreads[spreads$team_away=='Minnesota Vikings',"team_away"]<-'MIN'
spreads[spreads$team_home=='New England Patriots',"team_home"]<-'NE'
spreads[spreads$team_away=='New England Patriots',"team_away"]<-'NE'
spreads[spreads$team_home=='New Orleans Saints',"team_home"]<-'NO'
spreads[spreads$team_away=='New Orleans Saints',"team_away"]<-'NO'
spreads[spreads$team_home=='New York Giants',"team_home"]<-'NYG'
spreads[spreads$team_away=='New York Giants',"team_away"]<-'NYG'
spreads[spreads$team_home=='New York Jets',"team_home"]<-'NYJ'
spreads[spreads$team_away=='New York Jets',"team_away"]<-'NYJ'
spreads[spreads$team_home=='Oakland Raiders',"team_home"]<-'OAK'
spreads[spreads$team_away=='Oakland Raiders',"team_away"]<-'OAK'
spreads[spreads$team_home=='Philadelphia Eagles',"team_home"]<-'PHI'
spreads[spreads$team_away=='Philadelphia Eagles',"team_away"]<-'PHI'
spreads[spreads$team_home=='Pittsburgh Steelers',"team_home"]<-'PIT'
spreads[spreads$team_away=='Pittsburgh Steelers',"team_away"]<-'PIT'
spreads[spreads$team_home=='San Francisco 49ers',"team_home"]<-'SF'
spreads[spreads$team_away=='San Francisco 49ers',"team_away"]<-'SF'
spreads[spreads$team_home=='Seattle Seahawks',"team_home"]<-'SEA'
spreads[spreads$team_away=='Seattle Seahawks',"team_away"]<-'SEA'
spreads[spreads$team_home=='Tampa Bay Buccaneers',"team_home"]<-'TB'
spreads[spreads$team_away=='Tampa Bay Buccaneers',"team_away"]<-'TB'
spreads[spreads$team_home=='Tennessee Titans',"team_home"]<-'TEN'
spreads[spreads$team_away=='Tennessee Titans',"team_away"]<-'TEN'
spreads[spreads$team_home=='Washington Redskins',"team_home"]<-'WAS'
spreads[spreads$team_away=='Washington Redskins',"team_away"]<-'WAS'


#mark bills games in canada as non-neutral
spreads[spreads$stadium=='Rogers Centre',"stadium_neutral"]<-FALSE

#fix the week thing
#1999 season:
spreads[spreads$schedule_season==1999&spreads$schedule_week==9,'schedule_week']<-8
spreads[spreads$schedule_season==1999&spreads$schedule_week==10,'schedule_week']<-9
spreads[spreads$schedule_season==1999&spreads$schedule_week==11,'schedule_week']<-10
spreads[spreads$schedule_season==1999&spreads$schedule_week==12,'schedule_week']<-11
spreads[spreads$schedule_season==1999&spreads$schedule_week==13,'schedule_week']<-12
spreads[spreads$schedule_season==1999&spreads$schedule_week==14,'schedule_week']<-13
spreads[spreads$schedule_season==1999&spreads$schedule_week==15,'schedule_week']<-14
spreads[spreads$schedule_season==1999&spreads$schedule_week==16,'schedule_week']<-15
spreads[spreads$schedule_season==1999&spreads$schedule_week==17,'schedule_week']<-16
spreads[spreads$schedule_season==1999&spreads$schedule_week==18,'schedule_week']<-17

#the 1993 season actually did have 18 weeks (b/c that season they had two byeweeks). 
#DECIDING TO REMOVE THOSE GAMES FROM THE DATASET
spreads = spreads %>% filter(schedule_week!=18)


# now we convert the string weeks (playoff rounds) to numbers for a logical sequence
spreads[spreads$schedule_week=='Wildcard','schedule_week']<-18
spreads[spreads$schedule_week=='WildCard','schedule_week']<-18
spreads[spreads$schedule_week=='Division','schedule_week']<-19
spreads[spreads$schedule_week=='Conference','schedule_week']<-20
spreads[spreads$schedule_week=='Superbowl','schedule_week']<-21
spreads[spreads$schedule_week=='SuperBowl','schedule_week']<-21
spreads$schedule_week<-as.integer(spreads$schedule_week)



###################################################   PREPARE DATA FOR ANALYSIS   ##########################################################33



#adding the binary is the home team favorite? column 'homeFav'
spreads$homeFav<-0
spreads[spreads$team_home==spreads$team_favorite_id,]$homeFav<-1

#adding the score differential column 'scoreFavMinDog' SUCH THAT it is positive if the favorite wins
spreads$scoreFavMinDog=0
spreads$scoreFavMinDog<-ifelse(spreads$homeFav==1, spreads$scoreFavMinDog<-spreads$score_home-spreads$score_away, spreads$scoreFavMinDog<-spreads$score_away-spreads$score_home)

#now readjusting home favorite to be NA if neutral
spreads[spreads$stadium_neutral==TRUE,]$homeFav<-NA

#convert spread_favorite to positive number, rename it line
spreads$line<-abs(spreads$spread_favorite)
spreads = spreads %>% select(-spread_favorite)

#create Error variable: difference b/w line and result. POSITIVE means favorite covers, NEGATIVE means dog covers
spreads$Error<-spreads$scoreFavMinDog-spreads$line

#create 'who covered' variable:
spreads$whocovered<-ifelse(spreads$Error>0, spreads$whocovered<-'Favorite', ifelse(spreads$Error<0, spreads$whocovered<-'Underdog', spreads$whocovered<-'Push'))

# ADDRESS O/U
# create 'scoretotal', the sum of the score from games
spreads$scoretotal=spreads$score_home+spreads$score_away

# create OUError, realized score minus the vegas line. POSITIVE if teams scored more than vegas line, NEGATIVE if they scored less
spreads$OUError = spreads$scoretotal-spreads$over_under_line

# create 'which_hit' (similar to 'who covered')
spreads$which_hit<-ifelse(spreads$OUError>0, spreads$which_hit<-'Over', ifelse(spreads$OUError<0, spreads$which_hit<-'Under', spreads$which_hit<-'Push'))


################################################# WRITE CLEAN DATA TO NEW FILE ###################################################################

write.csv(spreads,file='NFL_Spreads_clean.csv',row.names = F)



