fems <- read.csv("gnatocerus.female.csv")
mals <- read.csv("gnatocerus.male.csv")
cor.test(fems$body, fems$offspring)
cor.test(mals$body, mals$horn)
par(mfcol = c(1, 2))
par(pch = 16, cex = .6)
plot(fems$offspring ~ fems$body, 
     col = rgb(.5,.4,0,.5),
     xlab = "Body Size", 
     ylab = "Offspring Number",
     main = "Females")
plot(mals$horn ~ mals$body, 
     col = rgb(.5,.4,0,.5),
     xlab = "Body Size", 
     ylab = "Horn Size",
     main = "Males")
cor.test(mals$mating.attempts, mals$horn)
cor.test(mals$mating.attempts, mals$body)
cor.test(mals$mating.attempts, lm(mals$horn ~ mals$body)$residuals)
cor.test(mals$grandchildren, mals$horn)
cor.test(mals$grandchildren, mals$body)
cor.test(mals$grandchildren, mals$mating.attempts)
cor.test(mals$grandchildren, lm(mals$horn ~ mals$body)$residuals)
plot(mals$mating.attempts ~ mals$horn, 
     col = rgb(.5,.4,0,.5),
     xlab = "Horn Size", 
     ylab = "Mating Attempts",
     main = "Sexual Selection")
plot(mals$grandchildren ~ mals$body, 
     col = rgb(.5,.4,0,.5),
     xlab = "Body Size", 
     ylab = "Grandchildren",
     main = "Daughter Fitness")

