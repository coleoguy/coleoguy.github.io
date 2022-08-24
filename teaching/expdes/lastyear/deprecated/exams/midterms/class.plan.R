
# lets simulate some data with both continuous and discrete
# predictor varialbes as well as nuisance parameters and 
# random effects

disp <- runif(100, min=0, max=10)
sex <- sample(c("F", "M"), size = 100, replace=T)
age <- sample(21:49, size=100, replace=T)

sex.mean <- rep(0, 100)
sex.mean[sex=="M"] <- .225

sens <- rnorm(mean=disp*.1,n=100, sd=.1) +
        rnorm(mean=sex.mean, sd=.1, n=100)+
        rnorm(mean=age*-.1, sd=.9, n=100)


# lets make some exploratory plots
plot(sens~disp, col=as.factor(sex))


# lets talk about a super simple example of a glm
fit <- glm(sens~disp+sex+age)
summary(fit)

# lets fit the discrete predictor and compare to anova

# lets fit the continuous as well

# lets fit them all


