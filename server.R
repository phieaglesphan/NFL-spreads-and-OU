shinyServer(function(input, output) {
   
  spreadsResults <- reactive({ # Reactive function to choose teams in 1st chart "Results Bar Chart" (below)
    if (input$TeamsResultsSpreads!="Select All") { # A team is selected
      teamchoice=input$TeamsResultsSpreads
      team_subset <- subset(nfl, team_home == input$TeamsResultsSpreads | team_away == input$TeamsResultsSpreads)
      if(input$TeamFavResultsSpreads==2) { # If they are the favorite
        team_fav_subset <- subset(team_subset,team_favorite_id==teamchoice)
        if(input$TeamLocResultsSpreads==2){ # Favorite == home team
          team_fav_home_subset <- subset(team_fav_subset,team_home==teamchoice)
          return(team_fav_home_subset)
        }
        else if(input$TeamLocResultsSpreads==3){ # favorite = away team
          team_fav_road_subset <- subset(team_fav_subset,team_away==teamchoice)
          return(team_fav_road_subset)
        }
        else{ # NO location selected
          return(team_fav_subset)
        }
      }
      else if (input$TeamFavResultsSpreads==3) { # If they are the underdog
        team_dog_subset <- subset(team_subset,team_favorite_id!=teamchoice)
        if(input$TeamLocResultsSpreads==2){ # Dog == home team
          team_dog_home_subset <- subset(team_dog_subset,team_home==teamchoice)
          return(team_dog_home_subset)
        }
        else if(input$TeamLocResultsSpreads==3){ # Dog = away team
          team_dog_road_subset <- subset(team_dog_subset,team_away==teamchoice)
          return(team_dog_road_subset)
        }
        else{ # No location selected
          return(team_dog_subset)
        }
      }
      else{ #If the default (no filter) is chosen
        return(team_subset)
      }
    }
    else { # NO TEAM IS Selected
      if((input$TeamFavResultsSpreads==2 & input$TeamLocResultsSpreads==2)|(input$TeamFavResultsSpreads==3 & input$TeamLocResultsSpreads==3)){ #Home Fav/Road Dog
        home_fav <- subset(nfl,homeFav==1)
        return(home_fav)
      }
      else if ((input$TeamFavResultsSpreads==2 & input$TeamLocResultsSpreads==3)|(input$TeamFavResultsSpreads==3 & input$TeamLocResultsSpreads==2)){ #Road Fav/Home Dog
        road_fav <- subset(nfl,homeFav==0)
        return(road_fav)
      }
      else{ # absolutely no filters applied
        return(nfl)
      }
    }
  })
  
  
  output$spreadsResults <- renderPlot({  # RESULTS BAR CHART
    ggplot(spreadsResults() %>% filter(line>=input$LineResultsSpreads[1] & line<=input$LineResultsSpreads[2])
           %>% filter(schedule_season>=input$SeasonsResultsSpreads[1] & schedule_season<=input$SeasonsResultsSpreads[2])
          %>% filter(schedule_week>=input$WeekResultsSpreads[1] & schedule_week<=input$WeekResultsSpreads[2])
          %>% group_by(c=whocovered) %>% summarise(n=n()), aes(reorder(c,-n),n)) +
          geom_col(fill='darkgreen',color='black')+xlab('Who Covered')+ylab('Count')
  })
  
  spreadsDistribution <- reactive({ # Reactive function for teams in Spreads Histogram (below)
    if (input$TeamDistSpreads!="Select All") { # If a team is chosen
      team_subset <- subset(nfl, team_home == input$TeamDistSpreads | team_away == input$TeamDistSpreads)
      teamchoice=input$TeamDistSpreads
      if(input$TeamFavDistSpreads==2) { # If they are the favorite
        team_fav_subset <- subset(team_subset,team_favorite_id==teamchoice)
        if(input$TeamLocDistSpreads==2){ # The favorite = the home team
          team_fav_home_subset <- subset(team_fav_subset,team_home==teamchoice)
          return(team_fav_home_subset)
        }
        else if(input$TeamLocDistSpreads==3){ # The favorite = the road team
          team_fav_road_subset <- subset(team_fav_subset,team_away==teamchoice)
          return(team_fav_road_subset)
        }
        else{  #No location specified
          return(team_fav_subset)
        }
      }
      else if (input$TeamFavDistSpreads==3) { # If they are the underdog
        team_dog_subset <- subset(team_subset,team_favorite_id!=teamchoice)
        if(input$TeamLocDistSpreads==2){ # The underdog == Home team
          team_dog_home_subset <- subset(team_dog_subset,team_home==teamchoice)
          return(team_dog_home_subset)
        }
        else if(input$TeamLocDistSpreads==3){ # The underdog == roadteam
          team_dog_away_subset <- subset(team_dog_subset,team_away==teamchoice)
          return(team_dog_away_subset)
        }
        else{ # No location specified
          return(team_dog_subset)
        }
      }
      else{ #If the default (no filter) is chosen
        return(team_subset)
      }
    }
    else { # No team chosen
      if((input$TeamFavDistSpreads==2 & input$TeamLocDistSpreads==2)|(input$TeamFavDistSpreads==3 & input$TeamLocDistSpreads==3)){ #Home Fav/Road Dog
        home_fav <- subset(nfl,homeFav==1)
        return(home_fav)
      }
      else if ((input$TeamFavDistSpreads==2 & input$TeamLocDistSpreads==3)|(input$TeamFavDistSpreads==3 & input$TeamLocDistSpreads==2)){ #Road Fav/Home Dog
        road_fav <- subset(nfl,homeFav==0)
        return(road_fav)
      }
      else{ # absolutely no filters applied
        return(nfl)
      }
    }
  })
  
  output$spreadsDistribution <- renderPlot({ # HISTOGRAM FOR SPREADS ERROR
    ggplot(spreadsDistribution()  %>% filter(line>=input$LineDistSpreads[1] & line<=input$LineDistSpreads[2])
           %>% filter(schedule_season>=input$SeasonsDistSpreads[1] & schedule_season<=input$SeasonsDistSpreads[2])
           %>% filter(schedule_week>=input$WeekDistSpreads[1] & schedule_week<=input$WeekDistSpreads[2])
           ,aes(Error)) + geom_histogram(bins=input$BinsDistSpreads,col='black',fill='darkgreen') + ylab('Count')
  })
  
  spreadsInaccuracySeason <- reactive({ # Reactive function for teams in Spreads Inacc. by Season (below)
    if (input$TeamSeasonSpreads!="Select All") { # IF user did choose a team
      teamchoice=input$TeamSeasonSpreads
      team_subset <- subset(nfl, team_home == teamchoice | team_away == teamchoice)
      if(input$TeamFavSeasonSpreads==2) { # If they are the favorite
        team_fav_subset <- subset(team_subset, team_favorite_id==teamchoice)
        if(input$TeamLocSeasonSpreads==2){ # Favorite == home team
          team_fav_home_subset <- subset(team_subset, team_home==teamchoice)
          return(team_fav_home_subset)
        }
        else if(input$TeamLocSeasonSpreads==3){ # The favorite == the road team
          team_fav_road_subset <- subset(team_fav_subset,team_away==teamchoice)
          return(team_fav_road_subset)
        }
        else{ # No location specified
          return(team_fav_subset)
        }
      }
      else if (input$TeamFavSeasonSpreads==3) { # If they are the underdog
        team_dog_subset <- subset(team_subset,team_favorite_id!=teamchoice)
        if(input$TeamLocSeasonSpreads==2){ # The underdog == Home team
          team_dog_home_subset <- subset(team_dog_subset,team_home==teamchoice)
          return(team_dog_home_subset)
        }
        else if(input$TeamLocSeasonSpreads==3){ # The underdog == roadteam
          team_dog_away_subset <- subset(team_dog_subset,team_away==teamchoice)
          return(team_dog_away_subset)
        }
        else{ # No location specified
          return(team_dog_subset)
        }
      }
      else{
        return(team_subset)
      }
    }
      else { # No team chosen
        if((input$TeamFavSeasonSpreads==2 & input$TeamLocSeasonSpreads==2)|(input$TeamFavSeasonSpreads==3 & input$TeamLocSeasonSpreads==3)){ #Home Fav/Road Dog
          home_fav <- subset(nfl,homeFav==1)
          return(home_fav)
        }
        else if ((input$TeamFavSeasonSpreads==2 & input$TeamLocSeasonSpreads==3)|(input$TeamFavSeasonSpreads==3 & input$TeamLocSeasonSpreads==2)){ #Road Fav/Home Dog
          road_fav <- subset(nfl,homeFav==0)
          return(road_fav)
        }
        else{ # absolutely no filters applied
          return(nfl)
        }
      }
  })
  
 
  output$spreadsInaccuracySeason <- renderPlot({ # SCATTER PLOT FOR SPREADS BY SEASON
    if(input$TypeSeasonSpreads==1){ # Plot if two-sided error
          ggplot(spreadsInaccuracySeason() %>% filter(schedule_week>=input$WeeksSeasonSpreads[1] & schedule_week<=input$WeeksSeasonSpreads[2])
          %>% group_by(schedule_season) %>% summarise(m=mean(Error)), aes(schedule_season,m))+
          geom_point(color='darkgreen',size=4)+geom_hline(yintercept = 0)+ylab('Avg. Point Differential')+xlab('NFL Season')
    }
    else{ # Plot if absolute error
      ggplot(spreadsInaccuracySeason() %>% filter(schedule_week>=input$WeeksSeasonSpreads[1] & schedule_week<=input$WeeksSeasonSpreads[2])
             %>% group_by(schedule_season) %>% summarise(m=mean(abs(Error))), aes(schedule_season,m))+
        geom_point(color='darkgreen',size=4)+ylab('Avg. Point Differential')+xlab('NFL Season')
    }  
  })
  
  spreadsInaccuracyWeek <- reactive({ # Reactive function for teams in Spreads Inacc. by Week (below)
    if (input$TeamWeekSpreads!="Select All") { # IF the user did choose a team
      teamchoice=input$TeamWeekSpreads
      team_subset <- subset(nfl, team_home == input$TeamWeekSpreads | team_away == input$TeamWeekSpreads)
      if(input$TeamFavWeekSpreads==2){ # IF that team is the favorite
        team_fav_subset <- subset(team_subset, team_favorite_id==teamchoice)
        if(input$TeamLocWeekSpreads==2){ # Favorite == home team
          team_fav_home_subset <- subset(team_subset, team_home==teamchoice)
          return(team_fav_home_subset)
        }
        else if(input$TeamLocWeekSpreads==3){ # The favorite == the road team
          team_fav_road_subset <- subset(team_fav_subset,team_away==teamchoice)
          return(team_fav_road_subset)
        }
        else{ # No location specified
          return(team_fav_subset)
        }
      }
      else if (input$TeamFavWeekSpreads==3) { # If they are the underdog
        team_dog_subset <- subset(team_subset,team_favorite_id!=teamchoice)
        if(input$TeamLocWeekSpreads==2){ # The underdog == Home team
          team_dog_home_subset <- subset(team_dog_subset,team_home==teamchoice)
          return(team_dog_home_subset)
        }
        else if(input$TeamLocWeekSpreads==3){ # The underdog == roadteam
          team_dog_away_subset <- subset(team_dog_subset,team_away==teamchoice)
          return(team_dog_away_subset)
        }
        else{ # No location specified
          return(team_dog_subset)
        }
      }
      else{
        return(team_subset)
      }
    }
    else { # No team chosen
      if((input$TeamFavWeekSpreads==2 & input$TeamLocWeekSpreads==2)|(input$TeamFavWeekSpreads==3 & input$TeamLocWeekSpreads==3)){ #Home Fav/Road Dog
        home_fav <- subset(nfl,homeFav==1)
        return(home_fav)
      }
      else if ((input$TeamFavWeekSpreads==2 & input$TeamLocWeekSpreads==3)|(input$TeamFavWeekSpreads==3 & input$TeamLocWeekSpreads==2)){ #Road Fav/Home Dog
        road_fav <- subset(nfl,homeFav==0)
        return(road_fav)
      }
      else{ # absolutely no filters applied
        return(nfl)
      }
    }
  })

  output$spreadsInaccuracyWeek <- renderPlot({ # SCATTER PLOT FOR SPREADS BY WEEK
    if(input$TypeWeekSpreads==1){ #Plot if two-sided Error
      ggplot(spreadsInaccuracyWeek() %>% filter(schedule_season>=input$SeasonWeekSpreads[1] & schedule_season<=input$SeasonWeekSpreads[2])
             %>% group_by(schedule_week) %>% summarise(m=mean(Error)),aes(schedule_week,m))+geom_point(color='darkgreen',size=4)+
              geom_hline(yintercept = 0)+geom_vline(xintercept=17.5)+ylab('Avg. Point Differential')+xlab('Week of Schedule')
    }
    else{ #Plot if absolut Error
      ggplot(spreadsInaccuracyWeek() %>% filter(schedule_season>=input$SeasonWeekSpreads[1] & schedule_season<=input$SeasonWeekSpreads[2])
             %>% group_by(schedule_week) %>% summarise(m=mean(ErrMag)),aes(schedule_week,m))+geom_point(color='darkgreen',size=4)+
            geom_vline(xintercept=17.5)+ylab('Avg. Point Differential')+xlab('Week of Schedule')
    }
  })

############################################################  OVER / UNDER CHARTS  ############################################################
  
  OUResults <- reactive({ # Reactive function for teams in 1st chart (below)
    if (input$TeamsResultsOU!="Select All") {
      team_subset <- subset(nfl, team_home == input$TeamsResultsOU | team_away == input$TeamsResultsOU)
      return(team_subset)
    }
    else {
      return(nfl)
    }
  })
  
  output$OUResults <- renderPlot({ # BAR CHART FOR O/U RESULTS
    ggplot(OUResults() %>% filter(over_under_line>=input$LineResultsOU[1] & over_under_line<=input$LineResultsOU[2])
           %>% filter(schedule_season>=input$SeasonsResultsOU[1] & schedule_season<=input$SeasonsResultsOU[2])
           %>% filter(schedule_week>=input$WeekResultsOU[1] & schedule_week<=input$WeekResultsOU[2])
           %>% group_by(c=which_hit) %>% summarise(n=n()),aes(reorder(c,-n),n)) +
          geom_col(fill='darkgreen',color='black')+xlab('Result')+ylab('Count')
  })
  
  ouHistogram <- reactive({ # Reactive function for teams in OU Histogram (below)
    if (input$TeamDistOU!="Select All") {
      team_subset <- subset(nfl, team_home == input$TeamDistOU | team_away == input$TeamDistOU)
      return(team_subset)
    }
    else {
      return(nfl)
    }
  })
  
  output$ouHistogram <- renderPlot({ # HISTOGRAM FOR O/U 
    ggplot(ouHistogram()  %>% filter(over_under_line>=input$LineDistOU[1] & over_under_line<=input$LineDistOU[2])
            %>%  filter(schedule_season>=input$SeasonsDistOU[1] & schedule_season<=input$SeasonsDistOU[2])
           %>% filter(schedule_week>=input$WeekDistOU[1] & schedule_week<=input$WeekDistOU[2])
           ,aes(OUError)) + geom_histogram(bins=input$BinsDistOU,col='black',fill='darkgreen')+ylab('Count')+xlab('Error')
  })
  
  OUbySeason <- reactive({ # Reactive function for teams in OU Inacc. by Season (below)
    if (input$TeamSeasonOU!="Select All") {
      team_subset <- subset(nfl, team_home == input$TeamSeasonOU | team_away == input$TeamSeasonOU)
      return(team_subset)
    }
    else {
      return(nfl)
    }
  })
  
  output$OUbySeason <- renderPlot({
    if(input$TypeSeasonOU==1){ # Plot if two-sided Error
      ggplot(OUbySeason() %>% filter(!is.na(over_under_line)) %>% filter(schedule_week>=input$WeeksSeasonOU[1] & schedule_week<=input$WeeksSeasonOU[2]) 
             %>% group_by(schedule_season) %>% summarise(m=mean(OUError)),aes(schedule_season,m))+
            geom_point(color='darkgreen',size=4)+geom_hline(yintercept = 0)+ylab('Avg. Point Differential')+xlab('NFL Season')
    }
    else{ # Plot for absolute error
      ggplot(OUbySeason() %>% filter(!is.na(over_under_line)) %>% filter(schedule_week>=input$WeeksSeasonOU[1] & schedule_week<=input$WeeksSeasonOU[2]) 
             %>% group_by(schedule_season) %>% summarise(m=mean(abs(OUError))),aes(schedule_season,m))+
            geom_point(color='darkgreen',size=4)+ylab('Avg. Point Differential')+xlab('NFL Season')
    }
  })
  
  OUbyWeek <- reactive({ # Reactive function for teams in OU Inacc. by Season (below)
    if (input$TeamWeekOU!="Select All") {
      team_subset <- subset(nfl, team_home == input$TeamWeekOU | team_away == input$TeamWeekOU)
      return(team_subset)
    }
    else {
      return(nfl)
    }
  })
  
  output$OUbyWeek <- renderPlot({
    if(input$TypeWeekOU==1){ # Plot if two-sided Error
        ggplot(OUbyWeek() %>% filter(!is.na(over_under_line)) %>% filter(schedule_season>=input$SeasonWeekOU[1] & schedule_season<=input$SeasonWeekOU[2]) 
        %>% group_by(schedule_week) %>% summarise(m=mean(OUError)),aes(schedule_week,m))+
        geom_point(color='darkgreen',size=4)+geom_hline(yintercept = 0)+geom_vline(xintercept = 17.5)+ylab('Avg. Point Differential')+xlab('Week of Schedule')
    }
    else { # Plot if absolute error
        ggplot(OUbyWeek() %>% filter(!is.na(over_under_line)) %>% filter(schedule_season>=input$SeasonWeekOU[1] & schedule_season<=input$SeasonWeekOU[2]) 
        %>% group_by(schedule_week) %>% summarise(m=mean(abs(OUError))),aes(schedule_week,m))+
        geom_point(color='darkgreen',size=4)+geom_vline(xintercept = 17.5)+ylab('Avg. Point Differential')+xlab('Week of Schedule')
    }
  })
})

