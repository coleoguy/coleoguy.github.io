data <- read.csv("oaks.csv")
data$totals <- data$specialist + data$generalist

fit1 <- glm(data$totals ~ data$Circumference)
summary(fit1)


fit2 <- glm(data$totals ~ data$Circumference + data$Country)
summary(fit2)

fit3 <- glm(data$totals ~ data$Circumference +
              data$MeanTempWarmestQuart +
              data$MeanPrecipWarmestQuart)
summary(fit3)

library(ggplot2)

ggplot(data = data, aes(Circumference, totals, color=Country)) +
  geom_point(size = .7) +
  theme_bw() +
  geom_smooth(method = lm , color = "red",
              fill = "#69b3a2", se = TRUE) +
  labs(y = "Species present", x = "Circumfrence (cm)")

ggplot(data = data, aes(Circumference, totals)) +
  geom_point(size = .7) +
  theme_bw() +
  geom_smooth(method = lm , color = "red",
              fill = "#69b3a2", se = TRUE) +
  labs(y = "Species present", x = "Circumfrence (cm)") +
  facet_wrap(~Country)

fit <- glm(data$generalist ~ data$MeanTempWarmestQuart + data$MeanPrecipWarmestQuart)
summary(fit)

ggplot(data = data, aes(x=MeanTempWarmestQuart, y=generalist, color=Country)) +
  geom_point(size = .7) +
  theme_bw() +
  geom_smooth(method = lm , color = "red",
              fill = "#69b3a2", se = TRUE) +
  labs(y = "Species present", x = "Temp")





