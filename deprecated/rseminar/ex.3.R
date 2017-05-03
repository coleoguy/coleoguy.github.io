require(ape)                                                        #  This package has fnc we need

set.seed(21)                                                        #  This will make us all get the same answer

tree <- rcoal(100)                                                  #  This creates a tree by random clustering of tips

plot(tree, show.tip.label=F)                                        #  Simple plot of the tree

add.scale.bar()                                                     #  Add a scale bar

tree$edge.length <- tree$edge.length*100                            #  This multiplies every branch by 100

plot(tree, show.tip.label=F)                                        #  Simple plot of the tree                            

add.scale.bar()                                                     #  Add a scale bar

tips <- rTraitDisc(tree,                                            #  This evolves a trait across the tree
                   model = matrix(c(0,.04,.1, 0),2),                #  This is markov model of rates
                   root.value=1)                                    #  This is the state of the root

co <- c("blue","yellow")                                            #  Vector of colors

tiplabels(pch = 22, cex = .5, bg = co[as.numeric(tips)])            #  Adds a colored circle at each tip to represent the state

ans.ard <- ace(tips, tree,                                          #  Finds the ML solution to an ARD model
               model=matrix(c(0, 1, 2, 0), 2),                      #  This defines the ARD model
               type = "d")                                          #  This says we are dealing with discrete characters

ans.are <- ace(tips, tree,                                          #  Finds the ML solution to an ARE model
               model=matrix(c(0, 1, 1, 0), 2),                      #  This defines the ARD model 
               type = "d")                                          #  This says we are dealing with discrete characters

LR <- -2*ans.are$loglik + 2*ans.ard$loglik                          #  This creates the likelihood ratio

pval <- 1-pchisq(LR,1)                                              #  This compares LR to chi square dist to get a p-value


######## TYPE ONE ERROR RATE
#  Here we just repeat the above 1000 times
#  I have removed all of the graphing and exploratory steps
#  I simply generate the data (tree and tips) find the ML
#  soln to both models calculate a p-value record it and 
#  repeat this 1000 times.  Notice the set.seed(21) argument
#  is removed.  If you dont do this you will get the same answer 1000
#  times.
results<-vector()
for(i in 1:1000){
  tree <- rcoal(100)
  tree$edge.length <- tree$edge.length*100
  tips <- rTraitDisc(tree, model = matrix(c(0,.04,.1, 0),2), root.value=1)
  ans.ard <- ace(tips, tree, model=matrix(c(0, 1, 2, 0), 2), type = "d")
  ans.are <- ace(tips, tree, model=matrix(c(0, 1, 1, 0), 2), type = "d")
  LR <- -2*ans.are$loglik + 2*ans.ard$loglik
  pval <- 1-pchisq(LR,1)
  results[i]<-pval
}

# Plot Type I error
plot(density(results),col="red",lwd=3,xlab="P-value",main="Test")
abline(v=.05,lwd=3,col="blue")
text(.05,4.5,".05",col="blue",pos=4)
text(.7,3,"61% of the time we can not tell that the
ARD model is better than the ARE model")
length(which(results<.05))/length(results)


####### TYPE TWO ERROR RATES
#  We can switch to type two error by simply changing the generating
#  model.  This occurs on line 74.  if you look at the matrix argument
#  you will see that it now has .1 on for both possible transitions.
#  other than that the code for the simulation is the same.  The interpretation
#  does change though.  Now anytime we get a p-val of less than .05 we have made
#  a mistake.
results2<-vector()
for(i in 1:1000){
  tree <- rcoal(100)
  tree$edge.length <- tree$edge.length*100
  tips <- rTraitDisc(tree, model = matrix(c(0,.1,.1, 0),2), root.value=1)
  ans.ard <- ace(tips, tree, model=matrix(c(0, 1, 2, 0), 2), type = "d")
  ans.are <- ace(tips, tree, model=matrix(c(0, 1, 1, 0), 2), type = "d")
  LR <- -2*ans.are$loglik + 2*ans.ard$loglik
  pval <- 1-pchisq(LR,1)
  results2[i]<-pval
}

# Plot Type II error
plot(density(results2),col="red",lwd=3,xlab="P-value",main="Test")
abline(v=.05,lwd=3,col="blue")
text(.05,.5,".05",col="blue",pos=4)
text(.25,.5,"5.6% of the time we will mistakenly identify
the ARD model as better than the ARE model",pos=4)
length(which(results2<.05))/length(results2)