foo <- read.csv(url("http://coleoguy.github.io/SWC/geyser.csv"))
head(foo)
foo <- foo[ ,3]
mode(foo)
help(mode)
Mode <- function(x) {
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}
Mode(foo)
hist(foo)
