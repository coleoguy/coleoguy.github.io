# model comparison
# make some predictor variables
x <- runif(100)
z <- runif(100)

# make two response variables one impacted just by x and
# one impacted by x and z
y <- rnorm(100, mean=4*x)
y2 <- rnorm(100, mean=3*x+z)

fit1 <- glm(y ~ x)
fit2 <- glm(y ~ x + z)
fit3 <- glm(y2 ~ x)
fit4 <- glm(y2 ~ x + z)

# LRT simple model better
anova(fit2, fit1, test="LRT")

# LRT complex model better
anova(fit3, fit4, test="LRT")

summary(fit1)
summary(fit2)
summary(fit3)
summary(fit4)
logLik(fit1)
logLik(fit2)
logLik(fit3)
logLik(fit4)
anova(fit, fit2, test="LRT")

# logistic regression
# first we simulate some values for how much people practice
cod.prac <- rnorm(68, mean=32, sd=16)
# we cant study less than zero hours
cod.prac[cod.prac<0] <- 0

# lets set a seed to decrease variability of outputs
set.seed(1)
result <- c()

# lets create a vector of prob of passes by dividing the amount practiced
# by 60
probs.pass <- cod.prac/60

# now lets use this loop to make some simulated pass fail data
for(i in 1:68){
  result[i] <- sample(c("pass","fail"), 
                      1, 
                      prob=c(probs.pass[i],max(probs.pass)-probs.pass[i]))
}

# here we just plot to see if we produced the pattern we intended to
# make (more studying higher prob of passing the class)
plot(x= cod.prac,
     y= as.factor(result))

# now that we have some data lets do a logistic regression
fit <- glm(as.factor(result) ~ cod.prac, family = binomial)

# now lets go back and look at how we can plot that model
# we do this by creating a new toy data set that has all values of the
# predictor that we wish to evaluate
newdat <- data.frame(cod.prac=seq(0, max(cod.prac), length.out=1000))

# then we use the predict function to generate the expected values in 
# the response variable.
newdat$result <- predict(fit, newdata = newdat, type="response")
ys <- as.numeric(as.factor(result))-1

# now we can make a combined plot to include all of our empircal
# data as well as the model parameters that we have estimated.
plot(x=cod.prac, y=ys, pch=16, col=rgb(1,0,0,.5))
lines(y=newdat$result, x=newdat$cod.prac)

# lets use our data to calculate how much we should study to 
# have a 50% chance of passing the class
newdat$cod.prac[min(which(newdat$result > .5))]

# In the case of my dataset it says I shoudl study 30.3 hours


