# here we set a seed so that we all get 
# the same result
set.seed(7)
# this will give us a vector of male and 
# female
sex <- sample(c("male","female"), 
              100, replace = T)
# now we get ages from 4 to 156
age <- sample(4:156, 100, replace=T)

# now using our two predictor variables
# sex and age we generate weight data
weight <- rnorm(100, mean=.2*age, sd=6) +
  5 * as.numeric(as.factor(sex))

# simple linear regression of weight
# on age.
fit <- lm(weight~age)

# here we look at the distribution of 
# residuals they look normal this is good
hist(fit$residuals,
     breaks=20)

# here we fit an anova for the effect of sex
fit <- aov(weight~sex)

# here we fit a more complex model 
# with age and sex as predictors
fit <- lm(weight~sex+age)

# here I simulate a new copy of the data
# this one violate one of the assumptions
# that variance is the same across values of 
# the predictor variable.
set.seed(7)
sex <- sample(c("male","female"), 
              100, replace = T)
age <- sample(4:156, 100, replace=T)
# this is the step where we create the violation
# we make the standard deviation correlated with
# the age
weight <- rnorm(100, mean=.2*age, sd=.1*age) +
  5 * as.numeric(as.factor(sex))
# lets plot visualizee the data
plot(weight~age)
# simple linear regression
fit <- lm(weight~age)
# examine residuals
hist(fit$residuals)

plot(fit$residuals~age)

# lets try this with some real data
# from the course website.
dat <- read.csv("betta (2).csv")
fit <- lm(dat$price ~ dat$size +
            dat$sex + dat$color)
summary(fit)
