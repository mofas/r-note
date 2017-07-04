
gerber = read.csv("gerber.csv")

# 1.1
sum(gerber$voting == TRUE) / nrow(gerber)

# 1.2
sum(gerber$voting == TRUE & gerber$civicduty == TRUE)
sum(gerber$voting == TRUE & gerber$hawthorne == TRUE)
sum(gerber$voting == TRUE & gerber$self == TRUE)
sum(gerber$voting == TRUE & gerber$neighbors == TRUE)

# 1.3
gerberLog = glm(voting ~ civicduty + hawthorne + self + neighbors, data=gerber, family=binomial)

# 1.4
gerberPredict = predict(gerberLog, type="response")
table(gerber$voting, gerberPredict > 0.3)
(134513 + 51966) / nrow(gerber)

# 1.5
table(gerber$voting, gerberPredict > 0.5)
235388 / nrow(gerber)

# 1.6
library(ROCR)
ROCRpred = prediction(gerberPredict, gerber$voting)
as.numeric(performance(ROCRpred, "auc")@y.values)


# 2.1
CARTmodel = rpart(voting ~ civicduty + hawthorne + self + neighbors, data=gerber)
prp(CARTmodel)

# 2.2
CARTmodel2 = rpart(voting ~ civicduty + hawthorne + self + neighbors, data=gerber, cp=0.0)
prp(CARTmodel2)

# 2.3

# 2.4
CARTmodel3 = rpart(voting ~ civicduty + hawthorne + self + neighbors + sex, data=gerber, cp=0.0)
prp(CARTmodel3)


# 3.1
CARTcontrol = rpart(voting ~ control, data=gerber, cp=0.0)
prp(CARTcontrol, digits = 6)

(Yes = 0.296638, No = 0.34)
0.34 - 0.296638

# 3.2
CARTsex = rpart(voting ~ control + sex, data=gerber, cp=0.0)
prp(CARTsex, digits = 6)

# 3.3
LogModelSex = glm(voting ~ control + sex, data=gerber, family=binomial)
summary(LogModelSex)

# 3.4
Possibilities = data.frame(sex=c(0,0,1,1),control=c(0,1,0,1))
predict(LogModelSex, newdata=Possibilities, type="response")
abs(0.290456 - 0.2908065)

# 3.5
LogModel2 = glm(voting ~ sex + control + sex:control, data=gerber, family="binomial")

# 3.6
predict(LogModel2, newdata=Possibilities, type="response")
abs(0.290456 - 0.2904558)

# 3.7


