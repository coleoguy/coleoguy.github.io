# Heath Blackmon
# Review of ANOVA, and simple linear models
# 27 October 2022
#

# ANOVA
set.seed(2)
chkwngs <- c(rnorm(100, mean = 0.97, sd=.25),
             rnorm(100, mean = 1.09, sd=.25),
             rnorm(100, mean = 1.19, sd=.25))
grps <- rep(c("a","b","c"), each=100)
hist(chkwngs)
fit <- aov(chkwngs~grps)
summary(fit)
TukeyHSD(fit)


# LM
x <- sample(24:32, 100, replace=T)
y <- rnorm(100, mean = 3.54*x, sd=5)
fit <- glm(y~x)
summary(fit)


# GLM
breed <- as.factor(rep(c("lab","bichon","rhodesian"), each=50))
parscore <- rnorm(150, mean=80, sd=10)

puppyprice <- 25 + rnorm(150, mean=4.7 * parscore, sd=5) +
                   rnorm(150, mean= c(95,20,50)[breed], sd=10)

boxplot(puppyprice~breed)
library(beeswarm)
beeswarm(puppyprice~breed)
plot(puppyprice~parscore)

fit <- glm(puppyprice ~ parscore + breed)
fit2 <- glm(puppyprice ~ parscore)
summary(fit)
summary(fit2)
