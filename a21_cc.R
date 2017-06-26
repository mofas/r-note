data = read.csv("climate_change.csv")

trainingSet = subset(data, Year <= 2006)
testingSet = subset(data, Year > 2006)


# 1.1
model = lm(Temp ~ MEI + CO2 + CH4 + N2O + CFC.11 + CFC.12 + TSI + Aerosols, data=trainingSet)
summary(model)

# 1.2


# 2.1

# 2.2
cor(trainingSet)

# 3
model2 = lm(Temp ~ MEI + TSI + Aerosols + N2O, data=trainingSet)

# 4
stepModel = step(model)

# 5
prediction = predict(stepModel, newdata=testingSet)
SSE = sum((testingSet$Temp - prediction)^2)
SST = sum((testingSet$Temp - mean(trainingSet$Temp))^2)
1 - SSE/SST
