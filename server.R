shinyServer(function(input, output) {
   
  output$spreadsDistribution <- renderPlot({
    ggplot(nfl  %>% filter(schedule_season>=input$SeasonsDistSpreads[1] & schedule_season<=input$SeasonsDistSpreads[2])
           ,aes(Error)) + geom_histogram(bins=input$BinsDistSpreads,col='black',fill='darkgreen')
  })
  
  output$spreadsInaccuracySeason <- renderPlot({
    if(input$TypeSeasonSpreads==2){
      ggplot(nfl %>% group_by(schedule_season) %>% summarise(m=mean(Error)), aes(schedule_season,m))+geom_point(color='darkgreen',size=3)+geom_hline(yintercept = 0)
    }
    else{
      ggplot(nfl %>% group_by(schedule_season) %>% summarise(m=mean(ErrMag)), aes(schedule_season,m))+geom_point(color='darkgreen',size=3)+geom_hline(yintercept = 0)
    }  
  })
  
  output$spreadsInaccuracyWeek <- renderPlot({
    if(input$TypeWeekSpreads==2){
      ggplot(nfl %>% group_by(schedule_week) %>% summarise(m=mean(Error)),aes(schedule_week,m))+geom_point(color='darkgreen',size=3)+
      geom_hline(yintercept = 0)+geom_vline(xintercept=17.5)
    }
    else{
      ggplot(nfl %>% group_by(schedule_week) %>% summarise(m=mean(ErrMag)),aes(schedule_week,m))+geom_point(color='darkgreen',size=3)+
      geom_hline(yintercept = 0)+geom_vline(xintercept=17.5)
    }
  })
  
})
