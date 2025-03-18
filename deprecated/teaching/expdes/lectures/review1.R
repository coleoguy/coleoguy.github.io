data(iris)
hist(iris$Sepal.Length[iris$Species == "virginica"])
hist(iris$Sepal.Length[iris$Species == "setosa"])
vir <- iris$Sepal.Length[iris$Species == "virginica"]
set <- iris$Sepal.Length[iris$Species == "setosa"]
t.test(vir, set)
# petal width setosa and versicolor
ver <- iris$Petal.Width[iris$Species == "versicolor"]
set <- iris$Petal.Width[iris$Species == "setosa"]
hist(ver)
hist(set)
emp.obs <- mean(ver) - mean(set)
null <- c()
for(i in 1:1000){
  pop <- sample(c(set, ver))
  null[i] <- mean(pop[1:50]) - mean(pop[51:100])
}
sum(abs(null)>=abs(emp.obs))/length(null)

binom.test(26, 39)
mat <- matrix(c(26,13),1,2)
chisq.test(mat)
dat <- read.csv("fights.csv")
t.test(x=dat$prefight[dat$outcome=="LOSE"],
       y=dat$postfight[dat$outcome=="LOSE"],
       paired=T)
t.test(x=dat$prefight[dat$outcome=="WIN"],
       y=dat$postfight[dat$outcome=="WIN"],
       paired=T)

