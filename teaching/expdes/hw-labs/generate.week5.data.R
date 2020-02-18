
# read in horn size data
lowl <- round(rnorm(25, mean=1.1, sd=.4),digits=2)
highl <- round(rnorm(25, mean=1.3, sd=.2),digits=2)
t.test(lowl,highl)
line <- rep(c("control","large"), each=25)
dat <- data.frame(c(highl,lowl),line)
colnames(dat) <- c("horn.length","line")
write.csv(dat, row.names = F, file="horn.size.selection.csv")

dat <- as.data.frame(matrix(NA,30,4))
for(i in 1:30){
  # pretreatment
  dat[i, 1] <- round(runif(min=15,max=23,n=1), digits=1)
  # post initial crush
  if(i %in% c(3,14)){
    dat[i, 2] <- round(runif(min=15,max=23,n=1), digits=1)
  }else{
    dat[i, 2] <- round(runif(min=0,max=5,n=1), digits=1)
  }
  # after recovery
  dat[i, 3] <- round(runif(min=12,max=23,n=1), digits=1)
  # after recrush
  if(i %in% c(2,27)){
    dat[i, 4] <- round(runif(min=15,max=23,n=1), digits=1)
  }else{
    dat[i, 4] <- round(runif(min=0,max=5,n=1), digits=1)
  }
}
colnames(dat) <- c("precrush", "postcrush",
                   "recovered", "recrush")
write.csv(dat, row.names = F, file="grasshopper.neuro.csv")


lizard <- matrix(,30,2)
colnames(lizard) <- c("size","loc")
lizard[1:15,2] <- "brazos"
lizard[16:30,2] <- "harris"
lizard <- as.data.frame(lizard)

lizard[1:15,1] <- rnorm(15, mean=10,sd=.2)
lizard[16:30,1] <- rnorm(15, mean=12,sd=.2)

x <- sample(lizard$loc)
lizard$size[x=="brazos"] - lizard$size[x =="harris"] 
