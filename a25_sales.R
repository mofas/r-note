data = read.csv("elantra.csv")

trainingSet = subset(data, Year <= 2012)
testingSet = subset(data, Year > 2012)

# 1
str(trainingSet)

# 2.1
model = lm(ElantraSales ~ Unemployment + CPI_all + CPI_energy + Queries, data=trainingSet)

# 2.2

# 2.3

# 3.1
model2 = lm(ElantraSales ~ Month + Unemployment + CPI_all + CPI_energy + Queries, data=trainingSet)

# 3.2

# 3.3
110.69*2
110.69*4

# 3.4


# 4.1
trainingSet$FactorMonth = as.factor(trainingSet$Month)
model3 = lm(ElantraSales ~ FactorMonth + Unemployment + CPI_all + CPI_energy + Queries, data=trainingSet)

# 4.2


# 5.1
cor(trainingSet[c("Unemployment","Month","Queries","CPI_energy","CPI_all")])

# 5.2


# 6.1
model4 = lm(ElantraSales ~ FactorMonth + Unemployment + CPI_all + CPI_energy , data=trainingSet)

# 6.2
testingSet$FactorMonth = as.factor(testingSet$Month)
prediction = predict(model4, newdata=testingSet)
SSE = sum((testingSet$ElantraSales - prediction)^2)

# 6.3
mean(trainingSet$ElantraSales)

# 6.4
SST = sum((testingSet$ElantraSales - mean(trainingSet$ElantraSales))^2)

1 - SSE/SST

# 6.5
max(abs(testingSet$ElantraSales - prediction))

# 6.6
testingSet$Year[which.max(abs(testingSet$ElantraSales - prediction))]
testingSet$Month[which.max(abs(testingSet$ElantraSales - prediction))]






