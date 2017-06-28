songs = read.csv("songs.csv")

# 1.1
sum(songs$year >= 2010)

# 1.2
sum(songs$artistname == "Michael Jackson")

# 1.3
subset(songs, artistname == "Michael Jackson" & Top10 == TRUE)$songtitle

# 1.4
table(songs$timesignature)

# 1.5
songs$songtitle[which.max(songs$tempo)]


# 2.1
SongsTrain = subset(songs, year <= 2009)
SongsTest = subset(songs, year > 2009)

# 2.2
nonvars = c("year", "songtitle", "artistname", "songID", "artistID")
SongsTrain = SongsTrain[ , !(names(SongsTrain) %in% nonvars) ]
SongsTest = SongsTest[ , !(names(SongsTest) %in% nonvars) ]

SongsLog1 = glm(Top10 ~ ., data=SongsTrain, family=binomial)

# 2.3

# 2.4

# 2.5


# 3.1
cor(SongsTrain$loudness, SongsTrain$energy)

# 3.2
SongsLog2 = glm(Top10 ~ . - loudness, data=SongsTrain, family=binomial)

# 3.3
SongsLog3 = glm(Top10 ~ . - energy, data=SongsTrain, family=binomial)


# 4.1
SongsPred = predict(SongsLog3, newdata=SongsTest, type="response")
table(SongsTest$Top10, SongsPred >= 0.45)
# acc = (309+19) / (309+19+5+40)

# 4.2
sum(SongsTest$Top10 == FALSE)/nrow(SongsTest)

# 4.3
table(SongsTest$Top10, SongsPred >= 0.45)

# 4.4
# sensitivity = TP / (TP + FN)
# 19 / (19+40)
# specificity = TN / (TN + FP)
# 309 / (309+5)

# 4.5
SongsPred = predict(SongsLog3, newdata=SongsTest, type="response")