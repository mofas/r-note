
letters = read.csv("letters_ABPR.csv")

# 1.1
letters$isB = as.factor(letters$letter == "B")

set.seed(1000)
library(caTools)
split = sample.split(letters$isB, SplitRatio = 0.5)
train = subset(letters, split == TRUE)
test = subset(letters, split == FALSE)

sum(letters$isB == FALSE) / nrow(letters)

# 1.2
CARTb = rpart(isB ~ . - letter, data=train, method="class")
PredictROC = predict(CARTb, newdata = test, type="class")
table(test$isB, PredictROC)
(1118 + 340) / nrow(test)

# 1.3
library(randomForest)
set.seed(1000)

lettersForest = randomForest(isB ~ . - letter, data=train)
lettersForestPred = predict(lettersForest, newdata=test)
table(test$isB, lettersForestPred)
(1165 + 374) / nrow(test)


# 2.1
letters$letter = as.factor(letters$letter)
set.seed(2000)
split = sample.split(letters$letter, SplitRatio = 0.5)
train = subset(letters, split == TRUE)
test = subset(letters, split == FALSE)
table(test$letter)

401 / nrow(test)

# 2.2
CARTletter = rpart(letter~. -isB, data=train, method="class")
predictLetter = predict(CARTletter, newdata=test, type="class")
table(test$letter, predictLetter)

(348 + 318 + 363 + 340) / nrow(test)

# 2.3
set.seed(1000)
lettersForest = randomForest(letter ~ . - isB, data=train)
lettersForestPred = predict(lettersForest, newdata=test)
table(test$letter, lettersForestPred)

(390 + 380 + 393 + 364) / nrow(test)