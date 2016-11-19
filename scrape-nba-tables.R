# =========================================================================
# Title: Scrape raw html tables
#
# Description:
# This script contains R code to help you scrape the tables 
# 'Roster', 'Totals', and 'Salaries', for a specific NBA team.
# Each table is read as a data.frame, which is then exported as a csv file
# to the corresponding subdirectory in the 'rawdata/' folder
# =========================================================================


library(XML)

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


# =========================================================================
# Scrape the tables Roster, Totals, and Salaries.
# Now we can pass the first value in 'team_hrefs' to the base url, and form:
# http://www.basketball-reference.com/teams/CLE/2016.html
# 
# The code below scrapes the tables for the Cleveland Cavaliers (CLE)
# You will have to write a loop that iterates over each team page
# and scrapes the required tables
# =========================================================================

# Read html document (as a character vector) for a given team
# (first team is "CLE")
url_team <- paste0(basketref, team_hrefs[1])
html_doc <- readLines(con = url_team)

# initial line position of roster html table
begin_roster <- grep('id="roster"', html_doc)
# find the line where the html ends
line_counter <- begin_roster
while (!grepl("</table>", html_doc[line_counter])) {
  line_counter <- line_counter + 1
}
# read roster table as data.frame and export it as csv
roster <- readHTMLTable(html_doc[begin_roster:line_counter])
write.csv(roster, 
  file = paste0('rawdata/roster-data/roster-', team_names[1], '.csv'))

# initial line position of totals html table
begin_totals <- grep('id="totals"', html_doc)
# find the line where the html ends
line_counter <- begin_totals
while (!grepl("</table>", html_doc[line_counter])) {
  line_counter <- line_counter + 1
}
# read totals table as data.frame and export it as csv
totals <- readHTMLTable(html_doc[begin_totals:line_counter])
write.csv(totals, 
  file = paste0('rawdata/stat-data/stats-', team_names[1], '.csv'))


# initial line position of salaries html table
begin_salaries <- grep('id="salaries"', html_doc)
# find the line where the html ends
line_counter <- begin_salaries
while (!grepl("</table>", html_doc[line_counter])) {
  line_counter <- line_counter + 1
}
# read salaries table as data.frame and export it as csv
salaries <- readHTMLTable(html_doc[begin_salaries:line_counter])
write.csv(salaries, 
  file = paste0('rawdata/salary-data/salaries-', team_names[1], '.csv'))
