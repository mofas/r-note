parole = read.csv("parole.csv")

# 1.1
str(parole)

# 1.2
sum(parole$violator == TRUE)


# 2.1

# 2.2
parole$state = as.factor(parole$state)
parole$crime = as.factor(parole$crime)


# 3.1
set.seed(144)
library(caTools)
split = sample.split(parole$violator, SplitRatio = 0.7)
train = subset(parole, split == TRUE)
test = subset(parole, split == FALSE)
nrow(train)/nrow(parole)

# 3.2


# 4.1
model = glm(violator ~ ., data=train, family=binomial)

# 4.2
# ln(odds of A) = ln(odds of B) + 1.61)
# exp(ln(odds of A)) = exp(ln(odds of B)) * exp(1.61)
# odds of A = exp(1.61) * odds of B
# odds of A= 5.01 * odds of B

# 4.3
# Logit = b0 + b1*x1 + b2*x2 + ..
# Odd = exp(Logit)
# (Intercept)       -4.2411574
# male               0.3869904
# race               0.8867192
# age               -0.0001756
# state2             0.4433007
# state3             0.8349797
# state4            -3.3967878
# time.served       -0.1238867
# max.sentence       0.0802954
# multiple.offenses  1.6119919
# crime2             0.6837143
# crime3            -0.2781054
# crime4            -0.0117627

logit = -4.2411574 + 0.3869904*1 + 0.8867192*1 - 0.0001756*50 -0.1238867*3 + 0.0802954*12 + 0.6837143
odd = exp(logit)

P(y=1) = 1/(1+e^(-logit))


# 5.1
predTest = predict(model, newdata=test, type="response")

# 5.2
table(test$violator, predTest >= 0.5)
# sensitivity
12/(11+12)
# specificity
167/(167+12)
# accuracy
(12+167)/nrow(test)

# 5.3
sum(test$violator == FALSE) / nrow(test)

# 5.4

# 5.5

# 5.6
library(ROCR)
ROCRpredTest = prediction(predTest, test$violator)
as.numeric(performance(ROCRpredTest, "auc")@y.values)

# 5.7


# 6.1
