
fluidPage(
  #Title for page
  titlePanel("EFF - Statistics - Salary in NBA"),
  
  sidebarLayout(
    sidebarPanel(
      
      selectInput("x_statistic",
                  label = "Chosen X-axis Statistic:",
                  c("Total Points", "Total Rebounds",
                    "Assists", "Steals",
                    "Blocks", "Missed Field Goals",
                    "Missed Free Throws", "Turnovers",
                    "Games Played", "Efficiency Index",
                    "Salary"), 
                  selected = "Efficiency Index"),
      
      selectInput("y_statistic",
                  label = "Chosen Y-axis Statistic:",
                  c("Total Points", "Total Rebounds",
                    "Assists", "Steals",
                    "Blocks", "Missed Field Goals",
                    "Missed Free Throws", "Turnovers",
                    "Games Played", "Efficiency Index",
                    "Salary"), 
                  selected = "Salary"),
      # Sorting
      radioButtons("sort",
                   label = "Sort by position?",
                   c("Yes", "No"))
      
    ),
    # Main Panel to visualise the statistics on a 
    # plot.
    mainPanel(
      plotOutput("player_stats_plot"),
      textOutput("correlationText")
    )
  )
)
