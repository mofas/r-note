edges = read.csv("edges.csv")
users = read.csv("users.csv")


# 1.1
str(users)
str(edges)

# 1.2
table(users$locale, users$school)

# 1.3
table(users$gender, users$school)


# 2.1
install.packages("igraph")
library("igraph")

g = graph.data.frame(edges, FALSE, users)

# 2.2
plot(g, vertex.size=5, vertex.label=NA)

# 2.3
sum(degree(g) >= 10)

# 2.4
V(g)$size = degree(g)/2+2
plot(g, vertex.label=NA)


# 3.1
V(g)$color = "black"
V(g)$color[V(g)$gender == "A"] = "red"
V(g)$color[V(g)$gender == "B"] = "gray"
plot(g, vertex.label=NA)

# 3.2
V(g)$color = "black"
V(g)$color[V(g)$school == "A"] = "red"
V(g)$color[V(g)$school == "AB"] = "blue"
plot(g, vertex.label=NA)

# 3.3
V(g)$color = "black"
V(g)$color[V(g)$locale == "A"] = "red"
V(g)$color[V(g)$locale == "B"] = "gray"
plot(g, vertex.label=NA)


# 4

