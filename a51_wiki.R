wiki = read.csv("wiki.csv", stringsAsFactors=FALSE)

# 1.1
wiki$Vandal = as.factor(wiki$Vandal)
table(wiki$Vandal)

# 1.2
corpusAdded = VCorpus(VectorSource(wiki$Added))
corpusAdded = tm_map(corpusAdded, removeWords, stopwords("english"))
corpusAdded = tm_map(corpusAdded, stemDocument)
dtmAdded = DocumentTermMatrix(corpusAdded)
dtmAdded

# 1.3
sparseAdded = removeSparseTerms(dtmAdded, 0.997)

# 1.4
wordsAdded = as.data.frame(as.matrix(sparseAdded))
colnames(wordsAdded) = paste("A", colnames(wordsAdded))


corpusRemoved = VCorpus(VectorSource(wiki$Removed))
corpusRemoved = tm_map(corpusRemoved, removeWords, stopwords("english"))
corpusRemoved = tm_map(corpusRemoved, stemDocument)
dtmRemoved = DocumentTermMatrix(corpusRemoved)
sparseRemoved = removeSparseTerms(dtmRemoved, 0.997)
wordsRemoved = as.data.frame(as.matrix(sparseRemoved))
colnames(wordsRemoved) = paste("R", colnames(wordsRemoved))
ncol(wordsRemoved)

# 1.5
wikiWords = cbind(wordsAdded, wordsRemoved)
wikiWords$Vandal = wiki$Vandal
set.seed(123)
spl = sample.split(wikiWords$Vandal, SplitRatio = 0.7)
wikiTrain = subset(wikiWords, spl==TRUE)
wikiTest = subset(wikiWords, spl==FALSE)


table(wikiTest$Vandal)
618 / (545 + 618)

# 1.6
wikiCART = rpart(Vandal~., data=wikiTrain, method="class")
wikiPred = predict(wikiCART, newdata=wikiTest)
table(wikiTest$Vandal, wikiPred[,2] >= 0.5)

(618+12)/nrow(wikiTest)

# 1.7
prp(wikiCART)

# 1.8
table(wikiTrain$Vandal, predict(wikiCART)[,2] >= 0.5)


# 2.1
wikiWords2 = wikiWords
wikiWords2$HTTP = ifelse(grepl("http",wiki$Added,fixed=TRUE), 1, 0)
table(wikiWords2$HTTP)

# 2.2
wikiTrain2 = subset(wikiWords2, spl==TRUE)
wikiTest2 = subset(wikiWords2, spl==FALSE)
wiki2CART = rpart(Vandal~., data=wikiTrain2, method="class")
wiki2Pred = predict(wiki2CART, newdata=wikiTest2)
table(wikiTest2$Vandal, wiki2Pred[,2] >= 0.5)

(609 + 57) / nrow(wikiTest2)

# 2.3
wikiWords2$NumWordsAdded = rowSums(as.matrix(dtmAdded))
wikiWords2$NumWordsRemoved = rowSums(as.matrix(dtmRemoved))

mean(wikiWords2$NumWordsAdded)

# 2.4
wikiTrain3 = subset(wikiWords2, spl==TRUE)
wikiTest3 = subset(wikiWords2, spl==FALSE)
wikiCART3 = rpart(Vandal ~ ., data=wikiTrain3, method="class")
testPredictCART3 = predict(wikiCART3, newdata=wikiTest3, type="class")
table(wikiTest3$Vandal, testPredictCART3)

(514 + 248) / nrow(wikiTest3)


# 3.1
wikiWords3 = wikiWords2
wikiWords3$Minor = wiki$Minor
wikiWords3$Loggedin = wiki$Loggedin

wikiTrain4 = subset(wikiWords3, spl==TRUE)
wikiTest4 = subset(wikiWords3, spl==FALSE)
wikiCART4 = rpart(Vandal ~ ., data=wikiTrain4, method="class")
testPredictCART4 = predict(wikiCART4, newdata=wikiTest4, type="class")
table(wikiTest4$Vandal, testPredictCART4)

( 595 + 241 ) / nrow(wikiTest4)


# 3.2
prp(wikiCART4)