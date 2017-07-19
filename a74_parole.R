parole = read.csv("parole.csv")



# 1.1
table(parole$male, parole$violator)

14 / (14+64)

# 1.2
table(parole$crime, parole$state)


# 2.1
library(ggplot2)
ggplot(data = parole, aes(x = age)) + geom_histogram(binwidth = 5)

# 2.2
ggplot(data = parole, aes(x = age)) + geom_histogram(binwidth = 5, color="blue")

# 3.1
ggplot(data = parole, aes(x = age)) + geom_histogram(binwidth = 5) + facet_grid(male ~ .)

# 3.2
ggplot(data = parole, aes(x = age)) + geom_histogram(binwidth = 5) + facet_grid(. ~ male)

# 3.3
colorPalette = c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
ggplot(data = parole, aes(x = age, fill = male)) + geom_histogram(binwidth = 5) + scale_fill_manual(values=colorPalette)

# 3.4
ggplot(data = parole, aes(x = age, fill = male)) + geom_histogram(binwidth = 5, position="identity",  alpha=0.5) + scale_fill_manual(values=colorPalette)


# 4.1
ggplot(data = parole, aes(x = time.served)) + geom_histogram(binwidth = 1)

# 4.2
ggplot(data = parole, aes(x = time.served)) + geom_histogram(binwidth = 1) + facet_grid(crime ~ .)

# 4.3

# 4.4
