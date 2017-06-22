USDA = read.csv("USDA.csv")

names(USDA)

HighSodium = subset(USDA, Sodium >= 10000)

match("CAVIAR", USDA$Description)


plot(USDA$Protein, USDA$TotalFat)

hist(USDA$VitaminC, xlim=c(0, 100), breaks=2000)


USDA$HighSodium = as.numeric(USDA$Sodium > mean(USDA$Sodium, na.rm=TRUE))
USDA$HighProtein = as.numeric(USDA$Protein > mean(USDA$Protein, na.rm=TRUE))
USDA$HighFat = as.numeric(USDA$TotalFat > mean(USDA$TotalFat, na.rm=TRUE))
USDA$HighCarbohydrate = as.numeric(USDA$Carbohydrate > mean(USDA$Carbohydrate, na.rm=TRUE))


table(USDA$HighSodium, USDA$HighFat)

tapply(USDA$Iron, USDA$HighProtein, mean, na.rm=TRUE)
tapply(USDA$VitaminC, USDA$HighCarbohydrate, summary, na.rm=TRUE)