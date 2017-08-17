bank = read.csv("bank.csv")


# 1
summary(bank)

# 2
sort(tapply(bank$duration, bank$job, mean))

# 3
cor(bank[c("emp.var.rate","cons.price.idx","cons.conf.idx","euribor3m","nr.employed")])

# 4
library(caTools)

set.seed(201)
spl = sample.split(bank$y, 0.7)
training = subset(bank, spl == TRUE)
testing = subset(bank, spl == FALSE)

# 5
model = glm(y ~ age + job + marital + education + default + housing + loan + contact + month + day_of_week + campaign + pdays + previous + poutcome + emp.var.rate + cons.price.idx + cons.conf.idx, data=training, family=binomial)

# 6

# 7
prediction = predict(model, newdata=testing, type="response")
table(testing$y, prediction > 0.5)

50 + 44

# 8
library(ROCR)
ROCRpredTest = prediction(prediction, testing$y)
as.numeric(performance(ROCRpredTest, "auc")@y.values)

# 11
perf = performance(ROCRpredTest, "tpr", "fpr")
plot(perf, colorize=TRUE, print.cutoffs.at=seq(0,1,by=0.1))

# 13
library(caret)
library(e1071)
set.seed(201)
cartGrid = expand.grid(.cp=seq(0.001,0.05,0.001))
numFolds = trainControl(method="cv", number=10)
train(y ~ age + job + marital + education + default + housing + loan + contact + month + day_of_week + campaign + pdays + previous + poutcome + emp.var.rate + cons.price.idx + cons.conf.idx, data=training, method="rpart", trControl=numFolds, tuneGrid=cartGrid)

# should be 0.009


# 14
tree = rpart(y ~ age + job + marital + education + default + housing + loan + contact + month + day_of_week + campaign + pdays + previous + poutcome + emp.var.rate + cons.price.idx + cons.conf.idx, data=training, method="class", cp = 0.009)
prp(tree)

# 15
prediction = predict(tree, newdata=testing, type = "class")
table(testing$y, prediction)

(1303+28)/nrow(testing)





