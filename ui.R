dashboardPage( skin='black',
  dashboardHeader(title = "NFL Gambling Data"
                  ),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Background", tabName = "background"
               ),
      menuItem("Spreads", tabName = "spreads"
               ),
      menuItem("Over/Under",tabName = "overunder"
               )
  )),
  dashboardBody(
    tabItems(
      tabItem(tabName="background",
            fluidRow(
              h3('Introduction to NFL Gambling'),
              h5(intro),
              h3('The Data'),
              h5(thedata),
              img(src='https://imagesvc.timeincapp.com/v3/fan/image?url=https://fansided.com/wp-content/uploads/getty-images/2018/02/908549714-nfc-championship-minnesota-vikings-v-philadelphia-eagles.jpg.jpg&',
                  width='100%',height='100%')
              )),
      tabItem(tabName = "spreads", 
              fluidRow( # Results Bar Chart
                h3('Spread Results'),
                h5('Examining the outcome of real game scores vs. the spread'),
                box(
                  plotOutput('spreadsResults')
                ),
                tabBox(
                  title = tagList(shiny::icon("gear"), "Modify Chart"),
                  tabPanel('By Line',
                           sliderInput('LineResultsSpreads',min=0,max=27,value=c(0,27),step=1,label='Filtering by Magnitude of Line:')
                  ),
                  tabPanel('By Team',
                           selectizeInput('TeamsResultsSpreads', label='Team:',choices=c("Select All", sort(unique(nfl$team_home))), selected="Select All"),
                           h5('When you select a team, you can also select which side of the spread they were on.'),
                           radioButtons('TeamFavResultsSpreads',label='Selected Team As:',choices=list('(All Games)'=1,'Favorite'=2,'Underdog'=3),selected=1),
                           h5('You can also select where the games were played.'),
                           radioButtons('TeamLocResultsSpreads',label='Games Played:',choices=list('(Everywhere)'=1,'At Home'=2,'On the Road'=3),selected=1),
                           h5("If you don't specify a team, you still can choose a side-of-spread/location combination (ex: Favorite/On the road, 
                              which is equivalent to Underdog/At Home).")
                  ),
                  tabPanel("By Season",
                           sliderInput('SeasonsResultsSpreads',min=1979,max=2017,value=c(1979,2017),step=1,label='Seasons:',sep='')
                  ),
                  tabPanel('By Week',
                           sliderInput('WeekResultsSpreads', min=1,max=21,value=c(1,21),step=1,label='Weeks:'),
                           h5('Weeks 1 - 17: Regular Season'),
                           h5('Week 18: Wildcard Round'),
                           h5('Week 19: Divisional Round'),
                           h5('Week 20: Conference Championships'),
                           h5('Week 21: Super Bowl'))
                )
                           
              ),
              fluidRow( # Distribution of Error
                h3('Distribution of Error'),
                h5('Error of 0 means the spread was exactly right. A positive error means the favorite beat the spread, while negative means the underdog beat the spread.'),
                box(
                  plotOutput('spreadsDistribution')
                ),
                tabBox(
                  title = tagList(shiny::icon("gear"), "Modify Chart"),
                  tabPanel("Bins",
                           sliderInput('BinsDistSpreads',min = 0.5,max = 10,value = 3,step = 0.5,label = 'Number of Points Each Bin Represents:')
                           ),
                  tabPanel('Show Mean',
                           checkboxInput("MeanCheckSpreads", label = "Show Mean Line", value = FALSE)
                  ),
                  tabPanel('By Line',
                           sliderInput('LineDistSpreads',min=0,max=27,value=c(0,27),step=1,label='Filtering by Magnitude of Line:')
                           ),
                  tabPanel('By Team',
                           selectizeInput('TeamDistSpreads', label='Team:',choices=c("Select All", sort(unique(nfl$team_home))), selected="Select All"),
                           h5('When you select a team, you can also select which side of the spread they were on.'),
                           radioButtons('TeamFavDistSpreads',label='Selected Team As:',choices=list('(All Games)'=1,'Favorite'=2,'Underdog'=3),selected=1),
                           h5('You can also select where the games were played.'),
                           radioButtons('TeamLocDistSpreads',label='Games Played:',choices=list('(Everywhere)'=1,'At Home'=2,'On the Road'=3),selected=1),
                           h5("If you don't specify a team, you still can choose a side-of-spread/location combination (ex: Favorite/On the road, 
                              which is equivalent to Underdog/At Home).")
                  ),
                  tabPanel("By Season",
                           sliderInput('SeasonsDistSpreads',min=1979,max=2017,value=c(1979,2017),step=1,label='Seasons:',sep='')
                          ),
                  tabPanel('By Week',
                           sliderInput('WeekDistSpreads', min=1,max=21,value=c(1,21),step=1,label='Weeks:'),
                           h5('Weeks 1 - 17: Regular Season'),
                           h5('Week 18: Wildcard Round'),
                           h5('Week 19: Divisional Round'),
                           h5('Week 20: Conference Championships'),
                           h5('Week 21: Super Bowl')
                           )
                    )
                ),
              fluidRow( # SPREADS - Inaccuracy by Season
                h3('Inaccuracy by Season'),
                h5('Each dot represents the average difference from the realized spread to the line offered by Vegas of every game, by season.'),
                h5("Two-Sided Error is positive if the favorite beat the spread, and is negative if the underdog beat the spread."),
                box(
                  plotOutput('spreadsInaccuracySeason')
                ),
                tabBox(
                  title = tagList(shiny::icon("gear"), "Modify Chart"),
                  tabPanel("Type of Error",
                           radioButtons('TypeSeasonSpreads',label='Chart Shows:',choices = list('Two-Sided Error'=1,'Absolute Error'=2),selected=1)
                          ),
                  tabPanel('By Team',
                           selectizeInput('TeamSeasonSpreads', label='Team:',choices=c("Select All", sort(unique(nfl$team_home))), selected="Select All"),
                           h5('When you select a team, you can also select which side of the spread they were on.'),
                           radioButtons('TeamFavSeasonSpreads',label='Selected Team As:',choices=list('(All Games)'=1,'Favorite'=2,'Underdog'=3),selected=1),
                           h5('You can also select where the games were played.'),
                           radioButtons('TeamLocSeasonSpreads',label='Games Played:',choices=list('(Everywhere)'=1,'At Home'=2,'On the Road'=3),selected=1),
                           h5("If you don't specify a team, you still can choose a side-of-spread/location combination (ex: Favorite/On the road, 
                              which is equivalent to Underdog/At Home).")
                           ),
                  tabPanel("Filter Weeks",
                            sliderInput('WeeksSeasonSpreads', min=1,max=21,value=c(1,21),step=1,label='Filter Data to Only Include These Weeks:'),
                            h5('Weeks 1 - 17: Regular Season'),
                            h5('Weeks 18 - 21: Playoffs'),
                            h5('NOTE: The 17-week regular season format was not adopted until 1990 (was previously 16 games).'),
                            h5('Additionally, the 1982 season was strike-shortened and only consisted of the first 9 regular season weeks.')
                           )
                      )
              ),
              fluidRow( # SPREADS - Inaccuracy by Week of Season
                h3('Inaccuracy by Week'),
                h5('Each dot represents the average difference from the realized spread to the line offered by Vegas of every season, by the weekly schedule.'),
                h5("Two-Sided Error is positive if the favorite beat the spread, and is negative if the underdog beat the spread."),
                box(
                  plotOutput('spreadsInaccuracyWeek')
                ),
                tabBox(
                  title = tagList(shiny::icon("gear"), "Modify Chart"),
                  tabPanel("Type of Error",
                           radioButtons('TypeWeekSpreads',label='Chart Shows:',choices = list('Two-Sided Error'=1,'Absolute Error'=2),selected=1)
                           ),
                  tabPanel('By Team',
                           selectizeInput('TeamWeekSpreads', label='Team:',choices=c("Select All", sort(unique(nfl$team_home))), selected="Select All"),
                           h5('When you select a team, you can also select which side of the spread they are on.'),
                           radioButtons('TeamFavWeekSpreads',label='Selected Team As:',choices=list('(All Games)'=1,'Favorite'=2,'Underdog'=3),selected=1),
                           h5('You can also select where the games were played.'),
                           radioButtons('TeamLocWeekSpreads',label='Games Played:',choices=list('(Everywhere)'=1,'At Home'=2,'On the Road'=3),selected=1),
                           h5("If you don't specify a team, you still can choose a side-of-spread/location combination (ex: Favorite/On the road, 
                              which is equivalent to Underdog/At Home).")
                  ),
                  tabPanel("Filter Seasons",
                            sliderInput('SeasonWeekSpreads',min=1979,max=2017,value=c(1979,2017),step=1,label='Filter Data to Only Include These Seasons:',sep='')
                           ),
                  h5("NOTE: The vertical line represents the end of the regular season and the beginning of the playoffs.")
                  )
                )
              ),
     
##############################################################  O/U #############################################################################################      
      
       tabItem(tabName = "overunder", # THE O/U PAGE
              fluidRow(   # OU Results
                h3('Over/Under Results'),
                h5('Examining the outcome of real game scores vs. the Over/Under'),
                box(
                  plotOutput('OUResults')
                ),
                tabBox(
                  title = tagList(shiny::icon("gear"), "Modify Chart"),
                  tabPanel('By Line',
                           sliderInput('LineResultsOU',min=28,max=63,value=c(28,63),step=1,label='Filtering by Magnitude of Line:')
                  ),
                  tabPanel('By Team',
                           selectizeInput('TeamsResultsOU', label='Team:',choices=c("Select All", sort(unique(nfl$team_home))), selected="Select All")
                  ),
                  tabPanel("By Season",
                           sliderInput('SeasonsResultsOU',min=1979,max=2017,value=c(1979,2017),step=1,label='Seasons:',sep='')
                  ),
                  tabPanel('By Week',
                           sliderInput('WeekResultsOU', min=1,max=21,value=c(1,21),step=1,label='Weeks:'),
                           h5('Weeks 1 - 17: Regular Season'),
                           h5('Week 18: Wildcard Round'),
                           h5('Week 19: Divisional Round'),
                           h5('Week 20: Conference Championships'),
                           h5('Week 21: Super Bowl')
                  )
                )
              ),
              fluidRow(   # OU Distribution of Error
                h3('Distribution of Error'),
                h5('Error of 0 means the O/U was exactly right. A positive error means the score was higher than the offered O/U line, while negative means the actual score was lower.'),
                box(
                  plotOutput('ouHistogram')
                ),
                tabBox(
                  title = tagList(shiny::icon("gear"), "Modify Chart"),
                  tabPanel("Bins",
                           sliderInput('BinsDistOU',min = 0.5,max = 10,value = 3,step = 0.5,label = 'Number of Points Each Bin Represents:')
                  ),
                  tabPanel('Show Mean',
                           checkboxInput("MeanCheckOU", label = "Show Mean Line", value = FALSE)
                  ),
                  tabPanel('By Line',
                           sliderInput('LineDistOU', min=28,max=63,value=c(28,63),step=1,label='Filtering by Line Offered:')
                  ),
                  tabPanel('By Team',
                           selectizeInput('TeamDistOU', label='Team:',choices=c("Select All", sort(unique(nfl$team_home))), selected="Select All")
                  ),
                  tabPanel("By Season",
                           sliderInput('SeasonsDistOU',min=1979,max=2017,value=c(1979,2017),step=1,label='Seasons:',sep='')
                  ),
                  tabPanel('By Week',
                           sliderInput('WeekDistOU', min=1,max=21,value=c(1,21),step=1,label='Weeks:'),
                           h5('Weeks 1 - 17: Regular Season'),
                           h5('Week 18: Wildcard Round'),
                           h5('Week 19: Divisional Round'),
                           h5('Week 20: Conference Championships'),
                           h5('Week 21: Super Bowl')
                  )
                )
              ),
              fluidRow( # O/U by Season
                h3('Inaccuracy by Season'),
                h5('Each dot represents the average difference from the realized Over/Under to the line offered by Vegas of every game, by season.'),
                h5("Two-Sided Error is positive if the realized score was higher than the offered O/U line, and is negative if lower."),
                box(
                  plotOutput('OUbySeason')
                ),
                tabBox(
                  title = tagList(shiny::icon("gear"), "Modify Chart"),
                  tabPanel('Type of Error',
                      radioButtons('TypeSeasonOU',label='Chart Shows:',choices = list('Two-Sided Error'=1,'Absolute Error'=2),selected=1)
                          ),
                  tabPanel('By Team',
                           selectizeInput('TeamSeasonOU', label='Team:',choices=c("Select All", sort(unique(nfl$team_home))), selected="Select All")
                  ),
                  tabPanel('Filter Weeks',
                           sliderInput('WeeksSeasonOU', min=1,max=21,value=c(1,21),step=1,label='Filter Data to Only Include These Weeks:'),
                           h5('Weeks 1 - 17: Regular Season'),
                           h5('Weeks 18 - 21: Playoffs'),
                           h5('NOTE: The 17-week regular season format was not adopted until 1990 (was previously 16 games).'),
                           h5('Additionally, the 1982 season was strike-shortened and only consisted of the first 9 regular season weeks.')
                  )
                )
              ),
              fluidRow( # O/U by Week
                h3('Inaccuracy by Week'),
                h5('Each dot represents the average difference from the realized Over/Under to the line offered by Vegas of every season, by the weekly schedule.'),
                h5("Two-Sided Error is positive if the realized score was higher than the offered O/U line, and is negative if lower."),
                box(
                  plotOutput('OUbyWeek')
                ),
                tabBox(
                  title = tagList(shiny::icon("gear"), "Modify Chart"),
                  tabPanel('Type of Error',
                    radioButtons('TypeWeekOU',label='Chart Shows:',choices = list('Two-Sided Error'=1,'Absolute Error'=2),selected=1)
                  ),
                  tabPanel('By Team',
                           selectizeInput('TeamWeekOU', label='Team:',choices=c("Select All", sort(unique(nfl$team_home))), selected="Select All")
                  ),
                  tabPanel("Filter Seasons",
                    sliderInput('SeasonWeekOU',min=1979,max=2017,value=c(1979,2017),step=1,label='Filter Data to Only Include These Seasons:',sep='')
                    ),
                  h5("NOTE: The vertical line represents the end of the regular season and the beginning of the playoffs.")
                  )
                )
              
          )
    )
  )
)

