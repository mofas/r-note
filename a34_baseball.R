baseball = read.csv("baseball.csv")

# 1.1
str(baseball)

# 1.2
nrow(table(baseball$Year))

# 1.3
baseball = subset(baseball, Playoffs == TRUE)

# 1.4
table(baseball$Year)


# 2.1
PlayoffTable = table(baseball$Year)
names(PlayoffTable)

# 2.2

# 2.3
baseball$NumCompetitors = PlayoffTable[as.character(baseball$Year)]

# 2.4
sum(baseball$NumCompetitors == 8)


# 3.1
baseball$WorldSeries = as.numeric(baseball$RankPlayoffs == 1)
sum(baseball$WorldSeries == 0)

# 3.2
model = glm(WorldSeries ~ Year, data=baseball, family=binomial)
summary(model)
model = glm(WorldSeries ~ RS, data=baseball, family=binomial)
summary(model)
model = glm(WorldSeries ~ RA, data=baseball, family=binomial)
summary(model)
model = glm(WorldSeries ~ W, data=baseball, family=binomial)
summary(model)
model = glm(WorldSeries ~ OBP, data=baseball, family=binomial)
summary(model)
model = glm(WorldSeries ~ SLG, data=baseball, family=binomial)
summary(model)
model = glm(WorldSeries ~ BA, data=baseball, family=binomial)
summary(model)
model = glm(WorldSeries ~ RankSeason, data=baseball, family=binomial)
summary(model)
model = glm(WorldSeries ~ OOBP, data=baseball, family=binomial)
summary(model)
model = glm(WorldSeries ~ OSLG, data=baseball, family=binomial)
summary(model)
model = glm(WorldSeries ~ NumCompetitors, data=baseball, family=binomial)
summary(model)
model = glm(WorldSeries ~ League, data=baseball, family=binomial)
summary(model)

# 4.1
model = glm(WorldSeries ~ Year + RA + RankSeason + NumCompetitors, data=baseball, family=binomial)

# 4.2
cor(baseball[c("Year","RA","RankSeason","NumCompetitors")])

# 4.3
model = glm(WorldSeries ~ Year, data=baseball, family=binomial)
summary(model)
model = glm(WorldSeries ~ RA, data=baseball, family=binomial)
summary(model)
model = glm(WorldSeries ~ RankSeason, data=baseball, family=binomial)
summary(model)
model = glm(WorldSeries ~ NumCompetitors, data=baseball, family=binomial)
summary(model)
# 230.96

model = glm(WorldSeries ~ Year + RA, data=baseball, family=binomial)
summary(model)
model = glm(WorldSeries ~ Year + RankSeason, data=baseball, family=binomial)
summary(model)
model = glm(WorldSeries ~ Year + NumCompetitors, data=baseball, family=binomial)
summary(model)
# 232.9

model = glm(WorldSeries ~ RA + RankSeason, data=baseball, family=binomial)
summary(model)
model = glm(WorldSeries ~ RA + NumCompetitors, data=baseball, family=binomial)
summary(model)

model = glm(WorldSeries ~ RankSeason + NumCompetitors, data=baseball, family=binomial)
summary(model)
# 232.52
