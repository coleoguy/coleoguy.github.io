library(ape)
# simulate some data
set.seed(1)
tree <- rtree(10)
# check the tree
plot(tree)

# set up some smoothing parameters
l <- 10^(-1:6)
cv <- numeric(length(l))

# this does the cross validation step for each parameter value
for (i in 1:length(l)){
  print(i)
  cv[i] <- sum(attr(chronopl(tree, lambda = l[i], CV=TRUE), "D2"))
}

# this is the result (low is better)
plot(l, cv)

# new tree
new.tree <- chronos(tree, lambda=.1, model="correlated")
plot(new.tree)

# scaling to root age
root <- 72
new.tree$edge.length <- new.tree$edge.length * root
plot(new.tree)
