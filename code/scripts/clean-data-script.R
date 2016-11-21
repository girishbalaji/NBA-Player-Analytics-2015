library(dplyr)
library(XML)

clean_data <- function() {
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
    
    # just in case, here's the character vector with the team abbreviations
    team_names <- substr(team_hrefs, 8, 10)
    
    
    
    all_players = data.frame(team_rank = numeric(),
                          team_num = numeric(),
                          player = character(),
                          salary = character(),
                          team_name = character()
                          )
    nrow_old = 0
    for (team_num in 1:length(team_hrefs)) {
        if (!(team_names[team_num] %in% all_players$team_name)) { 
            curr_salary_file = paste0('data/rawdata/salary-data/salaries-', team_names[team_num], '.csv')
            curr_salary_df = read.csv(curr_salary_file, stringsAsFactors = FALSE)
            colnames(curr_salary_df) <- c("X", "salary_rank", "player_name", "salary")
            curr_roster_file = paste0('data/rawdata/roster-data/roster-', team_names[team_num], '.csv')
            curr_roster_df = read.csv(curr_roster_file, stringsAsFactors = FALSE)
            colnames(curr_roster_df) <- c("X", "roster_number", "player_name", "position", "height", "weight", "birthday", "misc", "experience", "college")
            curr_stat_file = paste0('data/rawdata/stat-data/stats-', team_names[team_num], '.csv')
            curr_stat_df = read.csv(curr_stat_file, stringsAsFactors = FALSE)
            colnames(curr_stat_df)[colnames(curr_stat_df) == "totals.Player"] = "player_name"
            
            curr_df <- merge(curr_salary_df, curr_roster_df, by="player_name")
            curr_df <- merge(curr_df, curr_stat_df, by="player_name")
            curr_df <- dplyr::mutate(curr_df, team_name = rep(team_names[team_num], nrow(curr_df)))
                
            all_players = rbind(all_players, curr_df)
            
            
            # print(paste("Salary: ", nrow(curr_salary_df)))
            # print(paste("Roster: ", nrow(curr_roster_df)))
            # print(paste("Stat: ", nrow(curr_stat_df)))
            # print(paste("Total Players: ", nrow(all_players)))
            # print(paste("Num Added: ", nrow(all_players) - nrow_old))
            nrow_old = nrow(all_players)
        }
    }
    return (all_players)
}