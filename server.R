shinyServer(function(input, output) {
   
  output$spreadsResults <- renderPlot({  # RESULTS BAR CHART
    ggplot(nfl %>% filter(line>=input$LineResultsSpreads[1] & line<=input$LineResultsSpreads[2])
           %>% filter(schedule_season>=input$SeasonsResultsSpreads[1] & schedule_season<=input$SeasonsResultsSpreads[2])
          %>% filter(schedule_week>=input$WeekResultsSpreads[1] & schedule_week<=input$WeekResultsSpreads[2])
          %>% group_by(c=sign(Error)) %>% summarise(n=length(sign(Error))),aes(reorder(c,-n),n)) +
          geom_col(fill='darkgreen',color='black')+xlab('Result')+ylab('Count')
  })
  
  output$spreadsDistribution <- renderPlot({ # HISTOGRAM FOR SPREADS ERROR
    ggplot(nfl  %>% filter(line>=input$LineDistSpreads[1] & line<=input$LineDistSpreads[2])
           %>% filter(schedule_season>=input$SeasonsDistSpreads[1] & schedule_season<=input$SeasonsDistSpreads[2])
           %>% filter(schedule_week>=input$WeekDistSpreads[1] & schedule_week<=input$WeekDistSpreads[2])
           ,aes(Error)) + geom_histogram(bins=input$BinsDistSpreads,col='black',fill='darkgreen') + ylab('Count')
  })
  
  output$spreadsInaccuracySeason <- renderPlot({ # SCATTER PLOT FOR SPREADS BY SEASON
    if(input$TypeSeasonSpreads==2){ # Plot if two-sided error
          ggplot(nfl %>% filter(schedule_week>=input$WeeksSeasonSpreads[1] & schedule_week<=input$WeeksSeasonSpreads[2])
          %>% group_by(schedule_season) %>% summarise(m=mean(Error)), aes(schedule_season,m))+
          geom_point(color='darkgreen',size=4)+geom_hline(yintercept = 0)+ylab('Avg. Point Differential')+xlab('NFL Season')
    }
    else{ # Plot if absolute error
      ggplot(nfl %>% filter(schedule_week>=input$WeeksSeasonSpreads[1] & schedule_week<=input$WeeksSeasonSpreads[2])
             %>% group_by(schedule_season) %>% summarise(m=mean(ErrMag)), aes(schedule_season,m))+
        geom_point(color='darkgreen',size=4)+ylab('Avg. Point Differential')+xlab('NFL Season')
    }  
  })
  
  output$spreadsInaccuracyWeek <- renderPlot({ # SCATTER PLOT FOR SPREADS BY WEEK
    if(input$TypeWeekSpreads==2){ #Plot if two-sided Error
      ggplot(nfl %>% filter(schedule_season>=input$SeasonWeekSpreads[1] & schedule_season<=input$SeasonWeekSpreads[2])
             %>% group_by(schedule_week) %>% summarise(m=mean(Error)),aes(schedule_week,m))+geom_point(color='darkgreen',size=4)+
              geom_hline(yintercept = 0)+geom_vline(xintercept=17.5)+ylab('Avg. Point Differential')+xlab('Week of Schedule')
    }
    else{ #Plot if absolut Error
      ggplot(nfl %>% filter(schedule_season>=input$SeasonWeekSpreads[1] & schedule_season<=input$SeasonWeekSpreads[2])
             %>% group_by(schedule_week) %>% summarise(m=mean(ErrMag)),aes(schedule_week,m))+geom_point(color='darkgreen',size=4)+
            geom_vline(xintercept=17.5)+ylab('Avg. Point Differential')+xlab('Week of Schedule')
    }
  })

############################################################  OVER / UNDER CHARTS  ############################################################
  
  output$OUResults <- renderPlot({ # BAR CHART FOR O/U RESULTS
    ggplot(nfl %>% filter(over_under_line>=input$LineResultsOU[1] & over_under_line<=input$LineResultsOU[2])
           %>% filter(schedule_season>=input$SeasonsResultsOU[1] & schedule_season<=input$SeasonsResultsOU[2])
           %>% filter(schedule_week>=input$WeekResultsOU[1] & schedule_week<=input$WeekResultsOU[2])
           %>% group_by(c=sign(OUError)) %>% summarise(n=length(sign(OUError))),aes(reorder(c,-n),n)) +
          geom_col(fill='darkgreen',color='black')+xlab('Result')+ylab('Count')
  })
  
  output$ouHistogram <- renderPlot({ # HISTOGRAM FOR O/U 
    ggplot(nfl  %>% filter(over_under_line>=input$LineDistOU[1] & over_under_line<=input$LineDistOU[2])
            %>%  filter(schedule_season>=input$SeasonsDistOU[1] & schedule_season<=input$SeasonsDistOU[2])
           %>% filter(schedule_week>=input$WeekDistOU[1] & schedule_week<=input$WeekDistOU[2])
           ,aes(OUError)) + geom_histogram(bins=input$BinsDistOU,col='black',fill='darkgreen')+ylab('Count')+xlab('Error')
  })
  
  output$OUbySeason <- renderPlot({
    if(input$TypeSeasonOU==2){ # Plot if two-sided Error
      ggplot(nfl %>% filter(!is.na(over_under_line)) %>% filter(schedule_week>=input$WeeksSeasonOU[1] & schedule_week<=input$WeeksSeasonOU[2]) 
             %>% group_by(schedule_season) %>% summarise(m=mean(OUError)),aes(schedule_season,m))+
            geom_point(color='darkgreen',size=4)+geom_hline(yintercept = 0)+ylab('Avg. Point Differential')+xlab('NFL Season')
    }
    else{ # Plot for absolute error
      ggplot(nfl %>% filter(!is.na(over_under_line)) %>% filter(schedule_week>=input$WeeksSeasonOU[1] & schedule_week<=input$WeeksSeasonOU[2]) 
             %>% group_by(schedule_season) %>% summarise(m=mean(abs(OUError))),aes(schedule_season,m))+
            geom_point(color='darkgreen',size=4)+ylab('Avg. Point Differential')+xlab('NFL Season')
    }
  })
  
  output$OUbyWeek <- renderPlot({
    if(input$TypeWeekOU==2){ # Plot if two-sided Error
        ggplot(nfl %>% filter(!is.na(over_under_line)) %>% filter(schedule_season>=input$SeasonWeekOU[1] & schedule_season<=input$SeasonWeekOU[2]) 
        %>% group_by(schedule_week) %>% summarise(m=mean(OUError)),aes(schedule_week,m))+
        geom_point(color='darkgreen',size=4)+geom_hline(yintercept = 0)+geom_vline(xintercept = 17.5)+ylab('Avg. Point Differential')+xlab('Week of Schedule')
    }
    else { # Plot if absolute error
        ggplot(nfl %>% filter(!is.na(over_under_line)) %>% filter(schedule_season>=input$SeasonWeekOU[1] & schedule_season<=input$SeasonWeekOU[2]) 
        %>% group_by(schedule_week) %>% summarise(m=mean(abs(OUError))),aes(schedule_week,m))+
        geom_point(color='darkgreen',size=4)+geom_vline(xintercept = 17.5)+ylab('Avg. Point Differential')+xlab('Week of Schedule')
    }
  })
})

