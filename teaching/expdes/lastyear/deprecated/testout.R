data(iris)
plot(iris$Petal.Length~iris$Petal.Width,
     main = "petal morphology",
     xlab = "width(cm)",
     ylab = "length(cm)",
     pch  = 16,
     ylim = c(0,8),
     col  =rgb(1,0,0,.25))

hist(iris$Petal.Length[iris$Species=="setosa"],
     main="Size distribution of setosa petals",
     xlab="length(cm)",
     xlim=c(1,2))

sum(rnorm(1000, mean = 36, sd = .5) >= 37) / 1000

1-pnorm(q=37, mean=36, sd=.5)
