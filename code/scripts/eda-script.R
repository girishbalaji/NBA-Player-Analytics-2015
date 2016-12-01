## sinks all the summary statistics of each variable to a text file,
## saves all ggplot images to the images folder.
library(readr)
library(ggplot2)
# gets the data table for the sinking
analysis <-
  read_csv("../../data/cleandata/roster-salary-stats.csv", col_names = TRUE)
# for each variable in the data table, first sink the summary and sd
sink(file = "../../data/cleandata/eda-output.txt", append = TRUE)
summary(analysis$salary)
sd(analysis$salary)
summary(analysis$height)
sd(analysis$height)
summary(analysis$weight)
sd(analysis$weight)
summary(analysis$G)
sd(analysis$G)
summary(analysis$FG)
sd(analysis$FG)
summary(analysis$FGA)
sd(analysis$FGA)
summary(analysis$FT)
sd(analysis$FT)
summary(analysis$FTA)
sd(analysis$FTA)
summary(analysis$TRB)
sd(analysis$TRB)
summary(analysis$AST)
sd(analysis$AST)
summary(analysis$STL)
sd(analysis$STL)
summary(analysis$BLK)
sd(analysis$BLK)
summary(analysis$TOV)
sd(analysis$TOV)
summary(analysis$PF)
sd(analysis$PF)
summary(analysis$PTS)
sd(analysis$PTS)
summary(factor(analysis$Team))
summary(factor(analysis$position))
sink()
# for each variable create ggplots and save them to images.
ggplot(analysis, aes(x = analysis$X1, y = analysis$salary)) +
  geom_boxplot() + coord_flip()
ggsave("../../images/salaries.png")
ggplot(data = analysis, aes(analysis$salary)) +
  geom_histogram()
ggsave("../../images/salaries1.png")
ggplot(analysis, aes(x = analysis$X1, y = analysis$height)) +
  geom_boxplot() + coord_flip()
ggsave("../../images/height.png")
ggplot(data = analysis, aes(analysis$height)) +
  geom_histogram()
ggsave("../../images/height1.png")
ggplot(analysis, aes(x = analysis$X1, y = analysis$weight)) +
  geom_boxplot() + coord_flip()
ggsave("../../images/weight.png")
ggplot(data = analysis, aes(analysis$weight)) +
  geom_histogram()
ggsave("../../images/weight1.png")
ggplot(analysis, aes(x = analysis$X1, y = analysis$G)) +
  geom_boxplot() + coord_flip()
ggsave("../../images/G.png")
ggplot(data = analysis, aes(analysis$G)) +
  geom_histogram()
ggsave("../../images/G1.png")
ggplot(analysis, aes(x = analysis$X1, y = analysis$FG)) +
  geom_boxplot() + coord_flip()
ggsave("../../images/FG.png")
ggplot(data = analysis, aes(analysis$FG)) +
  geom_histogram()
ggsave("../../images/FG1.png")
ggplot(analysis, aes(x = analysis$X1, y = analysis$FGA)) +
  geom_boxplot() + coord_flip()
ggsave("../../images/FGA.png")
ggplot(data = analysis, aes(analysis$FGA)) +
  geom_histogram()
ggsave("../../images/FGA1.png")
ggplot(analysis, aes(x = analysis$X1, y = analysis$FT)) +
  geom_boxplot() + coord_flip()
ggsave("../../images/FT.png")
ggplot(data = analysis, aes(analysis$FT)) +
  geom_histogram()
ggsave("../../images/FT1.png")
ggplot(analysis, aes(x = analysis$X1, y = analysis$FTA)) +
  geom_boxplot() + coord_flip()
ggsave("../../images/FTA.png")
ggplot(data = analysis, aes(analysis$FTA)) +
  geom_histogram()
ggsave("../../images/FTA1.png")
ggplot(analysis, aes(x = analysis$X1, y = analysis$TRB)) +
  geom_boxplot() + coord_flip()
ggsave("../../images/TRB.png")
ggplot(data = analysis, aes(analysis$TRB)) +
  geom_histogram()
ggsave("../../images/TRB1.png")
ggplot(analysis, aes(x = analysis$X1, y = analysis$AST)) +
  geom_boxplot() + coord_flip()
ggsave("../../images/AST.png")
ggplot(data = analysis, aes(analysis$AST)) +
  geom_histogram()
ggsave("../../images/AST1.png")
ggplot(analysis, aes(x = analysis$X1, y = analysis$STL)) +
  geom_boxplot() + coord_flip()
ggsave("../../images/STL.png")
ggplot(data = analysis, aes(analysis$STL)) +
  geom_histogram()
ggsave("../../images/STL1.png")
ggplot(analysis, aes(x = analysis$X1, y = analysis$BLK)) +
  geom_boxplot() + coord_flip()
ggsave("../../images/BLK.png")
ggplot(data = analysis, aes(analysis$BLK)) +
  geom_histogram()
ggsave("../../images/BLK1.png")
ggplot(analysis, aes(x = analysis$X1, y = analysis$TOV)) +
  geom_boxplot() + coord_flip()
ggsave("../../images/TOV.png")
ggplot(data = analysis, aes(analysis$TOV)) +
  geom_histogram()
ggsave("../../images/TOV1.png")
ggplot(analysis, aes(x = analysis$X1, y = analysis$PF)) +
  geom_boxplot() + coord_flip()
ggsave("../../images/PF.png")
ggplot(data = analysis, aes(analysis$PF)) +
  geom_histogram()
ggsave("../../images/PF1.png")
ggplot(analysis, aes(x = analysis$X1, y = analysis$PTS)) +
  geom_boxplot() + coord_flip()
ggsave("../../images/PTS.png")
ggplot(data = analysis, aes(analysis$PTS)) +
  geom_histogram()
ggsave("../../images/PTS1.png")
ggplot(analysis, aes(x = analysis$Team)) +
  geom_bar()
ggsave("../../images/Team.png")
ggplot(analysis, aes(x = analysis$position)) +
  geom_bar()
ggsave("../../images/position.png")