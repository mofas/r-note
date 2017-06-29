loans = read.csv("loans.csv")

# 1.1
summary(loans)

# 1.2

# 1.3
str(subset(loans, is.na(log.annual.inc) | is.na(days.with.cr.line) | is.na(revol.util) | is.na(inq.last.6mths) | is.na(delinq.2yrs) | is.na(pub.rec) ))

# 1.4
library(mice)
set.seed(144)
vars.for.imputation = setdiff(names(loans), "not.fully.paid")
imputed = complete(mice(loans[vars.for.imputation]))
loans[vars.for.imputation] = imputed

# 2.1
library(caTools)
set.seed(144)
split = sample.split(loans$not.fully.paid, SplitRatio = 0.7)
train = subset(loans, split == TRUE)
test = subset(loans, split == FALSE)
model = glm(not.fully.paid ~ ., data=train, family=binomial)
summary(model)

# 2.2
# Logit = b0 + b1*x1 + b2*x2 + ..
-10 * -9.406e-03 = 0.09406
# Odd = exp(Logit)
exp(0.09406) = 1.098626

# 2.3
test$predicted.risk = predict(model, newdata=test, type="response")
table(test$not.fully.paid, test$predicted.risk > 0.5)
2403/nrow(test)
2413/nrow(test)

# 2.4
library(ROCR)
ROCRpredTest = prediction(test$predicted.risk, test$not.fully.paid)
as.numeric(performance(ROCRpredTest, "auc")@y.values)


# 3.1
model2 = glm(not.fully.paid ~ int.rate, data=train, family=binomial)
summary(model2)

# 3.2
predict2 = predict(model2, newdata=test, type="response")
max(predict2)
table(test$not.fully.paid, predict2 > 0.5)

# 3.3
library(ROCR)
ROCRpredTest = prediction(predict2, test$not.fully.paid)
as.numeric(performance(ROCRpredTest, "auc")@y.values)

# 4.1
10 * exp(0.06*3)

# 4.2

# 4.3

# 5.1
test$profit = exp(test$int.rate*3) - 1
test$profit[test$not.fully.paid == 1] = -1


# 6.1
highInterest = subset(test, int.rate >= 0.15)
mean(highInterest$profit)
sum(highInterest$not.fully.paid == TRUE)/nrow(highInterest)

# 6.2
cutoff = sort(highInterest$predicted.risk, decreasing=FALSE)[100]
selectedLoans = subset(highInterest, predicted.risk <= cutoff)
sum(selectedLoans$profit)
sum(selectedLoans$not.fully.paid == TRUE)