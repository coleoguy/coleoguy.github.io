## PART 1 SIMULATE 10 BIRTH DEATH TREES UNDER A CONSTANT RATE OF YOUR CHOICE
## PLOT THEM AND SEE WHAT KIND OF VARIANCE THERE IS UNDER THIS EQUAL RATES
## MODEL.  THIS SHOULD ILLUSTRATE TO YOU WHY DIVERSIFICATION RATE IS SUCH A HARD
## THING TO SIGNIFICANT SHIFTS IN.

# phytools has a nice BD simulation so lets try using that
library(phytools)

# first we simulate the trees I am doing 20 so that we hopefully will still have 
# 10 after getting rid of the ones that have no extant lineages.
set.seed(2)
tree<-pbtree(b = 1, d = .5, t = 6, extant.only = T, nsim = 20)

# next we can create a vector and record whether or not a tree has
# any surviving lineages
extants <- vector()
extants[1:20] <- F
for(i in 1:20) if(length(tree[[i]]$tip.label) > 0) extants[i] <- T

# ok lets get rid of those extinct ones
tree <- tree[extants]

# now we are just going to set up a plot window that will be 2 rows by 5 collumns
par(mfcol = c(2,5))
# and now plot the trees
for(i in 1:10) plot(tree[[i]], show.tip.label = F)

# to me the most striking part of this display is how a long branch in the begining has 
# such a huge impact on the extant diversity


## PART 2 MODIFY YOUR CODE TO PRODUCE AT LEAST 50 TREES AND MAKE A HISTOGRAM
## SHOWING THE DISTRIBUTION OF EXTANT LINAGES AMONG YOUR 50 TREES
set.seed(3)
tree<-pbtree(b = .5, d = .25, t = 6, extant.only = T, nsim = 100)
# next we can create a vector and record whether or not a tree has
# any surviving lineages
extants <- vector()
extants[1:100] <- F
for(i in 1:100) if(length(tree[[i]]$tip.label) > 0) extants[i] <- T
# ok lets get rid of those extinct ones
tree <- tree[extants]
# lets record the number of tips
tip.numbs <- vector()
for(i in 1:length(tree)){
  tip.numbs[i] <- length(tree[[i]]$tip.label)
}
par(mfcol = c(1, 1))
hist(tip.numbs)
plot(density(tip.numbs))



## PART 3 MAKE TWO SETS OF 50 TREES WITH THE SAME EXTINCTION RATE BUT A SPECIATION
## (BIRTH) RATE THAT IS 50% HIGHER.  MAKE A DENSITY PLOT FOR EACH SET OF TREES TO SEE
## HOW MUCH OVERLAP THERE IS.

# first i'll just save what I made before to use here we will call them slow
slow.trees <- tree
slow.tip.numbs <- tip.numbs

# the lets just copy and paste our code from above with the only change being that 
# speciation rate.
set.seed(1)
tree<-pbtree(b = .75, d = .25, t = 6, extant.only = T, nsim = 100)
extants <- vector()
extants[1:100] <- F
for(i in 1:100) if(length(tree[[i]]$tip.label) > 0) extants[i] <- T
tree <- tree[extants]
tip.numbs <- vector()
for(i in 1:length(tree)){
  tip.numbs[i] <- length(tree[[i]]$tip.label)
}
par(mfcol = c(1, 1))
# now we will plot both sets
plot(density(tip.numbs), ylim = c(0,.05), col = 'red')
lines(density(slow.tip.numbs), col = 'blue')

$# so with the numbers that I picked the distributions are largely overlapping
# there is obviously a shift; but think about drawing numbers at random from
# one of these two distributions how many draws would it take to tell which of these
# distributions were being sampled; and this isn't even as hard as what you are doing
# in real life where the underlying distribution is unknown and you are attempting
# instead to tell whether or not you are drawing from the same unkown underlying 
# distribution.

## PART 4 COME UP WITH SOME OTHER WAY OF LOOKING AT THE CHARACTERISTICS OF THESE TREES
## THAT YOU THINK MIGHT BE MORE INFORMATIVE THAN SIMPLY THE NUMBER OF TIPS GRAPH SOMETHING
## COOL TO SHOW ME WHY YOU ARE RIGHT.

# as an example why dont we look at the distance between nodes.
# to do this the first step is tro drop the terminal branches we aren't intrested in
# those.  Liam has a handy function for this called drop.leaves

# first lets look at just 100 trees of each kind so sampling is the same (I should have
# done this above in the stuff that we were doing earlier - would this bias the results
# if so in what way and how might we correct for it) Because I am interested in
# the distance between nodes trees with just a couple of tips are not useful and will throw
# an error when you try to remove the termial branches. So I am going to get rid of 
# the smallest of the small trees from both datasets.  We can discuss later how this
# will bias my result.
slow.trees <- slow.trees[slow.tip.numbs > 5]
tree <- tree[tip.numbs > 5]
slow.trees <- lapply(slow.trees, drop.leaves)
tree <- lapply(tree, drop.leaves)
class(slow.trees) <- 'multiPhylo'
class(tree) <- 'multiPhylo'

# now lets extract the branch lengths which are now really just internode distances
# first at the lower speciation rate
slow.dist <- list()
for(i in 1:50){
  slow.dist[[i]] <- slow.trees[[i]]$edge.length
}
slow.dist <- unlist(slow.dist)

# now at the higher speciation rate
fast.dist <- list()
for(i in 1:50){
  fast.dist[[i]] <- tree[[i]]$edge.length
}
fast.dist <- unlist(fast.dist)

# lets plot 400 draws from each of these distributions and just see what it looks like
set.seed(1)
plot(density(sample(fast.dist, 400)), col = 'red')
set.seed(1)
lines(density(sample(slow.dist, 400)), col = 'blue')