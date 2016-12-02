# Calculates the efficiency index for all players and value, saves into a csv.
library(dplyr)
library(XML)
library(stringr)

source("code/functions/compute-efficiency-functions.R")

compute_efficiency <- function() {
    important_factors <- c("points",
                           "total_rebounds",
                           "assists",
                           "steals",
                           "blocks",
                           "missed_field_goals",
                           "missed_free_throws",
                           "turnovers",
                           "games"
    )
    
    all_players <- load_per_game_data(important_factors)
    all_players <- negate_bad_columns(all_players)
    
    #Subset data into different positions
    all_centers <- 
        dplyr::select(all_players, one_of(
            c(important_factors, "player", "position", "salary"))) %>%
        dplyr::filter(position == "C")
    all_power_forwards <- 
        dplyr::select(all_players, one_of(
            c(important_factors, "player", "position", "salary"))) %>%
        dplyr::filter(position == "PF")
    all_small_forwards <- 
        dplyr::select(all_players, one_of(
            c(important_factors, "player", "position", "salary"))) %>%
        dplyr::filter(position == "SF")
    all_shooting_guards <- 
        dplyr::select(all_players, one_of(
            c(important_factors, "player", "position", "salary"))) %>%
        dplyr::filter(position == "SG")
    all_point_guards <-
        dplyr::select(all_players, one_of(
            c(important_factors, "player", "position", "salary"))) %>%
        dplyr::filter(position == "PG")
    
    #Calculate Centers Efficiency
    all_centers$Eff = get_position_efficiency(all_centers)
    
    #Calculate Power Forwards Efficiency
    all_power_forwards$Eff = get_position_efficiency(all_power_forwards)    
    
    #Calculate Small Forwards Efficiency
    all_small_forwards$Eff = get_position_efficiency(all_small_forwards)
    
    #Calculate Shooting Guards Efficiency
    all_shooting_guards$Eff = get_position_efficiency(all_shooting_guards)
    
    #Calculate Point Guards Efficiency 
    all_point_guards$Eff = get_position_efficiency(all_point_guards)
    
    #Merge all the position dataframes
    final_eff_df <- rbind_all_positions(all_centers, all_power_forwards, 
                                        all_small_forwards, all_shooting_guards, 
                                        all_point_guards)

    final_eff_df <- negate_bad_columns(final_eff_df)
    final_eff_df$value = final_eff_df$Eff/final_eff_df$salary
    output_best_and_worst(final_eff_df)

    return (final_eff_df)
}

