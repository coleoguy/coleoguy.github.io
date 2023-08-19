pop <- rexp(10000)
hist(pop)
mu <- mean(pop)
conflow <- confhigh <- c()
for(i in 1:1000){
  sm <- sample(pop, size=10)
  smconfint <- t.test(sm)$conf.int
  conflow[i] <- mu >= smconfint[2]
  confhigh[i] <- mu <= smconfint[1]
}
sum(conflow)
sum(confhigh)


