x <- hist(scores$X.1[-14]*100,
     breaks=23, 
     xlim=c(0,120),
     main="midterm scores",
     xlab="points earned",
     ylab="count",
     yaxt="n",
     col=c(rep("red",6),rep("yellow",9),rep("green",10)))
axis(side=2,at=c(0,1,2,3),labels=c(0,1,2,3))
