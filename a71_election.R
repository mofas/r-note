statesMap = map_data("state")

library(ggplot2)
library(maps)
library(ggmap)


# 1.1
str(statesMap)
length(table(statesMap$group))

# 1.2


polling = read.csv("PollingImputed.csv")
Train = subset(polling, Year < 2012)
Test = subset(polling, Year == 2012)

# 2.1

mod2 = glm(Republican~SurveyUSA+DiffCount, data=Train, family="binomial")
TestPrediction = predict(mod2, newdata=Test, type="response")
TestPredictionBinary = as.numeric(TestPrediction > 0.5)
predictionDataFrame = data.frame(TestPrediction, TestPredictionBinary, Test$State)

table(TestPredictionBinary)
mean(TestPrediction)

# 2.2
predictionDataFrame$region = tolower(predictionDataFrame$Test.State)
predictionMap = merge(statesMap, predictionDataFrame, by = "region")
predictionMap = predictionMap[order(predictionMap$order),]

str(predictionMap)
str(statesMap)

# 2.3

# 2.4
ggplot(predictionMap, aes(x = long, y = lat, group = group, fill = TestPredictionBinary)) +
geom_polygon(color = "black")

# 2.5
ggplot(predictionMap, aes(x = long, y = lat, group = group, fill = TestPredictionBinary)) +
geom_polygon(color = "black") +
scale_fill_gradient(low = "blue", high = "red", guide = "legend", breaks= c(0,1), labels = c("Democrat", "Republican"), name = "Prediction 2012")


# 3.1

# 3.2

# 4.1
ggplot(predictionMap, aes(x = long, y = lat, group = group, fill = TestPrediction))+ geom_polygon(color = "black", linetype=3) + scale_fill_gradient(low = "blue", high = "red", guide = "legend", breaks= c(0,1), labels = c("Democrat", "Republican"), name = "Prediction 2012")
ggplot(predictionMap, aes(x = long, y = lat, group = group, fill = TestPrediction))+ geom_polygon(color = "black", size=3) + scale_fill_gradient(low = "blue", high = "red", guide = "legend", breaks= c(0,1), labels = c("Democrat", "Republican"), name = "Prediction 2012")

# 4.2





