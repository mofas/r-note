
This document record some common used R script for data analysis.


# Table of Content

- [Dir & File](#dir--file)
- [DataFrame](#dataframe)
- [Visualization](#visualization)
- [Matrix](#matrix)
- [Filter](#filter)
- [Seq & Rep](#seq--rep)
- [NA](#na)
- [Factor](#factor)
- [Matrix](#matrix-1)
- [Linear Regression](#linear-regression)
- [Save and load data](#save-and-load-data)
- [Function](#function)



## Dir & File

- Get current dictory

```r
getwd()
```

- Show files in the current dir

```r
dir()
```

- Include File

```r
source("filename.R")
```

- Read CSV File

```r
dataFrame = read.csv("filename.csv")
```

- Save CSV File

```r
write.csv(dataFrame, "filename.csv")
```

- Show Variable

```r
ls()
```

- Remove Variable

```r
rm(dataFrame)
# clear all variable
rm(list=ls())
# clearn all variable except function
rm(list = setdiff(ls(), lsf.str()))
```



# DataFrame

- Data Info

```r
summary(dataFrame)
str(dataFrame)
```

- filter data.frame by subset

```r
data_region_factor_is_Europe = subset(dataFrame, Region == "Europe")
outliner = subset(dataFrame, income > 1000 & population < 5000)
```

- create data frame

```r
x <- data.frame(foo = 1:4, bar = c(T,T,F,F))
```

- split by month

```r
s <- split(airquality, airquality$Month)
```

- summary data

```r
mean(dataFrame$population)
sd(dataFrame$income)
sd(dataFrame$income, na.rm=TRUE)
summary(dataFrame$score)
```

- attribution

```r
which.min(dataFrame$population)
which.max(dataFrame$income)
dataFrame$Country[163]
```

- search name

```r
match("CAVIAR", USDA$Description)
```

# Visualization

- plot

```r
plot(DataFrame$population, dataFrame$income)
```

- hist

```r
hist(DataFrame$population)
```

- boxplot

```r
boxplot(DataFrame$population ~ DataFrame$income)
boxplot(DataFrame$population ~ DataFrame$income, xlab="x label", ylab="y label", main="title")
```

- table

```r
table(DataFrame$Region)

// the average income group by region
tapply(DataFrame$income, DataFrame$Region, mean)

// before process data remove na at first
tapply(DataFrame$income, DataFrame$Region, min, na.rm=TRUE)
```


# Seq & Rep


```r
seq(0, 10, by=0.5)
rep(0, times=40)
rep(c(0, 1, 2), times = 10) // 0 1 2 0 1 2 0 1 2 ..
rep(c(0,1,2), each=10) // 0 0 0 0 0 0 ... 1 1 ....  2 2 ....
```


# NA


- op

```r
is.na  //check "undefined"
is.nan //check Na
```

- get all na count

```r
sum(is.na(x))
```

- filter NA

```r
x[!is.na(x) & x > 0]
```

- filter NA in dataframe

```r
pisaTrain = na.omit(pisaTrain)
```


# Factor

factor is enum type



# Matrix

- Create

```r
x <- (1:6, nrow = 2, ncol = 3)
```

- Get demsion

```r
dim(x)
```

-  Get Data

get first two row

```
data[0:2,]
```

get num of first col is NA

```r
dim(data[!complete.cases(data[,1]),])
```

- Filter

filter by col value

```r
vir = iris[iris$Species == "virginica"]
```


- Change vector to matrix by setting demsion

```r
x <- 1:10
dim(x) <- c(2,5)
```

cbind & rbind

rbind means row bind; cbind mean column bind.

```r
x <- 1:3
y <- 10:12
cbind(x, y)
rbind(x, y)
```

create List

```r
x <- list(1, "a", false)
```

create factor

```r
x <- factor(c("y", "n", "y"))
table(x)
unclass(x)
levels(c("y", "n")) //indicate order
```

other data type

```r
x <- 1:3
names(x) <- c("a", "b", "c")
x <- list(a=1, b=2, c=3)
x <- matrix(1:4, nrow = 2, ncol = 2)
dimnames(x) <- list(c("a","b"), c("c","d"))
```



# Linear Regression


- create model

```r
model = lm(Label ~ InputA + InputB, data=dataFrame)
```

- get model coefficient

```r
sumamry(model)
```

- get model SSE

```r
SSE = sum(model$residuals^2)
```


# Save and load data

```r
dput & dget
y <- data.frame(a = 1, b = 'a')
dput(y, file = "y.R")
new.y <- dget("y.R")
```


# Function

- create function

```r
x <- function(<agruments>) {
}
search()
```


# Linear Regression

```r
trainData = read.csv("trainData.csv")
testData = read.csv("testData.csv")

# build model which automatically mapp to all other column
model1 = lm(y ~., data=trainData)
# explicitly indicate which column will be used as independent data.
model2 = lm(y ~ x1 + x2 + x3, data=trainData)

# SSE & RMSE of train data
SSE = sum(model1$residuals^2)
RMSE = sqrt(SSE/nrow(trainData))

# make prediction
predTest1 = predict(model1, newdata=testData)
predTest2 = predict(model2, newdata=testData)

# SSE & RMSE of test data
SSE = sum((testData$y - predTest1)^2)
RMSE = sqrt(SSE/nrow(testData))
```
