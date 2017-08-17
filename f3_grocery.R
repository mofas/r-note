orders = read.csv("orders.csv")

# 1
table(orders$order_hour_of_day)

# 2
cor(orders$fresh.fruits, orders$fresh.vegetables)
nrow(subset(orders, frozen.pizza >= 1))/ nrow(orders)

# 3
orders.aisle = orders[, 5:ncol(orders)]
library(caret)
preproc = preProcess(orders.aisle)
ordersNorm = predict(preproc, orders.aisle)
summary(ordersNorm$frozen.dessert)
summary(ordersNorm$soft.drinks)


# 4
distances = dist(ordersNorm, method = "euclidean")
ClusterProducts = hclust(distances, method = "ward.D")
plot(ClusterProducts, labels = FALSE)

# 5
set.seed(200)
KMC = kmeans(ordersNorm, centers = 4)
str(KMC)
table(KMC$cluster)

# 6
kcluster1 = subset(ordersNorm, KMC$cluster==1)
kcluster2 = subset(ordersNorm, KMC$cluster==2)
kcluster3 = subset(ordersNorm, KMC$cluster==3)
kcluster4 = subset(ordersNorm, KMC$cluster==4)

tail(sort(colMeans(kcluster1)))
tail(sort(colMeans(kcluster2)))
tail(sort(colMeans(kcluster3)))
tail(sort(colMeans(kcluster4)))


# 7

# 8

# 9

# 10

# 11
kcluster1WithAddInfo = subset(orders, KMC$cluster==1)
kcluster2WithAddInfo = subset(orders, KMC$cluster==2)
kcluster3WithAddInfo = subset(orders, KMC$cluster==3)
kcluster4WithAddInfo = subset(orders, KMC$cluster==4)

summary(kcluster1WithAddInfo$order_hour_of_day)
summary(kcluster2WithAddInfo$order_hour_of_day)
summary(kcluster3WithAddInfo$order_hour_of_day)
summary(kcluster4WithAddInfo$order_hour_of_day)

# 12

# 13
summary(kcluster1WithAddInfo$days_since_prior_order)
summary(kcluster2WithAddInfo$days_since_prior_order)
summary(kcluster3WithAddInfo$days_since_prior_order)
summary(kcluster4WithAddInfo$days_since_prior_order)