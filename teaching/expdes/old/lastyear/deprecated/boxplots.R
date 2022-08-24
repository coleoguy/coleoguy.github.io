x <- read.csv("example.csv")

boxplot(x$y, x$x,  x$z, 
        col=c(rgb(1,0,0,.5),
              rgb(0,0,1,.5),
              rgb(.5,0,.5,.5)),
        boxwex=.4)
for(i in 1:21){
  lines(x=c(.5,.75),
        y=c(x$y[i], x$y[i]), 
        col=rgb(1,0,0,.5),
        lwd=1.8)
}
for(i in 1:21){
  lines(x=c(1.5,1.75),
        y=c(x$x[i], x$x[i]), 
        col=rgb(0,0,1,.5),
        lwd=1.8)
}
for(i in 1:21){
  lines(x=c(2.5,2.75),
        y=c(x$z[i], x$z[i]), 
        col=rgb(.5,0,.5,.5),
        lwd=1.8)
}


