# Heath Blackmon
# coleoguy@gmail.com
# this code provides and introduction to the
# basics of R. All students should insure that
# everything in this script makes sense if not
# ask questions!

## R is a cacluator
## There are many different operatiors like these
## + -  **  ^  *  /  %%   :

4 + 5 + 4
12 - 4
4 ** 2
4^2
8/3
8 %% 5
3:7
sqrt(81)

## variables and <-

x <- 5 # Good
x = 5 # Bad
x -> y
x <- y

## Data types
# numeric
x <- 5.23423
# character
x <- "yes"
# logical
x <- F

## Data structures

# a vector
x <- c(9, 4, 1, 6, 8, 0)
x <- c(99, TRUE, "Heath")

# a matrix
x <- matrix(1:15, ncol=3, nrow=5)

# a dataframe
x <- data.frame(c("Heath", "Jen","LT"),
                c(99, 100, 85))

# a list
x <- list(x, 9, TRUE)

## Brackets
x <- 1:10

# accessing with logical vectors
x[c(F,F,F,F,F,F,F,F,F,T)]
y <- (1:10 %% 2) != 0

# accessing with a variable
x[y]

# accessing matrices and dataframes
x <- matrix(1:15, 5, 3, T)
x[2,c(1,3)]

# lets make some vectors
names <- c("Sean","Andres","Michelle","Jorja")
grades <- c(87,98,89,96)
# now lets form these into a dataframe
class <- data.frame(names, grades)

# data frames can be accessed by column names
class$names[class$grades>=90]
class$names[class$grades>=90] <- c("bob","joan")


## Control structures for if while

# for is used to repeat code blocks 
# if is used to run code only under certain conditions
for(i in 1:10){
  if(i %% 2 == 0){
    print(i)
  }
}

# While is a bit different
# we need a variable to monitor to decide
# when we should quit executing our code
# for this instance lets use the variable name
# rolling
rolling <- T
# lets just set up a little counter to track performance
count <- 1
# we begin our while statement
while(rolling){
  # simulated dice roll
  roll <- sample(x=1:6, size=1)
  # checking to see if we rolled a six
  if(roll == 6){
    # if we did we want to stop rolling dice
    rolling <- F
  }
  if(count > 10){
    print("I give up these dice are loaded")
    rolling <- F
  }
  # lets increment count so we know how unlucky or lucky we are
  count <- count + 1
}

# lets look at another example of using a for loop


types <- c("white","dark","milk","melted","ruby","mint")
for(chocolate in types){
  print(paste("I love", chocolate, "chocolate"))
}

# Lets look at running another while loop
searching <- T
x <- 999999
while(searching){
  print(".")
  x <- x + 1
  ans <- x %% 2347 == 0
  if(ans){
    searching <- F
  }
}
print(x)


## Distributions rnorm, rpois, rexp
# a seed will make it so we get the same
# random answer
set.seed(1)

# normal distribution
x <- rnorm(n = 3457934, mean = 23.6545, sd = 5)
mean(x)
hist(x)

# poisson distribution
x <- rpois(n = 100, lambda = 42)
hist(x)

# uniform distribution
x <- runif(1000)
hist(x)


## Simple plots plot, hist, boxplot

# first lets make some data to play with
# simulated melatonin
mel <- rnorm(n = 100, mean = 0.5, sd = .1)
hist(mel)

# simulated pulse rates
# we use the mean of 1-mel to create a negative
# correlation
pulses <- rnorm(n = 100, mean = 1-mel, sd = .01)

# simulate some colors
color <- sample(x=c("chocolate","blue"), 100, 
              replace=T, prob=c(.25,.75))

# now we can visualize this simulated data
plot(x=mel, y=pulses, # variables to plot on X and Y
     xlab="melatonin (mg/ml)", # x axis label
     ylab="pulses per min", # y axis label
     pch=16, # shape to plot
     cex=.5, # size of shapes
     col=color, # color of points
     las=1, # orientation of axis labels
     xlim=c(0.2,.75), # limits of Y axis
     ylim=c(0.3,0.8)) # limits of X axis


## Reading and writing data in R

# lets make a dataframe with our jellyfish data
dat <- data.frame(pulses, mel, color)

# now lets save our data
write.csv(dat, file="dat.csv")

# lets clear our memory
rm(list=ls())

# lets read back in the data
dat <- read.csv("dat.csv")

# now lets plot it again
# this time I will use the $ approach
# to access the data that we need
plot(dat$pulses~dat$mel, # variables to plot on X and Y
     xlab="melatonin (mg/ml)", # x axis label
     ylab="pulses per min", # y axis label
     pch=16, # shape to plot
     cex=.5, # size of shapes
     col=dat$color, # color of points
     las=1, # orientation of axis labels
     xlim=c(0.2,.75), # limits of Y axis
     ylim=c(0.3,0.8)) # limits of X axis
