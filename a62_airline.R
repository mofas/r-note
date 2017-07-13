airlines = read.csv("AirlinesCluster.csv")

# 1.1
summary(airlines)

# 1.2

# 1.3
library(caret)
preproc = preProcess(airlines)
airlinesNorm = predict(preproc, airlines)
summary(airlinesNorm)


# 2.1
airlinesDist = dist(airlinesNorm, method="euclidean")
airlinesHierClust = hclust(airlinesDist, method="ward.D")
plot(airlinesHierClust)

# 2.2
airlinesClusters = cutree(airlinesHierClust, k = 5)
table(airlinesClusters)

# 2.3
tapply(airlines$Balance, airlinesClusters, mean)
tapply(airlines$QualMiles, airlinesClusters, mean)
tapply(airlines$BonusMiles, airlinesClusters, mean)
tapply(airlines$BonusTrans, airlinesClusters, mean)
tapply(airlines$FlightMiles, airlinesClusters, mean)
tapply(airlines$FlightTrans, airlinesClusters, mean)
tapply(airlines$DaysSinceEnroll, airlinesClusters, mean)

# 2.4

# 2.5

# 2.6

# 2.7


# 3.1
k = 5
set.seed(88)
kmeansClust = kmeans(airlines, centers = k, iter.max=1000)
table(kmeansClust$cluster)

# 3.2
kmeansClust$centers
