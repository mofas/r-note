
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

# calculate sensitivity and specificity
table(qualityTrain$PoorCare, predTrain > 0.5)


# TN | FP
# -------
# FN | TP

# sensitivity = TP / (TP + FN)
# specificity = TN / (TN + FP)

# threshold up, sensitivity down


install.packages("ROCR")
library(ROCR)

predictTest = predict(QualityLog, type="response", newdata=qualityTest)
ROCRpredTest = prediction(predictTest, qualityTest$PoorCare)
auc = as.numeric(performance(ROCRpredTest, "auc")@y.values)


install.packages("mice")
library(mice)
simple = polling[c("Rasmussen", "SurveyUSA", "PropR", "DiffCount")]
set.seed(144)
imputed = complete(mice(simple))


# 4

install.packages("rpart")
library(rpart)
install.packages("rpart.plot")
library(rpart.plot)


# Get ROC Curve / AUC
StevensTree = rpart(Reverse ~ Circuit + Issue + Petitioner + Respondent + LowerCourt + Unconst, data = Train, method="class", minbucket=25)
PredictROC = predict(StevensTree, newdata = Test)
ROCRpredTest = prediction(PredictROC[,2], Test$Reverse)
as.numeric(performance(ROCRpredTest, "auc")@y.values)

set.seed(100)
StevensForest = randomForest(Reverse ~ Circuit + Issue + Petitioner + Respondent + LowerCourt + Unconst, data = Train, ntree=200, nodesize=25)
PredictForest = predict(StevensForest, newdata = Test)
table(Test$Reverse, PredictForest)
# (43+74)/(43+74+19+34)

set.seed(200)
StevensForest = randomForest(Reverse ~ Circuit + Issue + Petitioner + Respondent + LowerCourt + Unconst, data = Train, ntree=200, nodesize=25)
PredictForest = predict(StevensForest, newdata = Test)
table(Test$Reverse, PredictForest)
# (44+76)/(44+76+17+33)

# Cross Validation for picking cp
numFolds = trainControl(method = "cv", number = 10)
cpGrid = expand.grid( .cp = seq(0.01,0.5,0.01))
train(Reverse ~ Circuit + Issue + Petitioner + Respondent + LowerCourt + Unconst, data=Train, method="rpart", trControl=numFolds, tuneGrid=cpGrid)

# Create a new CART model using picked cp
Tree = rpart(Reverse ~ Circuit + Issue + Petitioner + Respondent + LowerCourt + Unconst, data = Train, method="class", cp = 0.18)

# Print Tree
prp(Tree)

table(ClaimsTest$bucket2009)[1]/nrow(ClaimsTest)

# Adjust by penalty matrix
sum(as.matrix(table(ClaimsTest$bucket2009))*c(0, 2, 4, 6, 8))/nrow(ClaimsTest)



# 5

# normalized text data
library(tm)

tweets = read.csv("tweets.csv", stringsAsFactors=FALSE)
corpus = VCorpus(VectorSource(tweets$Tweet))
corpus = tm_map(corpus, content_transformer(tolower))
corpus = tm_map(corpus, removePunctuation)
corpus = tm_map(corpus, removeWords, stopwords("english"))
corpus = tm_map(corpus, stemDocument)

# transfer to matrix
frequencies = DocumentTermMatrix(corpus)

# show words with min frequency
findFreqTerms(frequencies, lowfreq=100)

# remove sparse data
sparse = removeSparseTerms(frequencies, 0.995)
tweetsSparse = as.data.frame(as.matrix(sparse))
colnames(tweetsSparse) = make.names(colnames(tweetsSparse))
tweetsSparse$Negative = tweets$Negative

# split data
set.seed(123)
split = sample.split(tweetsSparse$Negative, SplitRatio = 0.7)
trainSparse = subset(tweetsSparse, split==TRUE)
testSparse = subset(tweetsSparse, split==FALSE)

tweetLog = glm(Negative ~ ., data=trainSparse, family=binomial)
predictions = predict(tweetLog, newdata=testSparse, type="response")
table(testSparse$Negative, predictions > 0.5)

(253 + 32) / nrow(testSparse)


# 6
movies = read.table("movieLens.txt", header=FALSE, sep="|",quote="\"")
distances = dist(movies[2:20], method = "euclidean")
clusterMovies = hclust(distances, method = "ward.D")
clusterGroups = cutree(clusterMovies, k = 2)
plot(clusterMovies)

flower = read.csv("flower.csv", header=FALSE)
flowerMatrix = as.matrix(flower)
flowerVector = as.vector(flowerMatrix)
distance = dist(flowerVector, method = "euclidean")
clusterIntensity = hclust(distance, method="ward.D")
flowerClusters = cutree(clusterIntensity, k = 3)

set.seed(1)
KMC = kmeans(healthyVector, centers = k, iter.max = 1000)
str(KMC)


# 7

ggplot(WHO, aes(x = FertilityRate, y = Under15, color = Region)) + geom_point() + scale_color_brewer(palette="Dark2")


ggplot(WeekdayCounts, aes(x=Var1, y=Freq)) + geom_line(aes(group=1), linetype=2, alpha=0.3)

LatLonCounts = as.data.frame(table(round(mvt$Longitude,2), round(mvt$Latitude,2)))
LatLonCounts2 = subset(LatLonCounts, Freq > 0)
ggmap(chicago) + geom_tile(data = LatLonCounts2, aes(x = Long, y = Lat, alpha = Freq), fill="red")

ggplot(murderMap, aes(x = long, y = lat, group = group, fill = GunOwnership)) + geom_polygon(color = "black") + scale_fill_gradient(low = "black", high = "red", guide = "legend")


# 8

=sumproduct(C5:C6;E5:E6)