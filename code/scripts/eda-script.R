## sinks all the summary statistics of each variable to a text file,
## saves all ggplot images to the images folder.
library(readr)
library(ggplot2)
# gets the data table for the sinking
analysis <-
  read_csv("../../data/cleandata/roster-salary-stats.csv", col_names = TRUE)
# for each variable in the data table, first sink the summary and sd
sink(file = "../../data/cleandata/eda-output.txt", append = TRUE)
print("salary summary statistics")
summary(analysis$salary)
sd(analysis$salary)
print("height summary statistics")
summary(analysis$height)
sd(analysis$height)
print("weight summary statistics")
summary(analysis$weight)
sd(analysis$weight)
print("G summary statistics")
summary(analysis$G)
sd(analysis$G)
print("FG summary statistics")
summary(analysis$FG)
sd(analysis$FG)
print("FGA summary statistics")
summary(analysis$FGA)
sd(analysis$FGA)
print("FT summary statistics")
summary(analysis$FT)
sd(analysis$FT)
print("FTA summary statistics")
summary(analysis$FTA)
sd(analysis$FTA)
print("TRB summary statistics")
summary(analysis$TRB)
sd(analysis$TRB)
print("AST summary statistics")
summary(analysis$AST)
sd(analysis$AST)
print("STL summary statistics")
summary(analysis$STL)
sd(analysis$STL)
print("BLK summary statistics")
summary(analysis$BLK)
sd(analysis$BLK)
print("TOV summary statistics")
summary(analysis$TOV)
sd(analysis$TOV)
print("PF summary statistics")
summary(analysis$PF)
sd(analysis$PF)
print("PTS summary statistics")
summary(analysis$PTS)
sd(analysis$PTS)
print("Team summary statistics")
summary(factor(analysis$Team))
print("Position summary statistics")
summary(factor(analysis$position))
sink()
# for each variable create ggplots and save them to images.
ggplot(analysis, aes(x = analysis$X1, y = analysis$salary)) +
  geom_boxplot() + coord_flip() + xlab("") + ylab("Salary") + ggtitle("Salary Boxplot")
ggsave("../../images/salaries.png")
ggplot(data = analysis, aes(analysis$salary)) +
  geom_histogram() + xlab("Salary") + ylab("Frequency") + ggtitle("Salary Histogram")
ggsave("../../images/salaries1.png")
ggplot(analysis, aes(x = analysis$X1, y = analysis$height)) +
  geom_boxplot() + coord_flip() + xlab("") + ylab("Height") + ggtitle("Height Boxplot")
ggsave("../../images/height.png")
ggplot(data = analysis, aes(analysis$height)) +
  geom_histogram() + xlab("Height") + ylab("Frequency") + ggtitle("Height Histogram")
ggsave("../../images/height1.png")
ggplot(analysis, aes(x = analysis$X1, y = analysis$weight)) +
  geom_boxplot() + coord_flip() + xlab("") + ylab("Weight") + ggtitle("Weight Boxplot")
ggsave("../../images/weight.png")
ggplot(data = analysis, aes(analysis$weight)) +
  geom_histogram() + xlab("Weight") + ylab("Frequency") + ggtitle("Weight Histogram")
ggsave("../../images/weight1.png")
ggplot(analysis, aes(x = analysis$X1, y = analysis$G)) +
  geom_boxplot() + coord_flip() + xlab("") + ylab("G") + ggtitle("G Boxplot")
ggsave("../../images/G.png")
ggplot(data = analysis, aes(analysis$G)) +
  geom_histogram() + xlab("G") + ylab("Frequency") + ggtitle("G Histogram")
ggsave("../../images/G1.png")
ggplot(analysis, aes(x = analysis$X1, y = analysis$FG)) +
  geom_boxplot() + coord_flip() + xlab("") + ylab("FG") + ggtitle("FG Boxplot")
ggsave("../../images/FG.png")
ggplot(data = analysis, aes(analysis$FG)) +
  geom_histogram() + xlab("FG") + ylab("Frequency") + ggtitle("FG Histogram")
ggsave("../../images/FG1.png")
ggplot(analysis, aes(x = analysis$X1, y = analysis$FGA)) +
  geom_boxplot() + coord_flip() + xlab("") + ylab("FGA") + ggtitle("FGA Boxplot")
ggsave("../../images/FGA.png")
ggplot(data = analysis, aes(analysis$FGA)) +
  geom_histogram() + xlab("FGA") + ylab("Frequency") + ggtitle("FGA Histogram")
ggsave("../../images/FGA1.png")
ggplot(analysis, aes(x = analysis$X1, y = analysis$FT)) +
  geom_boxplot() + coord_flip() + xlab("") + ylab("FT") + ggtitle("FT Boxplot")
ggsave("../../images/FT.png")
ggplot(data = analysis, aes(analysis$FT)) +
  geom_histogram() + xlab("FT") + ylab("Frequency") + ggtitle("FT Histogram")
ggsave("../../images/FT1.png")
ggplot(analysis, aes(x = analysis$X1, y = analysis$FTA)) +
  geom_boxplot() + coord_flip() + xlab("") + ylab("FTA") + ggtitle("FTA Boxplot")
ggsave("../../images/FTA.png")
ggplot(data = analysis, aes(analysis$FTA)) +
  geom_histogram() + xlab("FTA") + ylab("Frequency") + ggtitle("FTA Histogram")
ggsave("../../images/FTA1.png")
ggplot(analysis, aes(x = analysis$X1, y = analysis$TRB)) +
  geom_boxplot() + coord_flip() + xlab("") + ylab("TRB") + ggtitle("TRB Boxplot")
ggsave("../../images/TRB.png")
ggplot(data = analysis, aes(analysis$TRB)) +
  geom_histogram() + xlab("TRB") + ylab("Frequency") + ggtitle("TRB Histogram")
ggsave("../../images/TRB1.png")
ggplot(analysis, aes(x = analysis$X1, y = analysis$AST)) +
  geom_boxplot() + coord_flip() + xlab("") + ylab("AST") + ggtitle("AST Boxplot")
ggsave("../../images/AST.png")
ggplot(data = analysis, aes(analysis$AST)) +
  geom_histogram() + xlab("AST") + ylab("Frequency") + ggtitle("AST Histogram")
ggsave("../../images/AST1.png")
ggplot(analysis, aes(x = analysis$X1, y = analysis$STL)) +
  geom_boxplot() + coord_flip() + xlab("") + ylab("STL") + ggtitle("STL Boxplot")
ggsave("../../images/STL.png")
ggplot(data = analysis, aes(analysis$STL)) +
  geom_histogram() + xlab("STL") + ylab("Frequency") + ggtitle("STL Histogram")
ggsave("../../images/STL1.png")
ggplot(analysis, aes(x = analysis$X1, y = analysis$BLK)) +
  geom_boxplot() + coord_flip() + xlab("") + ylab("BLK") + ggtitle("BLK Boxplot")
ggsave("../../images/BLK.png")
ggplot(data = analysis, aes(analysis$BLK)) +
  geom_histogram() + xlab("BLK") + ylab("Frequency") + ggtitle("BLK Histogram")
ggsave("../../images/BLK1.png")
ggplot(analysis, aes(x = analysis$X1, y = analysis$TOV)) +
  geom_boxplot() + coord_flip() + xlab("") + ylab("TOV") + ggtitle("TOV Boxplot")
ggsave("../../images/TOV.png")
ggplot(data = analysis, aes(analysis$TOV)) +
  geom_histogram() + xlab("TOV") + ylab("Frequency") + ggtitle("TOV Histogram")
ggsave("../../images/TOV1.png")
ggplot(analysis, aes(x = analysis$X1, y = analysis$PF)) +
  geom_boxplot() + coord_flip() + xlab("") + ylab("PF") + ggtitle("PF Boxplot")
ggsave("../../images/PF.png")
ggplot(data = analysis, aes(analysis$PF)) +
  geom_histogram() + xlab("PF") + ylab("Frequency") + ggtitle("PF Histogram")
ggsave("../../images/PF1.png")
ggplot(analysis, aes(x = analysis$X1, y = analysis$PTS)) +
  geom_boxplot() + coord_flip() + xlab("") + ylab("PTS") + ggtitle("PTS Boxplot")
ggsave("../../images/PTS.png")
ggplot(data = analysis, aes(analysis$PTS)) +
  geom_histogram() + xlab("PTS") + ylab("Frequency") + ggtitle("PTS Histogram")
ggsave("../../images/PTS1.png")
ggplot(analysis, aes(x = analysis$Team)) +
  geom_bar() + xlab("Team") + ylab("Frequency") + ggtitle("TEAM players Barchart")
ggsave("../../images/Team.png")
ggplot(analysis, aes(x = analysis$position)) +
  geom_bar() + xlab("Position") + ylab("Frequency") + ggtitle("Position Barchart")
ggsave("../../images/position.png")