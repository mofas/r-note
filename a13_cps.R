
CPS = read.csv("CPSData.csv")
MetroAreaMap = read.csv("MetroAreaCodes.csv")
CountryMap = read.csv("CountryCodes.csv")

# 1.1
nrow(CPS)

# 1.2
sort(table(CPS$Industry))

# 1.3
sort(table(CPS$State))

# 1.4
sum(CPS$Citizenship != "Non-Citizen") / nrow(CPS)

# 1.5
table(CPS$Hispanic, CPS$Race)


# 2.1
summary(CPS)

# 2.2
table(CPS$Region, is.na(CPS$Married))
table(CPS$Sex, is.na(CPS$Married))
table(CPS$Age, is.na(CPS$Married))
table(CPS$Citizenship, is.na(CPS$Married))

# 2.3
table(CPS$State, is.na(CPS$MetroAreaCode))

# 2.4
table(CPS$Region, is.na(CPS$MetroAreaCode))

# 2.5
sort(tapply(is.na(CPS$MetroAreaCode), CPS$State, mean))


# 3.1
nrow(MetroAreaMap)
nrow(CountryMap)

# 3.2
CPS = merge(CPS, MetroAreaMap, by.x="MetroAreaCode", by.y="Code", all.x=TRUE)
sum(is.na(CPS$MetroArea))

# 3.3
sort(table(CPS$MetroArea))

# 3.4
sort(tapply(CPS$Hispanic, CPS$MetroArea, mean))

# 3.5
sort(tapply(CPS$Race == "Asian", CPS$MetroArea, mean))

# 3.6
sort(tapply(CPS$Education == "No high school diploma", CPS$MetroArea, mean, na.rm=TRUE))

# 4.1
CPS = merge(CPS, CountryMap, by.x="CountryOfBirthCode", by.y="Code", all.x=TRUE)

# 4.2
sort(table(CPS$Country))

# 4.3
table(CPS$MetroArea == "New York-Northern New Jersey-Long Island, NY-NJ-PA", CPS$Country != "United States")

# 4.4
sort(tapply(CPS$Country == "India", CPS$MetroArea, sum, na.rm=TRUE))
sort(tapply(CPS$Country == "Brazil", CPS$MetroArea, sum, na.rm=TRUE))
sort(tapply(CPS$Country == "Somalia", CPS$MetroArea, sum, na.rm=TRUE))


