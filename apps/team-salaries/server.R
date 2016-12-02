library(shiny)
library(ggplot2)
function(input, output) {
  output$stats_plot <- renderPlot({
    # Read in the clean team salaries data from csv
    stat_csv = read.csv('team-salaries.csv')
    # Variables to store the inputs from the UI
    statistic = input$statistics
    ordering = input$order
    # Vector (Dictionary to access statistics)
    stat_dict = c(2:10)
    names(stat_dict) = c("Total Payroll", "Minimum Salary",
                         "Maximum Salary", "First Quartile",
                         "Median", "Third Quartile",
                         "Average", "Interquartile Range",
                         "Standard Deviation")
    
    
    clean_stat_name = c("Total Payroll", "Minimum Salary",
                        "Maximum Salary", "First Quartile",
                        "Median", "Third Quartile",
                        "Average", "Interquartile Range",
                        "Standard Deviation")
    
    # Accessing the required statistics from the csv
    current_stat_column = stat_dict[statistic]
    current_stat = stat_csv[current_stat_column]
    
    # Creating data frame
    df <- data.frame(Teams = stat_csv[1],
                     Stat = current_stat)
    
    # Conditional to consider ordering
    if(ordering == "Ascending") {
      xorder= paste0("reorder(team_name, ", 
                     colnames(df[2]),")")
    } else {
      xorder= paste0("reorder(team_name, -", 
                     colnames(df[2]),")")
    }
    
    # Plot the requested statistics
    ggplot(df, aes_string(x = xorder, y = colnames(df[2]))) +
      geom_bar(stat = "identity") +
      coord_flip() + scale_x_discrete(name = "Team Name") +
      scale_y_continuous(name = 
                    clean_stat_name[current_stat_column - 1]) +
      ggtitle(paste0(clean_stat_name[current_stat_column - 1],
                     " per NBA Team"))
    
  })
}
