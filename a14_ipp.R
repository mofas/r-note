poll = read.csv("AnonymityPoll.csv")


# 1.1
str(poll)

# 1.2
table(poll$Smartphone)
sum(is.na(poll$Smartphone))

# 1.3
table(poll$State, poll$Region)


# 2.1
table(poll$Internet.Use, poll$Smartphone)

# 2.2
sum(is.na(poll$Internet.Use))
sum(is.na(poll$Smartphone))

# 2.3
limited = subset(poll, Internet.Use == TRUE | Smartphone == TRUE)


# 3.1
summary(limited)

# 3.2
summary(poll)

# 3.3
table(poll$Info.On.Internet == 0)
table(poll$Info.On.Internet == 11)

# 3.4
sum(limited$Worry.About.Info == 1 & !is.na(limited$Worry.About.Info)) / sum(!is.na(limited$Worry.About.Info))

# 3.5
sum(limited$Anonymity.Possible == 1 & !is.na(limited$Anonymity.Possible)) / sum(!is.na(limited$Anonymity.Possible))

# 3.6
sum(limited$Tried.Masking.Identity == 1 & !is.na(limited$Tried.Masking.Identity)) / sum(!is.na(limited$Tried.Masking.Identity))

# 3.6
sum(limited$Privacy.Laws.Effective == 1 & !is.na(limited$Privacy.Laws.Effective)) / sum(!is.na(limited$Privacy.Laws.Effective))


# 4.1
hist(limited$Age)

# 4.2
max(table(limited$Age, limited$Info.On.Internet))

# 4.3
jitter(c(1, 2, 3))

# 4.4
plot(jitter(limited$Age), jitter(limited$Info.On.Internet))

# 4.5
tapply(limited$Info.On.Internet, limited$Smartphone, mean)

# 4.6
tapply(limited$Tried.Masking.Identity, limited$Smartphone, mean, na.rm=TRUE)
