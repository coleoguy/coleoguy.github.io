library(ggplot2)
library(gridExtra)
data(iris)

a <- ggplot(iris, aes(x=Species, y=Sepal.Length)) +
       geom_dotplot(binaxis = "y", stackdir = "center")

b <- ggplot(iris, aes(x=Sepal.Length, fill=Species)) +
       geom_histogram(position="dodge")

grid.arrange(a,b)

ggplot(iris, aes(x=Sepal.Length, y= Sepal.Width)) +
  geom_point() +
  geom_smooth(method="lm", col="black", size=.5) +
  facet_wrap(~Species, scales="free_x") +
  theme_bw() +
  xlab("Sepal length (cm)") +
  ylab("Sepal width (cm)")

ggsave("plot.pdf", width=6, height=2)
library(ggraptR)

ggraptR(iris)

ggplot(iris, aes(y=Sepal.Width, x=Sepal.Length)) +
  geom_point(stat="identity", position="jitter", alpha=0.5, size=3) +
  geom_smooth(stat="smooth", position="identity", method="lm",
              se=TRUE, n=80, level=0.95, span=0.75) +
  facet_grid(. ~ Species, scales="free_x") +
  theme_bw() +
  theme(text=element_text(family="sans", face="plain",
                          color="#000000", size=15, hjust=0.5, vjust=0.5)) +
  scale_size(range=c(1, 3)) +
  xlab("Sepal.Length") +
  ylab("Sepal.Width")








