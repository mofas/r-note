IBM = read.csv("IBMStock.csv")
GE = read.csv("GEStock.csv")
ProcterGamble = read.csv("ProcterGambleStock.csv")
CocaCola = read.csv("CocaColaStock.csv")
IBM = read.csv("IBMStock.csv")
Boeing = read.csv("BoeingStock.csv")

IBM$Date = as.Date(IBM$Date, "%m/%d/%y")
GE$Date = as.Date(GE$Date, "%m/%d/%y")
CocaCola$Date = as.Date(CocaCola$Date, "%m/%d/%y")
ProcterGamble$Date = as.Date(ProcterGamble$Date, "%m/%d/%y")
Boeing$Date = as.Date(Boeing$Date, "%m/%d/%y")

# 1.1
nrow(IBM)

# 1.2
min(IBM$Date)

# 1.3
max(IBM$Date)

# 1.4
mean(IBM$StockPrice)

# 1.5
min(GE$StockPrice)

# 1.6
max(CocaCola$StockPrice)

# 1.7
median(Boeing$StockPrice)

# 1.8
sd(ProcterGamble$StockPrice)


# 2.1
plot(CocaCola$Date, CocaCola$StockPrice)

# 2.2
plot(CocaCola$Date, CocaCola$StockPrice, col="red")
lines(ProcterGamble$Date, ProcterGamble$StockPrice, col="blue", lty=2)
abline(v=as.Date(c("2000-03-01")), lwd=2)

# 2.3


# 3.1

plot(CocaCola$Date[301:432], CocaCola$StockPrice[301:432], type="l", col="red", ylim=c(0,210))
lines(IBM$Date[301:432], IBM$StockPrice[301:432], col="blue", lty=2)
lines(GE$Date[301:432], GE$StockPrice[301:432], col="green", lty=3)
lines(ProcterGamble$Date[301:432], ProcterGamble$StockPrice[301:432], col="purple", lty=4)
lines(Boeing$Date[301:432], Boeing$StockPrice[301:432], col="orange", lty=5)
abline(v=as.Date(c("2000-03-01")), lwd=2)

# 3.2

# 3.3
abline(v=as.Date(c("1997-09-01")), lwd=2)
abline(v=as.Date(c("1997-11-01")), lwd=2)

# 3.4


# 4.1
mean(IBM$StockPrice)
tapply(IBM$StockPrice, months(IBM$Date), mean)

# 4.2
tapply(GE$StockPrice, months(GE$Date), mean)

# 4.3



