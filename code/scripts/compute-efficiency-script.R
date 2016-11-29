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
    #Clean all_players for appropriate analysis
    all_players <- read.csv("data/cleandata/all_players_data.csv", stringsAsFactors = FALSE)
    all_players$missed_field_goals <- all_players$field_goal_attempts - all_players$field_goals
    all_players$missed_free_throws <- all_players$free_throw_attempts - all_players$free_throws
    all_players <- negate_bad_columns(all_players)
    for (i in important_factors) {
        if (!(i == "games")) {
            all_players[,i] = all_players[,i] / all_players$games    
        }
    }
    
    #Subset data into different positions
    all_centers <- 
        dplyr::select(all_players, one_of(c(important_factors, "player", "position", "salary"))) %>%
        dplyr::filter(position == "C")
    all_power_forwards <- 
        dplyr::select(all_players, one_of(c(important_factors, "player", "position", "salary"))) %>%
        dplyr::filter(position == "PF")
    all_small_forwards <- 
        dplyr::select(all_players, one_of(c(important_factors, "player", "position", "salary"))) %>%
        dplyr::filter(position == "SF")
    all_shooting_guards <- 
        dplyr::select(all_players, one_of(c(important_factors, "player", "position", "salary"))) %>%
        dplyr::filter(position == "SG")
    all_point_guards <-
        dplyr::select(all_players, one_of(c(important_factors, "player", "position", "salary"))) %>%
        dplyr::filter(position == "PG")
    
    #all_centers[,1:8] = scale(all_centers[,1:8], scale=TRUE)
    #all_power_forwards[,1:8] = scale(all_power_forwards[,1:8], scale=TRUE)
    #all_small_forwards[,1:8] = scale(all_small_forwards[,1:8], scale=TRUE)
    #all_shooting_guards[,1:8] = scale(all_shooting_guards[,1:8], scale=TRUE)
    #all_point_guards[,1:8] = scale(all_point_guards[,1:8], scale=TRUE)
    
    #Calculate Centers Efficiency
    pca_centers = prcomp(all_centers[,1:8], scale=TRUE)
    centers_stdevs = pca_centers[1]$sdev
    centers_PC1 = reverse_negative_weights(pca_centers[2]$rotation[,1])
    all_centers$Eff = get_eff(all_centers, centers_PC1/centers_stdevs)
    #all_centers$Eff = pca_centers$x[,1]
    
    #Calculate Power Forwards Efficiency
    pca_pfs = prcomp(all_power_forwards[,1:8], scale=TRUE)
    pfs_stdevs = pca_pfs[1]$sdev
    pfs_PC1 = reverse_negative_weights(pca_centers[2]$rotation[,1])
    all_power_forwards$Eff = get_eff(all_power_forwards, pfs_PC1/pfs_stdevs)
    #all_power_forwards$Eff = pca_pfs$x[,1]
    
    
    #Calculate Small Forwards Efficiency
    pca_sfs = prcomp(all_small_forwards[,1:8], scale=TRUE)
    sfs_stdevs = pca_sfs[1]$sdev
    sfs_PC1 = reverse_negative_weights(pca_sfs[2]$rotation[,1])
    all_small_forwards$Eff = get_eff(all_small_forwards, sfs_PC1/sfs_stdevs)
    #all_small_forwards$Eff = pca_sfs$x[,1]
    
    
    #Calculate Shooting Guards Efficiency
    pca_sgs = prcomp(all_shooting_guards[,1:8], scale=TRUE)
    sgs_stdevs = pca_sgs[1]$sdev
    sgs_PC1 = reverse_negative_weights(pca_sgs[2]$rotation[,1])
    all_shooting_guards$Eff = get_eff(all_shooting_guards, sgs_PC1/sgs_stdevs)
    #all_shooting_guards$Eff = pca_sgs$x[,1]
    
    #Calculate Point Guards Efficiency 
    pca_pgs = prcomp(all_point_guards[,1:8], scale=TRUE)
    pgs_stdevs = pca_pgs[1]$sdev
    pgs_PC1 = reverse_negative_weights(pca_pgs[2]$rotation[,1])
    all_point_guards$Eff = get_eff(all_point_guards, pgs_PC1/pgs_stdevs)
    #all_point_guards$Eff = pca_pgs$x[,1]
    
    final_eff_df <- rbind(all_centers, all_power_forwards)
    final_eff_df <- rbind(final_eff_df, all_small_forwards)
    final_eff_df <- rbind(final_eff_df, all_shooting_guards)
    final_eff_df <- rbind(final_eff_df, all_point_guards)
    final_eff_df <- negate_bad_columns(final_eff_df)
    write.csv(final_eff_df, file = paste0('data/cleandata/eff_salary_stats', '.csv'), row.names = FALSE)
    
    return (final_eff_df)
}

#
# Negates all the weights if the majority of them are negative
#
reverse_negative_weights <- function(weights) {
    if (sum(sign(weights)) < 0) {
        weights = -1 * weights
    }
    return(weights)
}

# 
# Negate the 'missed_field_goals', 'missed_free_throws', and 'turnovers' columns if they all exist
# 
negate_bad_columns <- function(df) {
    df$missed_field_goals = -1 * df$missed_field_goals
    df$missed_free_throws = -1 * df$missed_free_throws
    df$turnovers = -1 * df$turnovers
    return(df)
}

#
#Takes matrix first 8 columns times coeffs 8x1 vector
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
    #MUCH EASIER IMPLEMENTATION 
    #eff = as.matrix(df[,1:8]) %*% as.numeric(coeffs)
    return(eff)
}
