pisaTrain = read.csv("pisa2009train.csv")
pisaTest = read.csv("pisa2009test.csv")

# 1.1
str(pisaTrain)

# 1.2
tapply(pisaTrain$readingScore, pisaTrain$male, mean)

# 1.3

# 1.4
pisaTrain = na.omit(pisaTrain)
pisaTest = na.omit(pisaTest)

# 2.1

# 2.2

# 2.3


# 3.1
pisaTrain$raceeth = relevel(pisaTrain$raceeth, "White")
pisaTest$raceeth = relevel(pisaTest$raceeth, "White")

lmScore = lm(readingScore ~., data=pisaTrain)

# 3.2
SSE = sum(lmScore$residuals^2)
RMSE = sqrt(SSE/nrow(pisaTrain))
# OR
# sqrt(mean(lmScore$residuals^2))

# 3.3

# 3.4

# 3.5

# 4.1
predTest = predict(lmScore, newdata=pisaTest)

# 4.2
SSE = sum((pisaTest$readingScore - predTest)^2)
RMSE = sqrt(SSE/nrow(pisaTest))

# 4.3
mean(pisaTrain$readingScore)
SST = sum((pisaTest$readingScore - mean(pisaTrain$readingScore))^2)

# 4.4
R^2 = 1 - SSE/SST
