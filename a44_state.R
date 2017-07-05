data(state)
statedata = data.frame(state.x77)

# 1.1
RegModel = lm(Life.Exp ~ ., data=statedata)

# 1.2
prediction = predict(RegModel)
SSE = sum((statedata$Life.Exp - prediction)^2)

# 1.3
RegModel2 = lm(Life.Exp ~ Population + Murder + Frost + HS.Grad, data=statedata)

# 1.4
prediction = predict(RegModel2)
SSE = sum((statedata$Life.Exp - prediction)^2)

# 1.5


# 2.1
TreeModel = rpart(Life.Exp ~ ., data=statedata)
prp(TreeModel)

# 2.2
prediction = predict(TreeModel)
SSE = sum((statedata$Life.Exp - prediction)^2)

# 2.3
TreeModel2 = rpart(Life.Exp ~ ., data=statedata, minbucket=5)
prp(TreeModel2)

# 2.4

# 2.5
prediction = predict(TreeModel2)
SSE = sum((statedata$Life.Exp - prediction)^2)

# 2.6
TreeModel3 = rpart(Life.Exp ~ Area, data=statedata, minbucket=1)
prp(TreeModel3)
prediction = predict(TreeModel3)
SSE = sum((statedata$Life.Exp - prediction)^2)


# 3.1
library(caret)
library(e1071)
set.seed(111)
numFolds = trainControl(method="cv", number=10)
cartGrid = expand.grid(.cp=seq(0.01,0.50,0.01))
train(Life.Exp ~ ., data=statedata, method="rpart", trControl=numFolds, tuneGrid=cartGrid)

cp = 0.12

# 3.2
TreeModel4 = rpart(Life.Exp ~ ., data=statedata, cp=0.12)
prp(TreeModel4)

# 3.3
prediction = predict(TreeModel4)
SSE = sum((statedata$Life.Exp - prediction)^2)

# 3.4

# 3.5
set.seed(111)
numFolds = trainControl(method="cv", number=10)
cartGrid = expand.grid(.cp=seq(0.01,0.50,0.01))
train(Life.Exp ~ Area, data=statedata, method="rpart", trControl=numFolds, tuneGrid=cartGrid)

cp = 0.02

TreeModel5 = rpart(Life.Exp ~ Area, data=statedata, cp=0.02)
prp(TreeModel5)

# 3.6

# 3.7
prediction = predict(TreeModel5)
SSE = sum((statedata$Life.Exp - prediction)^2)
SSE = 44.26817