# Example of a permutation test

# read in the data
horns <- read.csv("horns.csv")

# this is what we will build our null distribution in
stat.null <- c()

# this loop will sample 10000 values of our statistic (difference in the mean)
# assuming that our two groups are from the same population.
for(i in 1:10000){
  # in class we used a seed so everyone would have the same result
  #set.seed(i) 
  
  # this creates a TRUE FALSE vector that lets us select 25 rows randomly
  picked.rows <- sample(horns$line) == "control"
  
  # we use this T/F vector to pick 25 random rows and put them in one group A
  sizes.groupA <- horns[picked.rows, 1]
  
  # we now use this same T/F vector to pick the other 25 rows and put them in 
  # a group B
  sizes.groupB <- horns[!picked.rows , 1]
  
  # now on these new samples where we have treated our two groups as one big
  # population we see how large of difference we have in our two random groups
  # we store that result as one sample of our null distribution
  stat.null[i] <- mean(sizes.groupA) - mean(sizes.groupB)
}

# here we go back to our observed data and we ask what is the difference in
# the two groups where we hypothesize that 
obs.stat <- mean(horns[1:25, 1]) - mean(horns[26:50, 1])

# now we ask how often do we see a difference as big as we observed when all
# samples are actually drawn from a single population
sum(stat.null >= obs.stat) / 10000

# we can compare this to the t-test and see what happens
t.test(horns[1:25, 1], horns[26:50, 1], alternative = "greater")

# what you should find is that your result is pretty much the same. If it 
# is not very close you can try running more itterations to get a better
# sample of the null distribution.

