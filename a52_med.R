trials = read.csv("clinical_trial.csv", stringsAsFactors=FALSE)


# 1.1
max(nchar(trials$abstract))

# 1.2
sum(nchar(trials$abstract) == 0)

# 1.3
which.min(nchar(trials$title))
trials$title[1258]

# 2.1
# .1
corpusTitle = VCorpus(VectorSource(trials$title))
corpusAbstract = VCorpus(VectorSource(trials$abstract))

corpusTitle = tm_map(corpusTitle, content_transformer(tolower))
corpusAbstract = tm_map(corpusAbstract, content_transformer(tolower))

corpusTitle = tm_map(corpusTitle, removePunctuation)
corpusAbstract = tm_map(corpusAbstract, removePunctuation)

corpusTitle = tm_map(corpusTitle, removeWords, stopwords("english"))
corpusAbstract = tm_map(corpusAbstract, removeWords, stopwords("english"))

corpusTitle = tm_map(corpusTitle, stemDocument)
corpusAbstract = tm_map(corpusAbstract, stemDocument)

dtmTitle = DocumentTermMatrix(corpusTitle)
dtmAbstract = DocumentTermMatrix(corpusAbstract)

dtmTitle = removeSparseTerms(dtmTitle, 0.95)
dtmAbstract = removeSparseTerms(dtmAbstract, 0.95)

dtmTitle = as.data.frame(as.matrix(dtmTitle))
dtmAbstract = as.data.frame(as.matrix(dtmAbstract))

ncol(dtmTitle)
ncol(dtmAbstract)

# 2.2

# 2.3
sort(colSums(dtmAbstract))


# 3.1
colnames(dtmTitle) = paste0("T", colnames(dtmTitle))
colnames(dtmAbstract) = paste0("A", colnames(dtmAbstract))

# 3.2
dtm = cbind(dtmTitle, dtmAbstract)
dtm$trial = trials$trial

# 3.3
set.seed(144)
spl = sample.split(dtm$trial, 0.7)
train = subset(dtm, spl == TRUE)
test = subset(dtm, spl == FALSE)
table(train$trial)

730 / (730+572)

# 3.4
trialCART = rpart(trial~., data=train, method="class")
prp(trialCART)

# 3.5
predTrain = predict(trialCART)[,2]
max(predTrain)

# 3.6

# 3.7
table(train$trial, predTrain > 0.5)

# acc
(631 + 441) / nrow(train)
# sensitivity
441 / (441+131)
# specificity
631 / (631+99)


# 4.1
pred = predict(trialCART, newdata=test)
table(test$trial, pred[,2] >= 0.5)

(261 + 162) / nrow(test)

# 4.2
predROCR = prediction(pred[,2], test$trial)
performance(predROCR, "auc")@y.values


# 5.1

# 5.2

# 5.3





