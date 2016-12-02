
fluidPage(
  #Title for page
  titlePanel("EFF - Statistics - Salary in NBA"),
  
  # Sidebar to control the input values:
  #     x-axis statistic
  #     y-axis statistic
  #     Sort by position
  sidebarLayout(
    sidebarPanel(
      
      # Type of X Statistic
      selectInput("x_statistic",
                  label = "Chosen X-axis Statistic:",
                  c("Total Points", "Total Rebounds",
                    "Assists", "Steals",
                    "Blocks", "Missed Field Goals",
                    "Missed Free Throws", "Turnovers",
                    "Games Played", "Efficiency Index",
                    "Salary"), 
                  selected = "Efficiency Index"),
      
      # Type of Y Statistic
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
      # Visualise plot
      plotOutput("player_stats_plot"),
      # Correlation Coefficient
      textOutput("correlationText")
    )
  )
)
