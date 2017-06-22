
### Dir & File

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

- Read File

```r
data = read.csv("filename.csv")
```

### Show Variable
```r
ls()
```


### Split data by category

by month
```r
s <- split(airquality, airquality$Month)
```


### Get data from matrix

get first two row
```
data[0:2,]
```

get num of first col is NA
```r
dim(data[!complete.cases(data[,1]),])
```


### Filter

filter by col value
```r
vir <- iris[iris$Species == "virginica",]
```

### Seq & Rep


```r
seq(0, 10, by=0.5)
rep(0, times=40)
rep(c(0, 1, 2), times = 10) // 0 1 2 0 1 2 0 1 2 ..
rep(c(0,1,2), each=10) // 0 0 0 0 0 0 ... 1 1 ....  2 2 ....
```


### NA


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


### Factor

factor is enum type


### Matrix

- Create

```r
x <- (1:6, nrow = 2, ncol = 3)
```

- Get demsion

```r
dim(x)
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

### Data frame

- create data frame

```r
x <- data.frame(foo = 1:4, bar = c(T,T,F,F))
```




### Process Data

```r
x <- c(1,2,3,4,5)
x[1]
x[1:4]
x[ x > 3]

x <- matrix(1:6, 2, 3)
x[1,2]
x[2,1]
x[1,]
x[,2]
```

- get data

```r
x <- list(foo = 1:4, bar = 0.6)
x$bar
x["bar"]
x[["bar"]]
```



### Save and load data

```r
dput & dget
y <- data.frame(a = 1, b = 'a')
dput(y, file = "y.R")
new.y <- dget("y.R")
```


### Function

- create function

```r
x <- function(<agruments>) {
}
search()
```
