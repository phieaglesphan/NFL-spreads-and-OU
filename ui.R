dashboardPage(
  dashboardHeader(title = "NFL Gambling Data"
                  ),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Background", tabName = "background"
               #, icon = icon()
               ),
      menuItem("Spreads", tabName = "spreads"
               #, icon = icon()
               ),
      menuItem("Over/Under",tabName = "overunder"
               #, icon = icon()
               )
  )),
  dashboardBody(
    tabItems(
      tabItem(tabName="background",
            fluidRow(
              h3('A Brief Introduction of NFL Gambling'),
              h5(intro),
              h3('The Data'),
              h5(thedata),
              h3("Author's Note"),
              h5(note),
              img(src='https://imagesvc.timeincapp.com/v3/fan/image?url=https://fansided.com/wp-content/uploads/getty-images/2018/02/908549714-nfc-championship-minnesota-vikings-v-philadelphia-eagles.jpg.jpg&',
                  width='100%',height='100%')
              )),
      tabItem(tabName = "spreads", # each row should represent a graph (in the box), and the tabBox next to it let's you diddle the parameters
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
                  tabPanel("By Season",
                           sliderInput('SeasonsResultsSpreads',min=1979,max=2017,value=c(1979,2017),step=1,label='Seasons:',sep='')
                  ),
                  tabPanel('By Week',
                           sliderInput('WeekResultsSpreads', min=1,max=21,value=c(1,21),step=1,label='Weeks:'),
                           h5('Weeks 1 - 17: Regular Season'),
                           h5('Week 18: Wildcard Round'),
                           h5('Week 19: Divisional Round'),
                           h5('Week 20: Conference Championships'),
                           h5('Week 21: Super Bowl')),
                  tabPanel('By Team'
                           #selectInput('TeamsResultsSpreads', value=teams)
                           )
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
                           sliderInput('BinsDistSpreads',min = 5,max = 50,value = 30,step = 5,label = 'Number of Bins for Histogram:')
                           ),
                  tabPanel('By Line',
                           sliderInput('LineDistSpreads',min=0,max=27,value=c(0,27),step=1,label='Filtering by Magnitude of Line:')
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
                           h5('Week 21: Super Bowl')),
                  tabPanel("Other Options"
                           
                           #, checklist('TeamDistSpreads'))
              ))),
              fluidRow( # SPREADS - Inaccuracy by Season
                h3('Inaccuracy by Season'),
                h5('Each dot represents the average difference from the realized spread to the line offered by Vegas of every game, by season'),
                box(
                  plotOutput('spreadsInaccuracySeason')
                ),
                tabBox(
                  title = tagList(shiny::icon("gear"), "Modify Chart"),
                  tabPanel("Type of Error",
                           radioButtons('TypeSeasonSpreads',label='Chart Shows:',choices = list('Absolute Error'=1,'Two-Sided Error'=2),selected=1),
                          h5("REMINDER: Two-Sided Error is positive if the favorite beat the spread, and is negative if the underdog beat the spread.")
                          ),
                  tabPanel("Filter Weeks",
                            sliderInput('WeeksSeasonSpreads', min=1,max=21,value=c(1,21),step=1,label='Filter Data to Only Include These Weeks:'),
                            h5('Weeks 1 - 17: Regular Season'),
                            h5('Weeks 18 - 21: Playoffs'),
                            h5('NOTE: The 17-week regular season format was not adopted until 1990 (was previously 16 games).'),
                            h5('Additionally, the 1982 season was strike-shortened and only consisted of the first 9 regular season weeks.')
                           ),
                  tabPanel("Aggregating Method",
                           radioButtons('MethodSeasonSpreads',label='Points Represent:',choices=list('Mean'=1,'Median'=2,'Individual Games'=3),selected=1)
                          )
                      )
              ),
              fluidRow( # SPREADS - Inaccuracy by Week of Season
                h3('Inaccuracy by Week'),
                h5('Each dot represents the average difference from the realized spread to the line offered by Vegas of every season, by the weekly schedule'),
                box(
                  plotOutput('spreadsInaccuracyWeek')
                ),
                tabBox(
                  title = tagList(shiny::icon("gear"), "Modify Chart"),
                  tabPanel("Type of Error",
                           radioButtons('TypeWeekSpreads',label='Chart Shows:',choices = list('Absolute Error'=1,'Two-Sided Error'=2),selected=1),
                           h5("REMINDER: Two-Sided Error is positive if the favorite beat the spread, and is negative if the underdog beat the spread.")
                           ),
                  tabPanel("Filter Seasons",
                            sliderInput('SeasonWeekSpreads',min=1979,max=2017,value=c(1979,2017),step=1,label='Filter Data to Only Include These Seasons:',sep='')
                           ),
                  tabPanel("Aggregating Method",
                           radioButtons('MethodWeekSpreads',label='Points Represent:',choices=list('Mean'=1,'Median'=2,'Individual Games'=3),selected=1)
                           ),
                  h5("NOTE: The vertical line represents the end of the regular season and the beginning of the playoffs.")
                  )
                )
              ),
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
                  tabPanel("By Season",
                           sliderInput('SeasonsResultsOU',min=1979,max=2017,value=c(1979,2017),step=1,label='Seasons:',sep='')
                  ),
                  tabPanel('By Week',
                           sliderInput('WeekResultsOU', min=1,max=21,value=c(1,21),step=1,label='Weeks:'),
                           h5('Weeks 1 - 17: Regular Season'),
                           h5('Week 18: Wildcard Round'),
                           h5('Week 19: Divisional Round'),
                           h5('Week 20: Conference Championships'),
                           h5('Week 21: Super Bowl')),
                  tabPanel('By Team')
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
                           sliderInput('BinsDistOU',min = 5,max = 50,value = 30,step = 5,label = 'Number of Bins for Histogram:')
                  ),
                  tabPanel('By Line',
                           sliderInput('LineDistOU', min=28,max=63,value=c(28,63),step=1,label='Filtering by Line Offered:')
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
                           h5('Week 21: Super Bowl')),
                  tabPanel("Other Options")
                )
              ),
              fluidRow( # O/U by Season
                h3('Inaccuracy by Season'),
                h5('Each dot represents the average difference from the realized Over/Under to the line offered by Vegas of every game, by season'),
                box(
                  plotOutput('OUbySeason')
                ),
                tabBox(
                  title = tagList(shiny::icon("gear"), "Modify Chart"),
                  tabPanel('Type of Error',
                      radioButtons('TypeSeasonOU',label='Chart Shows:',choices = list('Absolute Error'=1,'Two-Sided Error'=2),selected=1),
                      h5("REMINDER: Two-Sided Error is positive if the realized score was higher than the offered O/U line, and is negative if lower.")
                          ),
                  tabPanel('Filter Weeks',
                           sliderInput('WeeksSeasonOU', min=1,max=21,value=c(1,21),step=1,label='Filter Data to Only Include These Weeks:'),
                           h5('Weeks 1 - 17: Regular Season'),
                           h5('Weeks 18 - 21: Playoffs'),
                           h5('NOTE: The 17-week regular season format was not adopted until 1990 (was previously 16 games).'),
                           h5('Additionally, the 1982 season was strike-shortened and only consisted of the first 9 regular season weeks.')),
                  tabPanel('Other Options')
                )
              ),
              fluidRow( # O/U by Week
                h3('Inaccuracy by Week'),
                h5('Each dot represents the average difference from the realized Over/Under to the line offered by Vegas of every season, by the weekly schedule'),
                box(
                  plotOutput('OUbyWeek')
                ),
                tabBox(
                  title = tagList(shiny::icon("gear"), "Modify Chart"),
                  tabPanel('Type of Error',
                    radioButtons('TypeWeekOU',label='Chart Shows:',choices = list('Absolute Error'=1,'Two-Sided Error'=2),selected=1),
                    h5("REMINDER: Two-Sided Error is positive if the realized score was higher than the offered O/U line, and is negative if lower.")
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
