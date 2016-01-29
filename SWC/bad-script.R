data("faithful")
head(faithful)
foo <- faithful[ ,2]
mode(foo)
help(mode)
Mode <- function(x) {
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}
Mode(foo)
hist(foo)
