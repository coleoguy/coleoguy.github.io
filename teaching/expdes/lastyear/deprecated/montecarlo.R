# Heath Blackmon
# coleoguy@gmail.com
# script to run a monte carlo analysis
# of retrogenes in T. confusum

# iter will hold the number of replicates that 
# we wish to perform
iter <- 1000

# this will hold the result of each simulation
retrogenes <- matrix(, 4, iter)

# this is the loop that will effectively simulate
# evolution and the orgin of new retrogenes
for(i in 1:iter){
  # I'm going to set a seed value so that whoever runs
  # this script will get the same result as I did
  # mainly this is important becuase random variation 
  # between runs would lead to different margins which 
  # would mess up where I am putting the text at the end
  set.seed(i)
  # this is just a counter so we can know if
  # our loop is running
  print(i)
  # this performs the simulation pulling origins of 
  # retrogenes with a probability that is based
  # on the number of genes present on each chromosome
  c.retro <- sample(c("X","1","2","3"), 
                     15, 
                     replace = T,
                     prob = c(124, 260, 173, 147))
  # these next four lines simply count up the number
  # of retrogenes that originated on each chromosome
  retrogenes[1, i] <- sum(c.retro == "X")
  retrogenes[2, i] <- sum(c.retro == "1")
  retrogenes[3, i] <- sum(c.retro == "2")
  retrogenes[4, i] <- sum(c.retro == "3")
}

# these four lines give us empirical p-values for
# each of our simulations
sum(retrogenes[1, ] >= 7) / iter
sum(retrogenes[2, ] >= 3) / iter
sum(retrogenes[3, ] >= 2) / iter
sum(retrogenes[4, ] >= 3) / iter

# this is an example of writing data to the desktop
write.csv(retrogenes, 
          file = "retrogenes.csv", 
          row.names = F)

# now we are reading data in from the desktop
dat <- read.csv("retrogenes.csv")

# this will just store the results for the X chromosome
# in a vector named x
x <- as.numeric(dat[1, ])

# this stores the p-value
pval <- round(sum(as.numeric(dat[1,]>=7))/1000, digits=3)

# this is a histogram of our simulation
hist(x)

# this is a plot of the simulation
plot(density(x, bw=.5),
     main="X chromosome retrogenes",
     xlab="Number of retrogenes",
     col="purple",
     lwd = 2)

# this will shade the area under the curve
polygon(density(x, bw=.5), 
        col=rgb(.5,0,.7, .5),
        border = NA)

# this will add a line that shows what we got
abline(v=7, col="red", lwd=2, lty=3)

# this will add some text to our plot
text(x= 5.3, y=.24, 
     paste("observed\nretrogenes\np=",pval, sep=""),
     cex=.6,
     col="red")


