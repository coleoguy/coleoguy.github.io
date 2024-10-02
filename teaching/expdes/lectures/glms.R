# read in oak data
dat <- read.csv("oaks.csv")

# fit a model where the number of specialists is a 
# function of the tree size, temp, and precip
fit <- glm(dat$specialist ~ dat$Circumference + 
             dat$MeanTempWarmestQuart +
             dat$MeanPrecipWarmestQuart)

# exam model fit
summary(fit)

# fit a model where number of specialist is a 
# function of the tree size and country
fit <- glm(dat$specialist ~ dat$Circumference + 
             dat$Country)

# exam model fit
summary(fit)

# exam the impact of changing the names
# of our discrete states
dat$Country[dat$Country == "Sweden"] <- "aSweden"

# evaluate residuals
hist(fit$residuals)
plot(fit$residuals ~ dat$Circumference,
     pch=16, col=rgb(1,0,0.5), cex=.5)
fit2 <- lm(fit$residuals ~ dat$Circumference)
abline(fit2)
summary(fit2)         
