mvt = read.csv("mvtWeek1.csv")


# 1.1
nrow(mvt)

# 1.2
str(mvt)

# 1.3
max(mvt$ID)

# 1.4
min(mvt$Beat)

# 1.5
nrow(subset(mvt, Arrest == TRUE))

# 1.6
nrow(subset(mvt, LocationDescription == "ALLEY"))


# 2.1
Month/Day/Year Hour:Minute

# 2.2
DateConvert = as.Date(strptime(mvt$Date, "%m/%d/%y %H:%M"))
summary(DateConvert)

# 2.3
mvt$Month = months(DateConvert)
mvt$Weekday = weekdays(DateConvert)
mvt$Date = DateConvert
table(mvt$Month)

# 2.4
table(mvt$Weekday)


# 2.5
table(subset(mvt, Arrest == TRUE)$Month)
table(mvt$Arrest,mvt$Month)

# 3.1
hist(mvt$Date, breaks=100)


# 3.2
boxplot(mvt$Date ~ mvt$Arrest)

# 3.3
table(mvt$Arrest, mvt$Year)
sum(mvt$Year == 2001 & mvt$Arrest == TRUE)/sum(mvt$Year == 2001)

# 3.4
sum(mvt$Year == 2007 & mvt$Arrest == TRUE)/sum(mvt$Year == 2007)

# 3.5
sum(mvt$Year == 2012 & mvt$Arrest == TRUE)/sum(mvt$Year == 2012)


# 4.1
sort(table(mvt$LocationDescription))

# 4.2
Top5 = subset(mvt,
  LocationDescription == "STREET" |
  LocationDescription == "PARKING LOT/GARAGE(NON.RESID.)" |
  LocationDescription == "ALLEY" |
  LocationDescription == "GAS STATION" |
  LocationDescription == "DRIVEWAY - RESIDENTIAL"
)

# Or
# TopLocations = c("STREET", "PARKING LOT/GARAGE(NON.RESID.)", "ALLEY", "GAS STATION", "DRIVEWAY - RESIDENTIAL")
# Top5 = subset(mvt, LocationDescription %in% TopLocations)

# 4.3
Top5$LocationDescription = factor(Top5$LocationDescription)
table(Top5$Arrest, Top5$LocationDescription)


# 4.4
table(subset(Top5, LocationDescription == "GAS STATION")$Weekday)
table(Top5$LocationDescription, Top5$Weekday)

# 4.5
table(Top5$LocationDescription, Top5$Weekday)

