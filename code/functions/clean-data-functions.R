library(dplyr)
library(XML)
library(stringr)

#
# Function to merge the roster, salary, stats data 
# Merge data essentially pulls the list of all the teams from basketball 
# href website. Then iterates through all the teams in each raw data folder
# and merges all the data frames from each folder.
#

merge_data <- function() {
    # base url
    basketref <- 'http://www.basketball-reference.com'
    
    # =========================================================================
    # The desired html tables are in URL's having this form:
    # "http://www.basketball-reference.com/teams/CLE/2016.html"
    # "http://www.basketball-reference.com/teams/TOR/2016.html"
    # "http://www.basketball-reference.com/teams/MIA/2016.html"
    # ...
    #
    # The first step is to extract the part of the url associate with each
    # team, that is: /teams/CLE/2016.html, /teams/TOR/2016.html, ...
    #
    # To do that, we'll scrape the the page:
    # "http://www.basketball-reference.com/leagues/NBA_2016.html"
    # in order to extract the 'href' attributes of the anchor tags:
    # /teams/CLE/2016.html
    # /teams/TOR/2016.html
    # /teams/MIA/2016.html
    # ...
    #
    # These attributes are extracted as a character vector
    # (these will be used to parse each team's page)
    # =========================================================================
    
    # parse 'http://www.basketball-reference.com/leagues/NBA_2016.html'
    url <- paste0(basketref, '/leagues/NBA_2016.html')
    doc <- htmlParse(url)
    
    # identify nodes with anchor tags for each team and
    # extract the href attribute from the anchor tags
    team_rows <- getNodeSet(doc, "//th[@scope='row']/a")
    team_hrefs <- xmlSApply(team_rows, xmlAttrs)
    team_hrefs = unique(team_hrefs)
    
    # just in case, here's the character vector with the team abbreviations
    team_names <- substr(team_hrefs, 8, 10)
    
    
    all_players = data.frame()
    #nrow_old = 0
    # gets each team's csv and information.
    for (team_num in 1:length(team_hrefs)) {
        curr_salary_file = paste0('data/rawdata/salary-data/salaries-',
                                  team_names[team_num],
                                  '.csv')
        curr_salary_df = read.csv(curr_salary_file, stringsAsFactors = FALSE)
        colnames(curr_salary_df) <-
            c("X", "salary_rank", "player", "salary")
        curr_salary_df <-
            curr_salary_df[, !(colnames(curr_salary_df) %in% c("X"))]
        
        curr_roster_file = paste0('data/rawdata/roster-data/roster-', 
                                  team_names[team_num], '.csv')
        curr_roster_df = read.csv(curr_roster_file, stringsAsFactors = FALSE)
        colnames(curr_roster_df) <-
            c(
                "X",
                "roster_number",
                "player",
                "position",
                "height",
                "weight",
                "birthday",
                "country",
                "experience",
                "college"
            )
        curr_roster_df <-
            curr_roster_df[, !(colnames(curr_roster_df) %in% c("X"))]
        
        curr_stat_file = paste0('data/rawdata/stat-data/stats-', 
                                team_names[team_num], '.csv')
        curr_stat_df = read.csv(curr_stat_file, stringsAsFactors = FALSE)
        curr_stat_df <-
            curr_stat_df[, !(colnames(curr_stat_df) %in% c("X"))]
        colnames(curr_stat_df) <-
            sapply(stringr::str_split(colnames(curr_stat_df), "^totals."), 
                   function(x) x[2])
        colnames(curr_stat_df)[colnames(curr_stat_df) == "Player"] = "player"
        
        curr_df <-
            merge(curr_salary_df, curr_roster_df, by = "player")
        curr_df <- merge(curr_df, curr_stat_df, by = "player")
        curr_df <-
            dplyr::mutate(curr_df, team_name = 
                              rep(team_names[team_num], nrow(curr_df)))
        
        all_players = rbind(all_players, curr_df)
        
    }
    all_players <-
        all_players %>% group_by(player) %>% filter(n() == 1)
    return (all_players)
}

#
# clean_numeric_data essentially converts salary and height to numeric data
# types so they are easier to work with
#

clean_numeric_data <- function(df) {
    if (!(("salary" %in% colnames(df)) &
          ("height" %in% colnames(df)))) {
        stop("dataframe doesn't have salary or height parameters")
    }
    df$salary <-
        as.numeric(stringr::str_replace_all(df$salary, "\\$|,", ""))
    df$height <-
        sapply(stringr::str_split(df$height, "-"), function(x)
            (as.numeric(x[1]) * 12 + as.numeric(x[2])))
    return(df)
}

#
# Clean_datetime_data basically converts the birthday columbn to that
# of type data that is easy to work with in R
#

clean_datetime_data <- function(df) {
    if (!(("birthday" %in% colnames(df)))) {
        stop("dataframe doesn't have birthday parameters")
    }
    df$birthday <- as.Date(df$birthday, "%b %d, %Y")
    return(df)
}

#
# Clean_col_names basically fixes all the colnames so that they are very
# clear. This function specifically works for the df on which this function
# is called in clean_data script
#

clean_col_names <- function(df) {
    if (!(ncol(df) == 39)) {
        stop("The imported data dataframe should have 39 columns")
    } else {
        colnames(df) <-
            c(
                "player",
                "salary_rank",
                "salary",
                "roster_number",
                "position",
                "height",
                "weight",
                "birthday",
                "country",
                "experience",
                "college",
                "stat_rank",
                "age",
                "games",
                "games_started",
                "minutes_played",
                "field_goals",
                "field_goal_attempts",
                "field_goal_pct",
                "three_points",
                "three_point_attempts",
                "three_point_pct",
                "two_points",
                "two_point_attempts",
                "two_point_pct",
                "eff_field_goal_pct",
                "free_throws",
                "free_throw_attempts",
                "free_throw_pct",
                "offensive_rebounds",
                "defensive_rebounds",
                "total_rebounds",
                "assists",
                "steals",
                "blocks",
                "turnovers",
                "personal_fouls",
                "points",
                "team_name"
            )
    }
    return (df)
}

#
# clean_bad_position cleans the data frames for all rows that don't have 
# a position value passed in
#

clean_bad_positions <- function(df) {
    if (!("position" %in% colnames(df))) {
        stop("dataframe doesn't have position column")
    }
    df <-
        dplyr::filter(df, position %in% c("C", "PF", "SF", "SG", "PG"))
    return(df)
}
