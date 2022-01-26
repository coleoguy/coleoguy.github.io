rearing <- sample(c("isolated","social"), size=500, replace=T)
parental.mean <- runif(min=0, max=10, n=500)
age.class <- sample(c("a","b","c"), size=500, replace=T)
size <- rnorm(mean=5, sd=1, n=500)
x <- 2 * as.numeric(as.factor(rearing)) + 
    .2 * parental.mean + 
     1 * as.numeric(as.factor(age.class)) +
    .5 * size

y <- rnorm(mean=x, sd=3,n=500)
hist(y)
range(y)
y[y<0]<-0
y[y>10]<-10
summary(glm(y~age.class+rearing+parental.mean+size))

color <- sample(c("blue","red","black"), size=500, replace=T)
origin.con <- sample(c("chi", "usa","jap","vie"), size=500, replace=T)
c.fin.length <- rnorm(mean=size*.4, sd=.2, n=500)
mated <- sample(c("yes","no"), size=500, replace=T)

fight.won <- y
dat <- data.frame(round(y), origin.con, rearing, mated, age.class, 
                  parental.mean, size, c.fin.length, color)
dat$age.class[dat$age.class=="b"] <- "temp"
plot(y~age)
     
     
     write.csv(dat, "betta_splendens.csv")
     
     
     
dat <- read.csv("betta_splendens.csv")
fit <- glm(dat$fight.won~dat$rearing+dat$age.class+dat$parental.mean+dat$size)
fit2 <- glm(dat$fight.won~dat$rearing+dat$age.class+dat$parental.mean+dat$size, poisson)
