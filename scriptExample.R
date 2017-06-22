

WHO = read.csv("WHO.csv")
table(WHO$Region)
tapply(WHO$ChildMortality, WHO$Region, mean)
