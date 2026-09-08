# Heath Blackmon
# Day 1 script guide
# coleoguy@gmail.com

# =============================================================================
# INTRO TO R: MATH, DATA TYPES, DATA STRUCTURES, CONTROL FLOW
# =============================================================================
# Rule for today: if you cannot explain what a line does, stop me.

# =============================================================================
# 0. ORIENTATION
# =============================================================================
# Console vs. script. We work in the script so the work is reproducible.
# Run a line: ctrl/cmd + enter.
# Everything after # is ignored.

# =============================================================================
# 1. R AS A CALCULATOR
# =============================================================================

3 + 5
3 - 7
3 * 2
5 / 2
4^2
7 %% 3           # remainder. We use this later for even/odd
7 %/% 3          # integer division

# Precedence is real. Parentheses cost nothing.
2 + 3 * 4
(2 + 3) * 4

sqrt(81)
exp(1)
log(100)         # natural log by default
log(100, base = 10)
abs(-3)
round(3.14159, 2)

# Special values.
1 / 0            # Inf
0 / 0            # NaN
NA               # missing
NULL             # absent

# Arguments by position vs. by name. These three are identical.
matrix(data = 1:12, nrow = 4, ncol = 3)
matrix(1:12, 4, 3)
matrix(ncol = 3, data = 1:12, nrow = 4)
# This one is different. Position is fragile, names age well.
matrix(1:12, 3, 4)

# =============================================================================
# 2. ASSIGNMENT AND OBJECTS
# =============================================================================

foo <- 5         # class standard
foo = 4          # legal, avoid
6 -> foo         # legal, avoid harder
foo

# Case sensitivity bites.
Foo <- 100
foo
Foo

ls()             # what is in the environment
rm(foo)
ls()
rm(list = ls())  # clean slate

# =============================================================================
# 3. DATA TYPES
# =============================================================================

# numeric, integer, character, logical, factor
x <- 1:10
y <- c("heath", "jen", "LT")
z <- c(TRUE, FALSE, TRUE)

class(x); class(y); class(z)
is.numeric(x)
is.numeric(y)

# A vector holds ONE type. R promotes to keep that true.
# Hierarchy: logical -> integer -> double -> character
c(5, 8, TRUE, FALSE)          # logicals become 1 and 0
c("heath", 5, TRUE)           # everything becomes character

# Coercion you asked for, and coercion you did not.
as.numeric("42")
as.numeric("banana")          # NA plus a warning is R telling you it gave up
as.character(1:3)
as.logical(c(0, 1, 2))

# Logicals are numbers. Counting is summing. Use this constantly.
sum(c(TRUE, FALSE, TRUE, TRUE))
mean(x > 5)                   # proportion of x greater than 5

# factor: an integer vector plus a levels attribute
site <- factor(c("north", "south", "north", "east"))
site
levels(site)
as.integer(site)              # the codes, not the labels

# The classic disaster: a factor of numbers.
nums <- factor(c(10, 20, 30))
as.numeric(nums)              # 1 2 3, not 10 20 30
as.numeric(as.character(nums))# what you meant

# =============================================================================
# 4. DATA STRUCTURES
# =============================================================================

# -----------------------------------------------------------------------------
# 4a. VECTORS (1D, one type)
# -----------------------------------------------------------------------------

c(1, 5, 9)
1:10
seq(0, 1, by = 0.25)
seq(0, 1, length.out = 5)
seq_len(5)
rep("Heath", 3)
rep(c("a", "b"), times = 3)
rep(c("a", "b"), each = 3)

x <- c(10, 20, 30, 40, 50)
length(x)
names(x) <- c("a", "b", "c", "d", "e")
x

# Four ways to index.
x[2]                  # position
x[-2]                 # drop a position
x[c(TRUE, FALSE, TRUE, FALSE, TRUE)]   # logical: this is filtering
x["c"]                # by name

x[3] <- 99            # mutable by position
x
x[8] <- 1             # growing past the end is legal, slow, and fills NA
x

# Vectorization. No loop required.
v <- 1:10
v * 2
v + v
v^2

# Recycling: shorter operand is reused.
v + c(0, 100)         # silent, lengths divide evenly
v + c(0, 100, 200)    # warning, they do not

# Logical filtering, the workhorse idiom.
v %% 2 == 0
v[v %% 2 == 0]        # evens
v[v %% 2 != 0]        # odds
which(v > 7)          # positions, not values
any(v > 7); all(v > 7)

# Summaries, and the NA question.
w <- c(4, 8, NA, 15, 16)
mean(w)
mean(w, na.rm = TRUE)
sum(w, na.rm = TRUE); sd(w, na.rm = TRUE); range(w, na.rm = TRUE)
is.na(w)
sum(is.na(w))         # how many are missing

# -----------------------------------------------------------------------------
# 4b. MATRIX (2D, one type)
# -----------------------------------------------------------------------------

a <- matrix(1:12, nrow = 4, ncol = 3)
a <- matrix(data = 1:12, nrow = 4, ncol = 3)
b <- matrix(4,  3, 1:12)
a == b
matrix(1:12, nrow = 4, byrow = TRUE)   # fill order matters

nrow(a)
ncol(a)
rownames(a) <- paste0("r", 1:4)

paste0("r", 1:4)
paste("r", 1:4)

colnames(a) <- c("x", "y", "z")
a

a[2, 3]               # one cell
a[2, ]                # row 2, returned as a vector
a[, "y"]              # column y by name
a[, 1, drop = FALSE]  # keep it a matrix

rbind(a, c(0, 0, 0))
cbind(a, w = 13:16)

rowSums(a); colMeans(a)

a * 2                 # elementwise
a %*% t(a)            # matrix multiplication


# -----------------------------------------------------------------------------
# 4c. LIST (1D, any types, can nest)
# -----------------------------------------------------------------------------

# list() and why we need it: heterogeneous and ragged data.

# Indexing is where people get hurt:
#   x[1]   -> a list of length 1
#   x[[1]] -> the element itself
#   x$name -> the element by name
# "The train car vs. what is inside the train car."


students <- list()
students[[1]] <- c("dan","john","cindy")
students[[2]] <- c(89, 78, 97)
students[[3]] <- matrix(1:12, 3,4)
students[[4]] <- c("bob", "Pam")
x <- students[4]
y <- students[[4]]


# -----------------------------------------------------------------------------
# 4d. DATA.FRAME (2D, columns of any type, equal length)
# -----------------------------------------------------------------------------

# A data.frame IS a list of equal-length vectors, with a class attribute.
# Prove it: is.list(df), and index it like a list.

# data.frame(), 

# Indexing two ways: df[i, j] like a matrix, df$col and df[["col"]] like a list.

# Adding a column, removing a column (assign NULL).

# Filtering rows with a logical vector. Base R subsetting, no packages needed.

# Built-in data to play with: mtcars, iris

gradebook <- data.frame(students = c("bob","sandy"),
                        grades = c(59, 89),
                        passing = rep(NA, 2))

gradebook[,2] >= 70

gradebook[,3] <- gradebook[,2] >= 70
gradebook$passing <- gradebook$grades >= 70
foo <- as.data.frame(matrix(1:12,3,4))
bar <- matrix(1:12,3,4)

# -----------------------------------------------------------------------------
# 4e. STRUCTURE CHEAT SHEET
# -----------------------------------------------------------------------------
#            1 dimension        2 dimensions
# same type  vector             matrix
# any type   list               data.frame
# Know which box you are in before you index.

# =============================================================================
# 5. CONTROL STRUCTURES
# =============================================================================

# -----------------------------------------------------------------------------
# 5a. IF / ELSE
# -----------------------------------------------------------------------------

# if (condition) { } else if (condition) { } else { }

# The condition must be length 1. In modern R, a length > 1 condition is an
# error, not a warning. Old code that relied on the warning is now broken.

# -----------------------------------------------------------------------------
# 5b. FOR LOOPS
# -----------------------------------------------------------------------------

# for (i in vector) { }
# i takes each VALUE of the vector, not an index. Looping over values vs indices.

# PREALLOCATE the result. Growing a vector inside a loop reallocates every pass.
# Time both with system.time() so the cost is visible, not theoretical.

for(i in 1:10){
  # all the stuff you want to do over and over
  print(i)
}



# -----------------------------------------------------------------------------
# 5c. WHILE LOOPS
# -----------------------------------------------------------------------------
# Sets a seed for reproducibility
set.seed(5)
# this sets working to true so the while loop can begin to run
working <- TRUE
# this sets up a counter to track draws
counter <- 0
# this begins the while loop as long as working is true
while(working){
  # this incremenmts the counter by 1
  counter <- counter + 1
  # this is the real work of the loop making a draw from a normal dist
  x <- rnorm(1)
  # this if statement sees whether we drew a value we are targeting
  if(x > 3){
    # this prints the draw number and value that met our conditions
    print(paste0(counter, ": ", x))
    # this sets working to falsse so the loop can stop
    working <- F
  }
  # this gives us an intermediate status indicator so we know what is happening
  if(counter %% 10 == 0){
    print(counter)
  }
}

# write a for loop that prints odd numbers and 
# even numbers between 1 and 1000 based on some choice you make

for(i in 1:1000){
  if(i %% 2 != 0){
    print(i)
  }
}





# =============================================================================
# 6. RANDOM NUMBERS (setup for the challenge)
# =============================================================================

# sample(x, size, replace = TRUE)
# Rolling a die is sample(1:6, 1). Rolling five dice is one call, not five.
set.seed(1)
sample(1:10, size=10, replace=T)
sample(3, 1)
rnorm(5, mean=20, sd=.01)

rpois(10, 3)
hist(rexp(1000, 10))
runif(10)

# set.seed(): reproducibility. Same seed, same "random" numbers.
# Every simulation in a paper should be seeded.
#
#
#
#
# 
# =============================================================================
# 7. Reading and writing files
# =============================================================================
# read.csv() write.csv
data(iris)
iris
write.csv(iris, file="r-iris.csv", row.names = F)
myiris <- read.csv("r-iris.csv")
# 
# =============================================================================
# 8. base plotting
# =============================================================================
# plot, hist, pars
# 
plot(iris$Sepal.Width ~ iris$Petal.Length)
hist(rexp(1000))
plot(density(rexp(1000)))

# =============================================================================
# 9. CHALLENGE 1: YAHTZEE
# =============================================================================
# Goal: simulate the game well enough to answer questions with data instead of
# intuition. Build it in pieces, test each piece, then assemble.
#
# Question: Whats the average number of hands you have to play to get a Yahtzee
# rolling 5 sixes
#
# -----------------------------------------------------------------------------
# STEP 1: roll five dice
# -----------------------------------------------------------------------------
#
# -----------------------------------------------------------------------------
# STEP 2: first roll
# -----------------------------------------------------------------------------
#
#
# -----------------------------------------------------------------------------
# STEP 3: second roll
# -----------------------------------------------------------------------------
#
#
# -----------------------------------------------------------------------------
# STEP 4: evaluate rolls
# -----------------------------------------------------------------------------
#
# -----------------------------------------------------------------------------
# STEP 5: estimate P(Yahtzee on a given turn) by simulation
# -----------------------------------------------------------------------------
# Loop many trials, store the result
#
# =============================================================================
# 10. CLOSING
# =============================================================================
# help()