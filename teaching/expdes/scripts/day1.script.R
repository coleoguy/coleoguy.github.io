# Heath Blackmon
# coleoguy@gmail.com
# this code provides and introduction to the
# basics of R. Alls students should insure that
# everything in this script makes sense if not
# ask questions!

# R is a cacluator
4 + 5
4 ** 2
4 ^ 2
8 / 3
10 %% 3

# variables are objects that we can store data in
# once we make a vairable we can use the data in
# it just like we would the original values

# we assign data to a variable using the assignment operator <-
# here we create a numeric vector of length one
x <- 3

# vectors can contain any number of values we can concatenate
# multiple values into a variable using the function c
x <- c(1, 4, 9)

# these have all been numeric data but we can also store strings
# or logical values in a vector
x <- c("don", "jen")

# when using logicals we can use T or TRUE for true
# and F or FALSE for false values
x <- c(T, F, TRUE)

# vectors must have all the same type of data
# if we attempt to store two types of data in a
# vector it will change the data type to the type
# that accomodate whatever we have tried to combine
x <- c(1, "Andy")
x
# in this case it has converted the numeric value
# 1 to a text string

x <- c("Jen", TRUE)
x
# the same thing has happend here TRUE has been
# converted to a text string


# to access items in a vector we use square brackets [ ]
x <- 1:10 
# seperating two numbers with : tells R to use all numbers 
# between and including those numbers
# lets pull out the 5th value
x[5]

# we can also store new values in a vector the same way
x[5] <- 100
x
# we can see that the 5th element of th vector is now 100

# often we will want a more complex data structure than a vector
# one of the most common that we will use is a table. In R this
# can be either a matrix or a dataframe. The difference in these
# is that a matrix must have only one type of data. That is all
# numeric values, all logical values, all text strings. In contrast,
# a dataframe can hold a different type of data in each column

# to make a matrix we can use the matrix command
x <- matrix(1:12, 4, 3) 
# first argument is the data 1:12
# second argument is the number of rows
# third argument is the number of columns
x

# if we have some vectors we want to combine into a matrix we can
# use the commands rbind or cbind to bind the vectors together by
# rows or by columns
a <- 1:10
b <- 31:40
c <- 101:110
x <- cbind(a,b,c)
x <- rbind(a, b, c)

# if we want to access certain parts of our matrix we use square brackets [ ] 
x[1, 3] # this gives us the first row and third column

# we use the same approach to store new data
x[1, 3] <- 500

# just like we saw with vectors if we try to put a different type of
# data in this we will find that R changes all the data to match
x[2, 1] <- "jenny"


# to  make a dataframe we use the command data.frame
a <- 1:10
b <- rep(T, 10) # the rep command replicates T ten times in this case
c <- rep("Abbi") # here rep replicates "abbi" ten times
x <- data.frame(a, b, c)

# R also has logical operators that allow us to compare
# values

# == tests if two things are equal
# != tests if two things are unequal
# %in% askes if one things is contained in another

1 == 3
1 != 3
3.2 == 3.2
"jen" == "jon"
"jen" == "jen"
5 %in% c(1, 2, 3, 6, 8, 23)
8 %in% c(1, 2, 3, 6, 8, 23)

# control structures are where the power in coding comes
# from lets look at for if and while

# for repeats a block of code between the curly braces
# each time that it runs i will take a new value
for(i in 1:10){
  print(i)
}

for(i in 20:80){
  x <- i / 5
  print(x)
}


# if will run code only if its argument is true
# lets use it to print odd numbers
for(i in 1:10){
  if(i %% 2 != 0){
    print(i)
  }
}

# while will run code till its argument is false
# lets use it to find the first number that is divisible by 3, 7 and 17
looking <- TRUE
counter <- 1
while(looking){
  if(counter %% 17 == 0){
    if(counter %% 7 == 0){
      if(counter %% 3 == 0){
        print(counter)
        looking <- FALSE
      }
    }
  }
  counter <- counter + 1
}

# R has lots of distributions we will use these often when
# simulating here is an example of using the normal distribution

koala1 <- rnorm(n=1000, mean=.3, sd=.05)
plot(density(koala1))

# here is an example of the poisson distribution
koala.sightings <- rpois(100, lambda=3)
hist(koala.sightings)
