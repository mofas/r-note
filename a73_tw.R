tweets = read.csv("tweets.csv", stringsAsFactors=FALSE)

library(tm)
library(SnowballC)

# 1.1
corpus = VCorpus(VectorSource(tweets$Tweet))
corpus = tm_map(corpus, content_transformer(tolower))
corpus = tm_map(corpus, removePunctuation)
corpus = tm_map(corpus, removeWords, stopwords("english"))
frequencies = DocumentTermMatrix(corpus)
allTweets = as.data.frame(as.matrix(frequencies))

# 1.2


# 2.1
install.packages("wordcloud")
library(wordcloud)

colnames(allTweets)

# 2.2
colSums(allTweets)

# 2.3
wordcloud(colnames(allTweets), colSums(allTweets))

# 2.4
corpus = VCorpus(VectorSource(tweets$Tweet))
corpus = tm_map(corpus, content_transformer(tolower))
corpus = tm_map(corpus, removePunctuation)
corpus = tm_map(corpus, removeWords, c("apple", stopwords("english")))
frequencies = DocumentTermMatrix(corpus)
allTweets = as.data.frame(as.matrix(frequencies))

# 3.1

# 3.2
wordcloud(colnames(allTweets), colSums(allTweets), random.order=FALSE)

# 3.3

# 3.4
wordcloud(colnames(allTweets), colSums(allTweets), rot.per=TRUE)

# 3.5
wordcloud(colnames(allTweets), colSums(allTweets), random.color=TRUE)


# 4.1
install.packages("RColorBrewer")
library(RColorBrewer)
display.brewer.all()

# 4.2

# 4.3
wordcloud(colnames(allTweets), colSums(allTweets), colors=brewer.pal(9, "Blues"))
