library(ape)

tree <- rcoal(50)
plot(tree, cex=.5)
trait1 <- rTraitCont(phy = tree, model = "BM", sigma = 2, root.value = 10)
trait2 <- rTraitCont(phy = tree, model = "BM", sigma = 2, root.value = 10)
plot(trait1 ~ trait2)
cor.test(trait1, trait2)
fit <- lm(trait1 ~ trait2)
summary(fit)
tree$tip.label
plot(trait1 ~ trait2, col=c(rep("blue", 36), rep("green",14)), pch=16)
