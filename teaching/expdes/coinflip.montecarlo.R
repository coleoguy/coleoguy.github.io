
# coin flip Monte Carlo

result1 <- c("T", "T", "H", "H","T","H")
result2 <- c("T", "T", "T", "T", "T")
result3 <- c("T", "T", "H", "H","T","H", "T", "T", "T",
             "T", "T", "H", "H","T","H", "T", "T", "T",
             "T", "T", "H", "H","T","H", "T", "T", "T",
             "T", "T", "H", "H","T","H", "T", "T", "T")


heads1 <- heads2 <- heads3 <- c()

for(i in 1:10000){
  print(i)
  heads1[i] <- sum(sample(c("H","T"), 6, replace=T) == "H")
  heads2[i] <- sum(sample(c("H","T"), 5, replace=T) == "H")
  heads3[i] <- sum(sample(c("H","T"), 36, replace=T) == "H")
}
barplot(table(heads1))
pval1 <- sum(heads1 >= 3)/10000


barplot(table(heads2))
pval2 <- sum(heads2 <= 0)/10000


barplot(table(heads3))
pval3 <- sum(heads3 <= 12)/10000



