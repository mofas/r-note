
census = read.csv("census.csv")

# 1.1
set.seed(2000)
split = sample.split(census$over50k, SplitRatio = 0.6)
train = subset(census, split == TRUE)
test = subset(census, split == FALSE)

censusLog = glm(over50k ~ ., data=train, family=binomial)

# 1.2
censusPredict = predict(censusLog, newdata = test, type="response")
table(test$over50k, censusPredict > 0.5)
(9051 + 1888) / nrow(test)

# 1.3
table(test$over50k)
9713 / nrow(test)

# 1.4
library(ROCR)
ROCRpred = prediction(censusPredict, test$over50k)
as.numeric(performance(ROCRpred, "auc")@y.values)


# 2.1
censustree = rpart(over50k ~ . , data=train, method="class")
prp(censustree)

# 2.2

# 2.3

# 2.4
PredictROC = predict(censustree, newdata = test, type="class")
table(test$over50k, PredictROC)

(9243 + 1596) / nrow(test)

# 2.5
PredictROC = predict(censustree, newdata=test)
ROCRpredTest = prediction(PredictROC[,2], test$over50k)
perf = performance(ROCRpredTest, "tpr", "fpr")
plot(perf)
# (3)

# 2.6
as.numeric(performance(ROCRpredTest, "auc")@y.values)


# 3.1
set.seed(1)
trainSmall = train[sample(nrow(train), 2000), ]

set.seed(1)
censusForest = randomForest(over50k ~ ., data=trainSmall)
censusForestPred = predict(censusForest, newdata=test)
table(test$over50k, censusForestPred)

(9586 + 1093) / nrow(test)

# 3.2
vu = varUsed(censusForest, count=TRUE)
vusorted = sort(vu, decreasing = FALSE, index.return = TRUE)
dotchart(vusorted$x, names(censusForest$forest$xlevels[vusorted$ix]))

# 3.3
varImpPlot(censusForest)


# 4.1
set.seed(2)
numFolds = trainControl( method="cv", number=10 )
cartGrid = expand.grid( .cp=seq(0.002,0.1,0.002))
train(over50k ~ ., data=train, method="rpart", trControl=numFolds, tuneGrid=cartGrid)

# cp = 0.002

# 4.2
censusTreeCV = rpart(over50k ~ ., data=train, method="class", cp=0.002)
PredictROC = predict(censusTreeCV, newdata=test, type = "class")
table(test$over50k, PredictROC)

(9178 + 1838) / nrow(test)

# 4.3
prp(censusTreeCV)






