r.mean <- function(values, type="A"){       #mine sets a default for type to "A"
  if(type=="A"){
    ans <- sum(values)/length(values)
  }
  if(type=="H"){
    ans <- length(values)/(sum(1/values))
  }
  if(type=="G"){
    ans <- prod(values)^(1/length(values))
  }
  return(ans)
}




