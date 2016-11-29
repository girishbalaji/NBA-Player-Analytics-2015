library(shiny)
library(ggplot2)
fluidPage(
  #Title for page
  titlePanel("Statistics Per NBA Team"),
  
  #Sidebar to control the input values:
  #   Type of Statistic
  #   Ordering
  sidebarLayout(
    sidebarPanel(
      # Type of Statistic
      selectInput("statistics",
                  label = "Chosen Statistic:",
                  c("Total Payroll", "Minimum Salary",
                    "Maximum Salary", "First Quartile",
                    "Median", "Third Quartile",
                    "Average", "Interquartile Range",
                    "Standard Deviation"),
                  selected = "Average"),
      # Ordering
      radioButtons("order",
                   label = "Ordering",
                   c("Ascending", "Descending"))

    ),
    # Main Panel to visualise the statistics on a 
    # plot.
    mainPanel(
      plotOutput("stats_plot")
    )
  )
)
