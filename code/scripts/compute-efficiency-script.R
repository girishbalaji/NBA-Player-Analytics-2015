# Calculates the efficiency index for all players and value, saves into a csv.
library(dplyr)
library(XML)
library(stringr)

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

#
# Final df get best and worst post processing 
# Both prints to console and sinks output to text file
#
output_best_and_worst <- function(final_eff_df) {
    write.csv(final_eff_df, file = paste0(
        'data/cleandata/eff_salary_stats', '.csv'), row.names = FALSE)
    sink(file="data/cleandata/best-worst-value-players.txt",append=TRUE)
    print("Best Valued Players")
    print(head(arrange(final_eff_df,desc(value)),20)$player)
    print("Worst Valued Players")
    print(tail(arrange(final_eff_df,desc(value)),20)$player)
    sink()
}


#
# load_per_game_data basically loads and standardizes the data needed
# for this portion. Adds the appropriate negatively weighted columns as in
# missed field goals
#
load_per_game_data <- function(important_factors) {
    #Clean all_players for appropriate analysis
    all_players <- read.csv("data/cleandata/all_players_data.csv", 
                            stringsAsFactors = FALSE)
    all_players$missed_field_goals <- 
        all_players$field_goal_attempts - all_players$field_goals
    all_players$missed_free_throws <- 
        all_players$free_throw_attempts - all_players$free_throws
    for (i in important_factors) {
        if (!(i == "games")) {
            all_players[,i] = all_players[,i] / all_players$games    
        }
    }
    return(all_players)
}

#
# Get_position_efficiency returns the efficiency column with the correct
# position dataframe passed in. Used above to perform PCA and weight projection
#
get_position_efficiency <- function(position_df) {
    pca = prcomp(position_df[,1:8], scale=TRUE)
    stdevs = pca[1]$sdev
    #pc1 = reverse_negative_weights(pca[2]$rotation[,1])
    pc1 = abs(pca[2]$rotation[,1])
    position_df <- negate_bad_columns(position_df)
    position_df_eff = get_eff(position_df, pc1/stdevs)
}

#
# Rbinds multiple position data frames. Make sure each dataframe has the same
# correct column names. Used to bind all tables after computing efficiency
#
rbind_all_positions <- function(all_centers, all_power_forwards, 
                                all_small_forwards, all_shooting_guards, 
                                all_point_guards) {
    final_eff_df <- rbind(all_centers, all_power_forwards)
    final_eff_df <- rbind(final_eff_df, all_small_forwards)
    final_eff_df <- rbind(final_eff_df, all_shooting_guards)
    final_eff_df <- rbind(final_eff_df, all_point_guards)
    return(final_eff_df)
}

#
# Negates all the weights if the majority of them are negative.
# The weights refer to those weights we get from the first principal component.
#
reverse_negative_weights <- function(weights) {
    if (sum(sign(weights)) < 0) {
        weights = -1 * weights
    }
    return(weights)
}

# 
# Negate the 'missed_field_goals', 'missed_free_throws', and 'turnovers' 
# columns if they all exist.
# Note that it does not mutate the original df so you must update the dataframe 
# 
negate_bad_columns <- function(df) {
    df$missed_field_goals = -1 * df$missed_field_goals
    df$missed_free_throws = -1 * df$missed_free_throws
    df$turnovers = -1 * df$turnovers
    return(df)
}

#
# Takes matrix first 8 columns times coeffs 8x1 vector. 
# Basically, treats first 8 columns of df as a matrix 
# multiplied by a coefficients vector.
# Here's a potentially easier implementation: 
# eff = as.numeric(as.matrix(df[,1:8]) %*% as.numeric(coeffs)
# The implmentation below has fewer type conversion and should be more robust
#
get_eff <- function(df, coeffs) {
     eff <- c(df[,1]*coeffs[1] +
         df[,2]*coeffs[2] +
         df[,3]*coeffs[3] +
         df[,4]*coeffs[4] +
         df[,5]*coeffs[5] +
         df[,6]*coeffs[6] +
         df[,7]*coeffs[7] +
         df[,8]*coeffs[8]) 
    return(eff)
}
