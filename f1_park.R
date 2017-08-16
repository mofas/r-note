
visits = read.csv("park_visits.csv")


# 1
visits2016jul = subset(visits, Year == 2016 & Month == 7)
table(visits2016jul$ParkType)
visits2016jul$ParkName[which.max(visits2016jul$logVisits)]


# 2
tapply(visits2016jul$logVisits, visits2016jul$Region, mean)

# 3
cor(visits2016jul$logVisits, visits2016jul$cost)

# 4
ys=subset(visits, ParkName == "Yellowstone NP")
ys_ts=ts(ys$logVisits,start=c(2010,1),freq=12)
plot(ys_ts)

# 5
colSums(is.na(visits))
visits = visits[rowSums(is.na(visits)) == 0, ]

# 6
visits$Month = as.factor(visits$Month)
train = subset(visits, Year >= 2010 & Year <= 2014)
test = subset(visits, Year > 2014)
mod = lm(logVisits ~ laglogVisits, data=train)
summary(mod)
prediction = predict(mod, newdata=test)
SSE = sum((test$logVisits - prediction)^2)
SST = sum((test$logVisits - mean(train$logVisits))^2)
1 - SSE/SST

# 7
model = lm(logVisits ~ laglogVisits + laglogVisitsYear + Year + Month + Region + ParkType + cost, data=train)
summary(model)

# 8
prediction = predict(model, newdata=test)
SSE = sum((test$logVisits - prediction)^2)
SST = sum((test$logVisits - mean(train$logVisits))^2)
1 - SSE/SST

# 9
library(rpart)
library(rpart.plot)
CARTmodel = rpart(logVisits ~ laglogVisits + laglogVisitsYear + Year + Month + Region + ParkType + cost, data=train, cp=0.05)
prp(CARTmodel)

prediction = predict(CARTmodel, newdata=test)
SSE = sum((test$logVisits - prediction)^2)
SST = sum((test$logVisits - mean(train$logVisits))^2)
1 - SSE/SST

# 10
library(caret)
library(e1071)
set.seed(201)

numFolds = trainControl(method="cv", number=10)
cartGrid = expand.grid(.cp=seq(0.0001,0.005,0.0001))
train(logVisits ~ laglogVisits + laglogVisitsYear + Year + Month + Region + ParkType + cost, data=train, method="rpart", trControl=numFolds, tuneGrid=cartGrid)

# 11
CARTmodel = rpart(logVisits ~ laglogVisits + laglogVisitsYear + Year + Month + Region + ParkType + cost, data=train, cp=0.0001)
prediction = predict(CARTmodel, newdata=test)
SSE = sum((test$logVisits - prediction)^2)
SST = sum((test$logVisits - mean(train$logVisits))^2)
1 - SSE/SST

# 12
library(randomForest)
set.seed(201)
forest = randomForest(logVisits ~ laglogVisits + laglogVisitsYear + Year + Month + Region + ParkType + cost, data=train)
forestPred = predict(forest, newdata=test)
SSE = sum((test$logVisits - forestPred)^2)
SST = sum((test$logVisits - mean(train$logVisits))^2)
1 - SSE/SST