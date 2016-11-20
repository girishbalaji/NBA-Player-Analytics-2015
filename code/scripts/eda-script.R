library(readr)
library(ggplot2)
analysis <- read_csv("roster-salary-stats.csv",col_names=TRUE)
summary(analysis$salary)
sd(analysis$salary)
ggplot(analysis, aes(x=analysis$X1, y=analysis$salary)) + 
  geom_boxplot()
ggplot(analysis, aes(x=analysis$salary)) + 
  +     geom_histogram()
summary(analysis$height)
sd(analysis$height)
ggplot(analysis, aes(x=analysis$X1, y=analysis$height)) + 
  geom_boxplot()
ggplot(analysis, aes(x=analysis$height)) + 
  +     geom_histogram()
summary(analysis$weight)
sd(analysis$weight)
ggplot(analysis, aes(x=analysis$X1, y=analysis$weight)) + 
  geom_boxplot()
ggplot(analysis, aes(x=analysis$weight)) + 
  +     geom_histogram()
summary(analysis$G)
sd(analysis$G)
ggplot(analysis, aes(x=analysis$X1, y=analysis$G)) + 
  geom_boxplot()
ggplot(analysis, aes(x=analysis$G)) + 
  +     geom_histogram()
summary(analysis$FG)
sd(analysis$FG)
ggplot(analysis, aes(x=analysis$X1, y=analysis$FG)) + 
  geom_boxplot()
ggplot(analysis, aes(x=analysis$FG)) + 
  +     geom_histogram()
summary(analysis$FGA)
sd(analysis$FGA)
ggplot(analysis, aes(x=analysis$X1, y=analysis$FGA)) + 
  geom_boxplot()
ggplot(analysis, aes(x=analysis$FGA)) + 
  +     geom_histogram()
summary(analysis$FT)
sd(analysis$FT)
ggplot(analysis, aes(x=analysis$X1, y=analysis$FT)) + 
  geom_boxplot()
ggplot(analysis, aes(x=analysis$FT)) + 
  +     geom_histogram()
summary(analysis$FTA)
sd(analysis$FTA)
ggplot(analysis, aes(x=analysis$X1, y=analysis$FTA)) + 
  geom_boxplot()
ggplot(analysis, aes(x=analysis$FTA)) + 
  +     geom_histogram()
summary(analysis$TRB)
sd(analysis$TRB)
ggplot(analysis, aes(x=analysis$X1, y=analysis$TRB)) + 
  geom_boxplot()
ggplot(analysis, aes(x=analysis$TRB)) + 
  +     geom_histogram()
summary(analysis$AST)
sd(analysis$AST)
ggplot(analysis, aes(x=analysis$X1, y=analysis$AST)) + 
  geom_boxplot()
ggplot(analysis, aes(x=analysis$AST)) + 
  +     geom_histogram()
summary(analysis$STL)
sd(analysis$STL)
ggplot(analysis, aes(x=analysis$X1, y=analysis$STL)) + 
  geom_boxplot()
ggplot(analysis, aes(x=analysis$STL)) + 
  +     geom_histogram()
summary(analysis$BLK)
sd(analysis$BLK)
ggplot(analysis, aes(x=analysis$X1, y=analysis$BLK)) + 
  geom_boxplot()
ggplot(analysis, aes(x=analysis$BLK)) + 
  +     geom_histogram()
summary(analysis$TOV)
sd(analysis$TOV)
ggplot(analysis, aes(x=analysis$X1, y=analysis$TOV)) + 
  geom_boxplot()
ggplot(analysis, aes(x=analysis$TOV)) + 
  +     geom_histogram()
summary(analysis$PF)
sd(analysis$PF)
ggplot(analysis, aes(x=analysis$X1, y=analysis$PF)) + 
  geom_boxplot()
ggplot(analysis, aes(x=analysis$PF)) + 
  +     geom_histogram()
summary(analysis$PTS)
sd(analysis$PTS)
ggplot(analysis, aes(x=analysis$X1, y=analysis$PTS)) + 
  geom_boxplot()
ggplot(analysis, aes(x=analysis$PTS)) + 
  +     geom_histogram()
summary(factor(analysis$Team))
ggplot(analysis, aes(x=analysis$Team)) + 
  geom_bar()
summary(factor(analysis$position))
ggplot(analysis, aes(x=analysis$position)) + 
  geom_bar()