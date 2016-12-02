# cleans all the data tables and combines into one major table for analysis.
library(dplyr)
library(XML)
library(stringr)

source("code/functions/clean-data-functions.R")

#
# Run the clean_data function to clean all the data that is in the raw data
# folder. Essentially merges all the roster, salary, and stats data
# Then cleans the types and sets good column names
#
#
clean_data <- function() {
  all_players <- merge_data()
  all_players <- clean_numeric_data(all_players)
  all_players <- clean_datetime_data(all_players)
  all_players <- clean_col_names(all_players)
  all_players <- clean_bad_positions(all_players)
  write.csv(
    all_players,
    file = paste0('data/cleandata/all_players_data', '.csv'),
    row.names = FALSE
  )
  team_allplayers <- all_players %>% group_by(team_name)
  team_salaries <-
    team_allplayers %>% summarize(
      totalpayroll = sum(salary),
      minimumsalary = min(salary),
      maxsalary = max(salary),
      firstquantile = quantile(salary, 0.25),
      median = quantile(salary, 0.50),
      thirdquantile = quantile(salary, 0.75),
      average = mean(salary),
      interquartilerange = IQR(salary),
      standardev = sd(salary)
    )
  write.csv(
    team_salaries,
    file = paste0('data/cleandata/team-salaries', '.csv'),
    row.names = FALSE
  )
  return(all_players)
}
