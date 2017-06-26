data(state)
statedata = cbind(data.frame(state.x77), state.abb, state.area, state.center,  state.division, state.name, state.region)

str(statedata)

# 1.1
plot(statedata$x, statedata$y)

# 1.2
tapply(statedata$HS.Grad, statedata$state.region, mean)

# 1.3
boxplot(statedata$Murder ~ statedata$state.region)

# 1.4
subset(statedata, state.region == "Northeast")

# 2.1
LinReg = lm(Life.Exp ~ Population + Income + Illiteracy + Murder + HS.Grad + Frost + Area, data=statedata)

# 2.2

# 2.3
plot(statedata$Income, statedata$Life.Exp)

# 2.4


# 3.1
LineReg2 = lm(Life.Exp ~ Population + Murder + HS.Grad + Frost, data=statedata)
summary(LineReg2)

# 3.2

# 3.3
predTrain = predict(LineReg2)
sort(predTrain)

statedata$state.name[which.min(statedata$Life.Exp)]

# 3.4
statedata$state.name[which.max(statedata$Life.Exp)]

# 3.5
sort(sqrt((statedata$Life.Exp - predTrain)^2))


