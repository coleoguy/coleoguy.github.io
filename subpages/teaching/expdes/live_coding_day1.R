# Heath Blackmon
# Day 1 script guide
# coleoguy@gmail.com

# =============================================================================
# INTRO TO R: MATH, DATA TYPES, DATA STRUCTURES, CONTROL FLOW
# Live coding session
# =============================================================================
# Everything below is scaffolding. We fill it in together.
# Rule for today: if you cannot explain what a line does, stop me.

# =============================================================================
# 0. ORIENTATION
# =============================================================================
# The console vs. the script. Why we never work in the console alone.

# Running code: ctrl/cmd + enter, and what "the cursor line" means.

# getwd(), and why hard-coded absolute paths ruin reproducibility.

# Comments: everything after # is ignored. 

# =============================================================================
# 1. R AS A CALCULATOR
# =============================================================================

# Arithmetic: + - * / ^

# Integer division and modulus: %/% and %%
# We will use %% later to test even/odd and to wrap around a vector.

# Operator precedence, and why parentheses cost nothing.

# Built-in functions: sqrt, exp, log, abs, round
# log(x) is natural log by default. log(x, base = 10) vs log10(x).

# Function arguments: by position vs. by name. Why named arguments age better.

# =============================================================================
# 2. ASSIGNMENT AND OBJECTS
# =============================================================================

# The assignment operator: <-
# Also = and ->. Which one to use and why the class standard is <-.

# Naming rules and naming conventions. Names are documentation.

# Objects persist in the environment. ls(), rm(), rm(list = ls())

# Case sensitivity. x and X are different objects.

# =============================================================================
# 3. DATA TYPES
# =============================================================================

# The five we care about: numeric, character, logical, factor

# numeric: the default. 

# character: quotes. Single vs. double quotes are equivalent.

# logical: TRUE / FALSE (and the dangerous shortcuts T / F).
# Why T <- FALSE is legal and why that should terrify you.

# Interrogating type: is.numeric(), is.character(), etc.

# Coercion: as.numeric(), as.character(), as.logical()

# Silent coercion vs. coercion with a warning.

# as.numeric("banana") and what NA-with-a-warning is telling you.

# The coercion hierarchy: logical -> integer -> character
# A vector holds ONE type. R will happily promote everything to keep that true.

# Arithmetic on logicals: sum(c(TRUE, FALSE, TRUE))
# This is the single most useful idiom in the whole language. Counting is summing.

# factor: a stored integer vector plus a levels attribute.

# =============================================================================
# 4. DATA STRUCTURES
# =============================================================================

# -----------------------------------------------------------------------------
# 4a. VECTORS (1D, one type)
# -----------------------------------------------------------------------------

# c() to combine. c() is the workhorse of R.

# Sequences: 1:10, seq(), seq_len(), seq_along()

# Repetition: rep() with times, each, length.out

# length(), names(), and naming elements of a vector

# INDEXING with [ ]
#   positive integers: pull those positions
#   negative integers: drop those positions
#   logical vector: pull where TRUE  (this is filtering)
#   character: pull by name
# One-based indexing. If you come from Python, this is your tax.

# Assignment into an index: x[3] <- 99. Vectors are mutable by position.

# Growing a vector by assigning past the end. Legal, and slow. Note it, avoid it.

# VECTORIZATION: x * 2, x + y
# No loop required. This is the R way of thinking.

# Recycling: what happens when lengths differ, and when R warns vs. stays silent.
# Recycling is a feature and a footgun.

# Vector summaries: sum, mean, median, var, sd, min, max, range, length
# na.rm = TRUE and why you should always know whether you needed it.

# Comparison operators return logical vectors: >, <, >=, <=, ==, !=

# -----------------------------------------------------------------------------
# 4b. MATRIX (2D, one type)
# -----------------------------------------------------------------------------

# matrix(data, nrow, ncol, byrow)
# byrow = FALSE is the default. Fill order matters and it will bite you.

# nrow(), ncol(), rownames(), colnames()

# Indexing: m[i, j], m[i, ], m[, j]
# The drop argument: m[, 1] gives a vector

# Building from vectors: rbind(), cbind()

# Row and column summaries: rowSums, colSums, rowMeans, colMeans

# -----------------------------------------------------------------------------
# 4c. LIST (1D, any types, can nest)
# -----------------------------------------------------------------------------

# list() and why we need it: heterogeneous and ragged data.

# Indexing is where people get hurt:
#   x[1]   -> a list of length 1
#   x[[1]] -> the element itself
#   x$name -> the element by name
# "The train car vs. what is inside the train car."

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

# -----------------------------------------------------------------------------
# 5c. WHILE LOOPS
# -----------------------------------------------------------------------------

# while (condition) { }
# Use when the number of iterations is not known in advance.

# You are responsible for making the condition eventually FALSE.
# Infinite loops, and the escape hatch (Esc / the stop button).

# A safety counter as a habit: cap iterations so a bad condition fails loudly.

# =============================================================================
# 6. RANDOM NUMBERS (setup for the challenge)
# =============================================================================

# sample(x, size, replace = TRUE)
# Rolling a die is sample(1:6, 1). Rolling five dice is one call, not five.

# set.seed(): reproducibility. Same seed, same "random" numbers.
# Every simulation in a paper should be seeded.

# =============================================================================
# 7. CHALLENGE 1: YAHTZEE
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
# One call to sample(). Confirm the result is length 5 and values are 1 to 6.
#
# -----------------------------------------------------------------------------
# STEP 2: a single hand
# -----------------------------------------------------------------------------
# Many ways to write this. Clarity beats cleverness.
# Roll all 5 dice
# Figure out the number of dice that did not land on 6 and reroll those
# Count total number of sixes and detect a Yahtzee
# Continue this process until you get a Yahtzee and keep count of attempts
#
# -----------------------------------------------------------------------------
# STEP 3: estimate P(Yahtzee on one roll) by simulation
# -----------------------------------------------------------------------------
# Loop many trials, store the result
#
# =============================================================================
# 8. CLOSING
# =============================================================================
# ?function and help(). example(). The documentation is the primary source.