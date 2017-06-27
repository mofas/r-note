
# 2

wine = read.csv("wine.csv")
model = lm(Price ~ WinterRain + HarvestRain, data=wine)

cor(wine$WinterRain, wine$HarvestRain)

prediction = predict(model, newdata=wineTest)


teamRank = c(1,2,3,3,4,4,4,4,5,5)

wins2012 = c(94, 88, 95, 88, 93, 94, 98, 97, 93, 94)
wins2013 = c(97, 97, 92, 93, 92, 96, 94, 96, 92, 90)

cor(teamRank, wins2012)
cor(teamRank, wins2013)

SSE = sum(model$residuals^2)
SST = sum((wine$Price - mean(wine$Price))^2)


RMSE = sqrt(SSE/nrow(model))


# 3

Logit = b0 + b1*x1 + b2*x2 + ..

Odd = exp(Logit)

P(y=1) = 1/(1+e^(-Logit))

# randomly seprate dataset
install.packages("caTools")
library(caTools)

quality = read.csv("quality.csv")
set.seed(88)
split = sample.split(quality$PoorCare, SplitRatio = 0.75)
qualityTrain = subset(quality, split == TRUE)
qualityTest = subset(quality, split == FALSE)
QualityLog = glm(PoorCare ~ StartedOnCombination + ProviderCount, data=qualityTrain, family=binomial)
