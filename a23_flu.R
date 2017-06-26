FluTrain = read.csv("FluTrain.csv")
FluTest = read.csv("FluTest.csv")

# 1.1
FluTrain$Week[which.max(FluTrain$ILI)]
FluTrain$Week[which.max(FluTrain$Queries)]

# 1.2
hist(FluTrain$ILI)

# 1.3
plot(log(FluTrain$ILI), FluTrain$Queries)

# 2.1

# 2.2
FluTrend1 = lm(log(ILI) ~ Queries, data=FluTrain)
Correlation = cor(log(FluTrain$ILI), FluTrain$Queries)

# 3.1
PredTest1 = exp(predict(FluTrend1, newdata=FluTest))
EstimatedILI = PredTest1[which(FluTest$Week == "2012-03-11 - 2012-03-17")]

# 3.2
ObservedILI = FluTest$ILI[which(FluTest$Week == "2012-03-11 - 2012-03-17")]
(ObservedILI - EstimatedILI)/ObservedILI

# 3.3
SSE = sum((PredTest1 - FluTest$ILI)^2)
RMSE = sqrt(SSE/nrow(FluTest))

# 4.1
install.packages("zoo")
library(zoo)
ILILag2 = lag(zoo(FluTrain$ILI), -2, na.pad=TRUE)
FluTrain$ILILag2 = coredata(ILILag2)

# 4.2
plot(log(FluTrain$ILILag2), log(FluTrain$ILI))

# 4.3
FluTrend2 = lm(log(ILI) ~ Queries + log(ILILag2), data=FluTrain)

# 5.1
ILILag2 = lag(zoo(FluTrain$ILI), -2, na.pad=TRUE)
FluTest$ILILag2 = coredata(lag(zoo(FluTest$ILI), -2, na.pad=TRUE))

# 5.2

# 5.3
#1.8527356
FluTest$ILILag2[1] = FluTrain$ILI[length(FluTrain$ILI)-1]
#2.1241299
FluTest$ILILag2[2] = FluTrain$ILI[length(FluTrain$ILI)]

# 5.4
PredTest2 = exp(predict(FluTrend2, newdata=FluTest))
SSE = sum((PredTest2 - FluTest$ILI)^2)
RMSE = sqrt(SSE/nrow(FluTest))

# 5.5