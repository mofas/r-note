emails = read.csv("emails.csv", stringsAsFactors=FALSE)



# 1.1
str(emails)

# 1.2
table(emails$spam)

# 1.3
emails$text[1]

# 1.4

# 1.5
max(nchar(emails$text))

# 1.6
which.min(nchar(emails$text))

# 2.1
corpus = VCorpus(VectorSource((emails$text)))
corpus = tm_map(corpus, content_transformer(tolower))
corpus = tm_map(corpus, removePunctuation)
corpus = tm_map(corpus, removeWords, stopwords("english"))
corpus = tm_map(corpus, stemDocument)
dtm = DocumentTermMatrix(corpus)

# 2.2
spdtm = removeSparseTerms(dtm, 0.95)

# 2.3
emailsSparse = as.data.frame(as.matrix(spdtm))
colnames(emailsSparse) = make.names(colnames(emailsSparse))
sort(colSums(emailsSparse))

# 2.4
emailsSparse$spam = emails$spam
sort(colSums(subset(emailsSparse, spam == FALSE)))

# 2.5
sort(colSums(subset(emailsSparse, spam == TRUE)))

# 2.6

# 2.7


# 3.1
emailsSparse$spam = as.factor(emailsSparse$spam)
set.seed(123)
spl = sample.split(emailsSparse$spam, 0.7)
train = subset(emailsSparse, spl == TRUE)
test = subset(emailsSparse, spl == FALSE)

spamLog = glm(spam~., data=train, family=binomial)
spamCART = rpart(spam~., data=train, method="class")

set.seed(123)
spamRF = randomForest(spam~., data=train)

predTrainLog = predict(spamLog, type="response")
predTrainCART = predict(spamCART)[,2]
predTrainRF = predict(spamRF)

sum(predTrainLog < 0.00001)
sum(predTrainLog > 0.99999)
sum(predTrainLog <= 0.99999 & predTrainLog > 0.00001)

# 3.2

# 3.3
prp(spamCART)

# 3.4
table(train$spam , predTrainLog > 0.5)

(3052 + 954) / nrow(train)

# 3.5
predictionTrainLog = prediction(predTrainLog, train$spam)
as.numeric(performance(predictionTrainLog, "auc")@y.values)

# 3.6
table(train$spam, predTrainCART > 0.5)

(2885 + 894) / nrow(train)

# 3.7
predictionTrainCART = prediction(predTrainCART, train$spam)
as.numeric(performance(predictionTrainCART, "auc")@y.values)

# 3.8
table(train$spam, predTrainRF > 0.5)

(3008 + 903) / nrow(train)

# 3.9
predictionTrainRF = prediction(predTrainRF, train$spam)
as.numeric(performance(predictionTrainRF, "auc")@y.values)


# 4.1
predTestLog = predict(spamLog, newdata=test, type="response")
predTestCART = predict(spamCART, newdata=test)[,2]
predTestRF = predict(spamRF, newdata=test)

table(test$spam , predTestLog > 0.5)

(1257 + 376) / nrow(test)

# 4.2
predictionTestLog = prediction(predTestLog, test$spam)
as.numeric(performance(predictionTestLog, "auc")@y.values)

# 4.3
table(test$spam, predTestCART > 0.5)

(1228 + 386) / nrow(test)

# 4.4
predictionTestCART = prediction(predTestCART, test$spam)
as.numeric(performance(predictionTestCART, "auc")@y.values)

# 4.5
table(test$spam, predTestRF > 0.5)

(1288 + 386) / nrow(test)

# 4.6
predictionTestRF = prediction(predTestRF, test$spam)
as.numeric(performance(predictionTestRF, "auc")@y.values)

# 4.7

# 4.8

# 5.1

# 5.2

# 5.3

# 5.4

# 5.5

# 5.6


# 6.1
wordCount = rowSums(as.matrix(dtm))

# 6.2
hist(wordCount)

# 6.3
hist(log(wordCount))

# 6.4
emailsSparse$logWordCount = log(wordCount)
boxplot(emailsSparse$logWordCount ~ emailsSparse$spam)

# 6.5
train2 = subset(emailsSparse, spl == TRUE)
test2 = subset(emailsSparse, spl == FALSE)
spam2CART = rpart(spam~., data=train2, method="class")

set.seed(123)
spam2RF = randomForest(spam~., data=train2)

prp(spam2CART)

# 6.6
predTest2CART = predict(spam2CART, newdata=test2)[,2]
table(test2$spam , predTest2CART > 0.5)

(1214 + 384) / nrow(test2)

# 6.7
predictionTest2CART = prediction(predTest2CART, test2$spam)
as.numeric(performance(predictionTestCART, "auc")@y.values)

# 6.8
predTest2RF = predict(spam2RF, newdata=test2)
table(test2$spam , predTest2RF > 0.5)

(1285 + 385) / nrow(test2)

# 6.9
predictionTest2RF = prediction(predTest2RF, test2$spam)
as.numeric(performance(predictionTest2RF, "auc")@y.values)

