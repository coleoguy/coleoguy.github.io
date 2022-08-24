TB <- .5
EB <- vector()
for(i in 1:1000){
  x <- rnorm(10)
  y <- 10 + TB*x + rnorm(10)
  fit <- summary(lm(y~x))
  p <- fit$coefficients[2,4]
  if(p<=.05) EB[i] <- fit$coefficients[2,1]
  if(p>.05) EB[i] <- 0
}
hist(EB, breaks=100)
mean(EB[EB!=0])
