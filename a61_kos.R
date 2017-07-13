dailykos = read.csv("dailykos.csv")


# 1.1
kosDist = dist(dailykos, method="euclidean")
kosHierClust = hclust(kosDist, method="ward.D")

# 1.2
plot(kosHierClust)

# 1.3

# 1.4
kosClusters = cutree(kosHierClust, k = 7)
table(kosClusters)

cluster1 = subset(dailykos, kosClusters==1)
cluster2 = subset(dailykos, kosClusters==2)
cluster3 = subset(dailykos, kosClusters==3)
cluster4 = subset(dailykos, kosClusters==4)
cluster5 = subset(dailykos, kosClusters==5)
cluster6 = subset(dailykos, kosClusters==6)
cluster7 = subset(dailykos, kosClusters==7)

# 1.5
tail(sort(colMeans(cluster1)))

# 1.6
tail(sort(colMeans(cluster2)))
tail(sort(colMeans(cluster3)))
tail(sort(colMeans(cluster4)))
tail(sort(colMeans(cluster5)))
tail(sort(colMeans(cluster6)))
tail(sort(colMeans(cluster7)))

# 2.1
k = 7
set.seed(1000)
KMC = kmeans(dailykos, centers = k)
str(KMC)
table(KMC$cluster)
kcluster1 = subset(dailykos, KMC$cluster==1)
kcluster2 = subset(dailykos, KMC$cluster==2)
kcluster3 = subset(dailykos, KMC$cluster==3)
kcluster4 = subset(dailykos, KMC$cluster==4)
kcluster5 = subset(dailykos, KMC$cluster==5)
kcluster6 = subset(dailykos, KMC$cluster==6)
kcluster7 = subset(dailykos, KMC$cluster==7)

# 2.2
tail(sort(colMeans(kcluster1)))
tail(sort(colMeans(kcluster2)))
tail(sort(colMeans(kcluster3)))
tail(sort(colMeans(kcluster4)))
tail(sort(colMeans(kcluster5)))
tail(sort(colMeans(kcluster6)))
tail(sort(colMeans(kcluster7)))

# 2.3

# 2.4

# 2.5

# 2.6