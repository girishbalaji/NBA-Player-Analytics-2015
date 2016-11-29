#EFF
server <- function(input, output) {
  output$player_stats_plot <- renderPlot({
    player_stats_csv = read.csv("data/cleandata/eff_salary_stats.csv")
    x_statistic = input$x_statistic
    y_statistic = input$y_statistic
    isSorted = input$sort
    player_stats_csv$player <- NULL
    
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
    
    x_stat_column = stat_dict[x_statistic]
    x_stat = player_stats_csv[x_stat_column]
#    x_stat = player_stats_csv[12]

    
    
    y_stat_column = stat_dict[y_statistic]
    y_stat = player_stats_csv[y_stat_column]
#    y_stat = player_stats_csv[11]
    
    df <- data.frame(x_axis = x_stat,
                     y_axis = y_stat,
                     position = player_stats_csv[10])

    if(isSorted == "Yes") {
      ggplot(df, aes_string(x = colnames(df[1]), y = colnames(df[2]))) +
        geom_point(aes(colour=factor(position))) +
        ggtitle(paste0(clean_stat_name[x_stat_column], 
                       " - ",
                       clean_stat_name[y_stat_column], 
                       " Statistics")) +
        scale_x_continuous(name = clean_stat_name[x_stat_column]) +
        scale_y_continuous(name = clean_stat_name[y_stat_column])
    } else {
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
  output$correlationText <- renderText({
    player_stats_csv = read.csv("data/cleandata/eff_salary_stats.csv")
    x_statistic = input$x_statistic
    y_statistic = input$y_statistic
    isSorted = input$sort
    player_stats_csv$player <- NULL
    
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
    
    x_stat_column = stat_dict[x_statistic]
    x_stat = player_stats_csv[x_stat_column]

    
    y_stat_column = stat_dict[y_statistic]
    y_stat = player_stats_csv[y_stat_column]

    corr = cor(x_stat, y_stat)
    paste0("Correlation Coefficient: ", corr)
  })
}

shinyApp(ui = ui, server = server)

