dashboardPage(
  dashboardHeader(title = "NFL Gambling Data"
                  #, disable = TRUE
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
              img(src='https://imagesvc.timeincapp.com/v3/fan/image?url=https://fansided.com/wp-content/uploads/getty-images/2018/02/908549714-nfc-championship-minnesota-vikings-v-philadelphia-eagles.jpg.jpg&',
                  width='95%',height='95%')
              ),
      tabItem(tabName = "spreads", # each row should represent a graph (in the box), and the tabBox next to it let's you diddle the parameters
              fluidRow( # Distribution of Error
                h3('Distribution of Error'),
                h4('Error of 0 means the spread was exactly right. A positive error means the favorite beat the spread, while negative means the underdog beat the spread.'),
                box(
                  plotOutput('spreadsDistribution')
                ),
                tabBox(
                  title = tagList(shiny::icon("gear"), "Modify Chart"),
                  tabPanel("Bins",
                           sliderInput('BinsDistSpreads',min = 5,max = 50,value = 30,step = 5,label = 'Bins:')
                           ),
                  tabPanel("By Season",
                           sliderInput('SeasonsDistSpreads',min=1979,max=2017,value=c(1979,2017),step=1,label='Seasons:',sep='')
                          ),
                  tabPanel("Other Options"
                           
                           #, checklist('TeamDistSpreads'))
              ))),
              fluidRow( # Inaccuracy by Season
                h3('Inaccuracy by Season'),
                box(
                  plotOutput('spreadsInaccuracySeason')
                ),
                tabBox(
                  title = tagList(shiny::icon("gear"), "Modify Chart"),
                  tabPanel("Type of Error",
                           radioButtons('TypeSeasonSpreads',label='Chart shows:',choices = list('Absolute'=1,'Two-Sided'=2),selected=1),
                          h5("Reminder: Two-Sided is positive if the favorite beat the spread, and negative if the underdog beat the spread.")
                          ),
                  tabPanel("Aggregating Method",
                           radioButtons('MethodSeasonSpreads',label='Points Represent:',choices=list('Mean'=1,'Median'=2,'Individual Games'=3),selected=1)
                          )
                      )
              ),
              fluidRow( # Inaccuracy by Week of Season
                h3('Inaccuracy by Week'),
                box(
                  plotOutput('spreadsInaccuracyWeek')
                ),
                tabBox(
                  title = tagList(shiny::icon("gear"), "Modify Chart"),
                  tabPanel("Type of Error",
                           radioButtons('TypeWeekSpreads',label='Chart shows:',choices = list('Absolute'=1,'Two-Sided'=2),selected=1)
                           ),
                  tabPanel("Aggregating Method",
                           radioButtons('MethodWeekSpreads',label='Points Represent:',choices=list('Mean'=1,'Median'=2,'Individual Games'=3),selected=1)
                           ),
                  h5("The vertical line represents the end of the regular season and the beginning of the playoffs")
                  )
                )
              ),
      tabItem(tabName = "overunder"
              
              )
    )
  )
)
