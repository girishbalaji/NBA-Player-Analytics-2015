library(shiny)
library(ggplot2)
function(input, output) {
  # Plotting functionality
  output$player_stats_plot <- renderPlot({
    
    # Read in the cleaned up eff salary stats csv

    player_stats_csv = read.csv('eff_salary_stats.csv')
    
    # Assign the input from UI to variables
    x_statistic = input$x_statistic
    y_statistic = input$y_statistic
    isSorted = input$sort
    player_stats_csv$player <- NULL
    
    # Vector (Dictionary to access statistics)
    stat_dict = c(1,2,3,4,5,6,7,8,9,12,11)
    names(stat_dict) = c("Total Points", "Total Rebounds",
                         "Assists", "Steals",
                         "Blocks", "Missed Field Goals",
                         "Missed Free Throws", "Turnovers",
                         "Games Played", "Efficiency Index",
                         "Salary")
    
    clean_stat_name = c("Total Points", "Total Rebounds",
                        "Assists", "Steals",
                        "Blocks", "Missed Field Goals",
                        "Missed Free Throws", "Turnovers",
                        "Games Played", "Blank_holder",
                        "Salary", "Efficiency Index")
    
    # Obtaining data values for the x-axis
    x_stat_column = stat_dict[x_statistic]
    x_stat = player_stats_csv[x_stat_column]
    
    # Obtaining data values for the y-axis
    y_stat_column = stat_dict[y_statistic]
    y_stat = player_stats_csv[y_stat_column]
    
    # Creating data frame with both axes
    df <- data.frame(x_axis = x_stat,
                     y_axis = y_stat,
                     position = player_stats_csv[10])
    
   
    # Conditional to consider if plot sorted by player position
    if(isSorted == "Yes") {
      # Plot graph as sorted by player position
      ggplot(df, aes_string(x = colnames(df[1]), y = colnames(df[2]))) +
        geom_point(aes(colour=factor(position))) +
        ggtitle(paste0(clean_stat_name[x_stat_column], 
                       " - ",
                       clean_stat_name[y_stat_column], 
                       " Statistics")) +
        scale_x_continuous(name = clean_stat_name[x_stat_column]) +
        scale_y_continuous(name = clean_stat_name[y_stat_column])

    } else {
      # Plot graph without sorting by player position
      ggplot(df, aes_string(x = colnames(df[1]), y = colnames(df[2]))) +
        geom_point() +
        ggtitle(paste0(clean_stat_name[x_stat_column], 
                       " - ",
                       clean_stat_name[y_stat_column], 
                       " Statistics")) +
        scale_x_continuous(name = clean_stat_name[x_stat_column]) +
        scale_y_continuous(name = clean_stat_name[y_stat_column])
    }
  })
  
  # Correlation Coefficient functionality
  output$correlationText <- renderText({
    
    # Read in the cleaned up eff salary stats csv
    player_stats_csv = read.csv('eff_salary_stats.csv')
    
    # Assign the input from UI to variables
    x_statistic = input$x_statistic
    y_statistic = input$y_statistic
    isSorted = input$sort
    player_stats_csv$player <- NULL
    
    # Vector (Dictionary to access statistics)
    stat_dict = c(1,2,3,4,5,6,7,8,9,12,11)
    names(stat_dict) = c("Total Points", "Total Rebounds",
                         "Assists", "Steals",
                         "Blocks", "Missed Field Goals",
                         "Missed Free Throws", "Turnovers",
                         "Games Played", "Efficiency Index",
                         "Salary")
    
    clean_stat_name = c("Total Points", "Total Rebounds",
                        "Assists", "Steals",
                        "Blocks", "Missed Field Goals",
                        "Missed Free Throws", "Turnovers",
                        "Games Played", "Blank_holder",
                        "Salary", "Efficiency Index")
    
    # Obtaining data values for the x-axis
    x_stat_column = stat_dict[x_statistic]
    x_stat = player_stats_csv[x_stat_column]

    # Obtaining data values for the y-axis
    y_stat_column = stat_dict[y_statistic]
    y_stat = player_stats_csv[y_stat_column]

    # Calculate correlation coefficient
    corr = cor(x_stat, y_stat)
    
    # Print out correlation coefficient
    paste0("Correlation Coefficient: ", corr)
  })
}
