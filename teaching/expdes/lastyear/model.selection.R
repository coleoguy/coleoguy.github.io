# simulating datasets and then comparing among possible models
set.seed(3)
x1 <- runif(n = 1000, min = 5, max = 10) # main explanatory variable
x2 <- rnorm(n = 1000, mean = 1, sd = 0.3) # secondary explantory variable
x3 <- rnorm(n = 1000, mean = 1, sd = 0.3) # noise
x4 <- rnorm(n = 1000, mean = 1, sd = 0.3) # noise

# simulating the response
y <- rnorm(mean = x1, sd = 1, n = 1000)
y <- y + rnorm(mean = .5*x2, sd=.1, n=1000)

plot(y ~ x1)
plot(y ~ x2)
plot(y ~ x3)
plot(y ~ x4)

fit4 <- lm(y ~ x1 + x2 + x3 + x4)
fit3a <- lm(y ~ x1 + x2 + x4)
fit3b <- lm(y ~ x1 + x2 + x3)
fit2a <- lm(y ~ x1 + x2)
fit2b <- lm(y ~ x3 + x4)
fit1a <- lm(y ~ x1)
fit1b <- lm(y ~ x2)


AIC(fit2b)
AIC(fit4)
AIC(fit3a)
AIC(fit3b)
AIC(fit1a)
AIC(fit1b)
AIC(fit2a)

result <- step(fit4)




