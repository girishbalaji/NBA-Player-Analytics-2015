library(readr)
library(ggplot2)
analysis <- read_csv("roster-salary-stats.csv",col_names=TRUE)
summary(analysis$salary)
sd(analysis$salary)
ggplot(analysis, aes(x=analysis$X1, y=analysis$salary)) + 
  geom_boxplot()
ggsave("salaries.png")
ggplot(analysis, aes(x=analysis$salary)) + 
  +     geom_histogram()
ggsave("salaries1.png")
summary(analysis$height)
sd(analysis$height)
ggplot(analysis, aes(x=analysis$X1, y=analysis$height)) + 
  geom_boxplot()
ggsave("height.png")
ggplot(analysis, aes(x=analysis$height)) + 
  +     geom_histogram()
ggsave("height1.png")
summary(analysis$weight)
sd(analysis$weight)
ggplot(analysis, aes(x=analysis$X1, y=analysis$weight)) + 
  geom_boxplot()
ggsave("weight.png")
ggplot(analysis, aes(x=analysis$weight)) + 
  +     geom_histogram()
ggsave("weight1.png")
summary(analysis$G)
sd(analysis$G)
ggplot(analysis, aes(x=analysis$X1, y=analysis$G)) + 
  geom_boxplot()
ggsave("G.png")
ggplot(analysis, aes(x=analysis$G)) + 
  +     geom_histogram()
ggsave("G1.png")
summary(analysis$FG)
sd(analysis$FG)
ggplot(analysis, aes(x=analysis$X1, y=analysis$FG)) + 
  geom_boxplot()
ggsave("FG.png")
ggplot(analysis, aes(x=analysis$FG)) + 
  +     geom_histogram()
ggsave("FG1.png")
summary(analysis$FGA)
sd(analysis$FGA)
ggplot(analysis, aes(x=analysis$X1, y=analysis$FGA)) + 
  geom_boxplot()
ggsave("FGA.png")
ggplot(analysis, aes(x=analysis$FGA)) + 
  +     geom_histogram()
ggsave("FGA1.png")
summary(analysis$FT)
sd(analysis$FT)
ggplot(analysis, aes(x=analysis$X1, y=analysis$FT)) + 
  geom_boxplot()
ggsave("FT.png")
ggplot(analysis, aes(x=analysis$FT)) + 
  +     geom_histogram()
ggsave("FT1.png")
summary(analysis$FTA)
sd(analysis$FTA)
ggplot(analysis, aes(x=analysis$X1, y=analysis$FTA)) + 
  geom_boxplot()
ggsave("FTA.png")
ggplot(analysis, aes(x=analysis$FTA)) + 
  +     geom_histogram()
ggsave("FTA1.png")
summary(analysis$TRB)
sd(analysis$TRB)
ggplot(analysis, aes(x=analysis$X1, y=analysis$TRB)) + 
  geom_boxplot()
ggsave("TRB.png")
ggplot(analysis, aes(x=analysis$TRB)) + 
  +     geom_histogram()
ggsave("TRB1.png")
summary(analysis$AST)
sd(analysis$AST)
ggplot(analysis, aes(x=analysis$X1, y=analysis$AST)) + 
  geom_boxplot()
ggsave("AST.png")
ggplot(analysis, aes(x=analysis$AST)) + 
  +     geom_histogram()
ggsave("AST1.png")
summary(analysis$STL)
sd(analysis$STL)
ggplot(analysis, aes(x=analysis$X1, y=analysis$STL)) + 
  geom_boxplot()
ggsave("STL.png")
ggplot(analysis, aes(x=analysis$STL)) + 
  +     geom_histogram()
ggsave("STL1.png")
summary(analysis$BLK)
sd(analysis$BLK)
ggplot(analysis, aes(x=analysis$X1, y=analysis$BLK)) + 
  geom_boxplot()
ggsave("BLK.png")
ggplot(analysis, aes(x=analysis$BLK)) + 
  +     geom_histogram()
ggsave("BLK1.png")
summary(analysis$TOV)
sd(analysis$TOV)
ggplot(analysis, aes(x=analysis$X1, y=analysis$TOV)) + 
  geom_boxplot()
ggsave("TOV.png")
ggplot(analysis, aes(x=analysis$TOV)) + 
  +     geom_histogram()
ggsave("TOV1.png")
summary(analysis$PF)
sd(analysis$PF)
ggplot(analysis, aes(x=analysis$X1, y=analysis$PF)) + 
  geom_boxplot()
ggsave("PF.png")
ggplot(analysis, aes(x=analysis$PF)) + 
  +     geom_histogram()
ggsave("PF1.png")
summary(analysis$PTS)
sd(analysis$PTS)
ggplot(analysis, aes(x=analysis$X1, y=analysis$PTS)) + 
  geom_boxplot()
ggsave("PTS.png")
ggplot(analysis, aes(x=analysis$PTS)) + 
  +     geom_histogram()
ggsave("PTS1.png")
summary(factor(analysis$Team))
ggplot(analysis, aes(x=analysis$Team)) + 
  geom_bar()
ggsave("Team.png")
summary(factor(analysis$position))
ggplot(analysis, aes(x=analysis$position)) + 
  geom_bar()
ggsave("position.png")