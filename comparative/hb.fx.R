# Heath Blackmon
# coleoguy@gmail.com
# this contains helper functions for using 
# diversitree to implement chromevol models

# takes n for the number of values needed and 
# samples from a uniform distribution between l and h
startVals <- function(n, l, h){
  start.vals <- runif(n, min=l, max=h)
  return(start.vals)
}

# this makes the data matrix for chromevol analysis
# x: is a dataframe col 1 is names col 2 is chromosome
# counts.
# excess: this how far over highest count we should
# include in the model for instance we allow that
# the highes number on phylogeny may be some point
# in the past rather than an extant lineage
# polyploids: if T then an unobserved state for polypoidy
# is created if F then basically you have the older style 
# chromevol.
datatoMatrix <- function(x, excess = .1, polyploids = T){
  matsize <- round(max(as.numeric(x[, 2])) * (1 + excess))
  if(polyploids == T){
    dmat <- matrix(0, nrow(x), matsize * 2)
    states <- c(as.character(1:matsize),
                paste(as.character(1:matsize), "p", sep = ""))
    colnames(dmat) <- states
    row.names(dmat) <- x[, 1]
    for(i in 1:nrow(x)){
      dmat[i, which(colnames(dmat) == x[i, 2])] <- .5
      dmat[i, which(colnames(dmat) == x[i, 2]) + matsize] <- .5
    }
  }
  if(polyploids == F){
    dmat <- matrix(0, nrow(x), matsize)
    states <- as.character(1:matsize)
    colnames(dmat) <- states
    row.names(dmat) <- x[, 1]
    for(i in 1:nrow(x)){
      dmat[i, which(colnames(dmat) == x[i, 2])] <- 1
    }
  }
  return(dmat)
}


# returns a constrained diversitree likelihood 
# equation
#
# arguments 
# data: this is the data matrix in the format for
# for make.mkn in diversitree
# hidden: T or F indicating if a hidden state for 
# polyploidy is present
#
# rates that are implemented include
# rate1 ascending aneuploidy - diploid      ascdip
# rate2 descending aneuploidy - diploid     descdip
# rate3 ascending aneuploidy - polyploid    ascpol
# rate4 descending aneuploidy - polyploid   descpol
# rate5 polyploidization                    polypl
# rate6 rediploidization                    redip
#
# rates 3,4,6 are only present when hidden = T
# additional constraints can be added after this
# function by using the normal constrain approach

constrainChrom <- function(data, lik, hidden=T, testing=F){
  # create and store variable for padding rate names
  if(ncol(data) < 100) pad <- 2
  if(ncol(data) >= 100) pad <- 3
  if(ncol(data) < 10) pad <- 1
  # make the matrix of rates
  parMat <- matrix(0,ncol(data),ncol(data))
  # make the components of the rate names the column and row
  # names this will allow for easy creation of constraints later
  colnames(parMat) <- sprintf(paste('%0', pad, 'd', sep=""), 1:ncol(parMat))
  rownames(parMat) <- colnames(parMat)
  # now we have a matrix with all zeros but the right state names
  # in the column and row names
  # this will allow us to fit the old fashioned chromevol 
  # model just as easily with very little overhead
  if(hidden==F){
    # currently this has the issue of missing polyploidy for q12
    # this transition should be = ascending + polyploidy
    for(i in 1:(nrow(parMat) - 1)){
      if((i * 2) <= ncol(parMat)) parMat[i, i*2] <- 5 #polyploidy
      parMat[i, (i + 1)] <- 1 #ascending aneuploidy
      parMat[(i + 1), i] <- 2 #descending aneuploidy
    }
  }
  # this is the new model with hidden states
  if(hidden==T){
    split <- ncol(parMat)/2
    for(i in 1:(split - 1)){
      if((i * 2) <= split) parMat[i, (i * 2 + split)] <- 5 #polyploidy
      parMat[i, (i + 1)] <- 1 #ascending aneuploidy - diploids
      parMat[(i + 1), i] <- 2 #descending aneuploidy - diploids
    }
    for(i in (split + 1):(nrow(parMat) - 1)){
      parMat[i, (i + 1)] <- 3 #ascending aneuploidy - polyploids
      parMat[(i + 1), i] <- 4 #descending aneuploidy - polyploids
      parMat[i, (i - split)] <- 6 #rediploidization
      if(i == (nrow(parMat) - 1)) parMat[(i + 1), (i + 1 - split)] <- 6 #rediploidization
    }
  }
  # we now have a matrix with a number 1-6 that matches the rates present
  # under either of our models hidden or not we will use this to build our 
  # arguments for the standard diversitree constrain function
  #
  # each of these vectors will hold the formulae for that class of
  # parameters (described up at the top)
  restricted <- ascdip <- descdip <- ascpol <- descpol <- polypl <- redip <- vector()
  for(i in 1:nrow(parMat)){ # by rows then
    for(j in 1:ncol(parMat)){ # by cols
      if(parMat[i, j] == 0 & i != j){
        restricted <- c(restricted, paste("q", row.names(parMat)[i], colnames(parMat)[j], " ~ 0", sep="" ))
      }
      if(parMat[i, j] == 1){
        ascdip <- c(ascdip, paste("q", row.names(parMat)[i], colnames(parMat)[j], " ~ ascdip", sep="" ))
      }
      if(parMat[i, j] == 2){
        descdip <- c(descdip, paste("q", row.names(parMat)[i], colnames(parMat)[j], " ~ descdip", sep="" ))
      }
      if(parMat[i, j] == 3){
        ascpol <- c(ascpol, paste("q", row.names(parMat)[i], colnames(parMat)[j], " ~ ascpol", sep="" ))
      }
      if(parMat[i, j] == 4){
        descpol <- c(descpol, paste("q", row.names(parMat)[i], colnames(parMat)[j], " ~ descpol", sep="" ))
      }
      if(parMat[i, j] == 5){
        polypl <- c(polypl, paste("q", row.names(parMat)[i], colnames(parMat)[j], " ~ polypl", sep="" ))
      }
      if(parMat[i, j] == 6){
        redip <- c(redip, paste("q", row.names(parMat)[i], colnames(parMat)[j], " ~ redip", sep="" ))
      }
    }
  }
  # lets store these in realy obvious names
  if(testing == F){
    formulae <- c(restricted, ascdip, descdip, ascpol, descpol, polypl, redip)
    extras <- c("restricted", "ascdip", "descdip", "ascpol", "descpol", "polypl", "redip")
    lik.con <- constrain(lik, formulae=formulae, extra=extras)
    return(lik.con)
  }
  if(testing == T){
    formulae <- c(restricted, ascdip, descdip, ascpol, descpol, polypl, redip)
    extras <- c("restricted", "ascdip", "descdip", "ascpol", "descpol", "polypl", "redip")
    results <- list(formulae, extras)
    return(results)
  }
}


