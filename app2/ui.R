dashboardPage(
  dashboardHeader(),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Summary", tabName = "summary", icon = icon("dashboard")),
      menuItem("Winter", tabName = "winter", icon = icon("dashboard")),
      menuItem("Summer", tabName = "summer", icon = icon("dashboard"))
    )
  ),
  dashboardBody(
    tabItems(
      # First tab content
      tabItem(tabName = "summary",
              tabBox(width = 12,
                     tabPanel("Summary",
                              fluidRow(
                                infoBoxOutput("revenue"),
                                infoBoxOutput("cancellations"),
                                
                                #box(leafletOutput("mymap"), p())
                              ),
                              fluidRow(column(4,plotlyOutput("plot1")),column(4,plotlyOutput("plot2")),column(4,plotlyOutput("plot3"))),
                              br(), br(),br(),
                     )
                     
              )
              
      ),
      
      # Second tab content
      tabItem(tabName = "winter",
              h2("winter tab content"),
              fluidRow(column(4,plotlyOutput("plot4")),column(4,plotlyOutput("plot5")),column(4,plotlyOutput("plot6"))),
              br(), br(),br(),
      ),
      # Third tab content
      tabItem(tabName = "summer",
              h2("summer tab content"),
              fluidRow(column(4,plotlyOutput("plot7")),column(4,plotlyOutput("plot8")),column(4,plotlyOutput("plot9"))),
      )
    )
    
  )
)