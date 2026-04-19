dat <- read.csv("retrogene.csv")
parents <- daughters <- c()
for(i in 1:100000){
  parents[i] <- sum(sample(1:10, size = 142, 
                        prob = dat[1,2:11]/dat[1,12],
                        replace = T) == 2)
  daughters[i] <- sum(sample(1:10, size = 142, 
                        prob = dat[2,2:11]/dat[2,12],
                        replace = T) == 2)
  
}
sum(parents>=45)/100000
sum(daughters>=40)/100000
