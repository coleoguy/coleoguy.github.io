##############################################################
# Basic ANOVA and Nonparametric Alternatives in Base R
# Author: Dr. Heath Blackmon
# Dataset: chickwts (built-in)
# Purpose: Demonstrate ANOVA, post hoc tests, assumption checks,
#          and nonparametric alternatives.
##############################################################

# Load the built-in chickwts dataset
data("chickwts")

# Quick look at the data structure
head(chickwts)
# weight = numeric response variable (chick weight)
# feed   = categorical predictor (type of feed)

##############################################################
# 1. One-way ANOVA
##############################################################

# Fit a one-way ANOVA model
anova_result <- aov(weight ~ feed, data = chickwts)

# Display the ANOVA summary table
summary(anova_result)
# This tests whether there are significant differences
# in mean chick weight among feed types.

##############################################################
# 2. Post hoc comparisons (Tukey's HSD)
##############################################################

# Perform pairwise comparisons between feed types
TukeyHSD(x = anova_result)
# The Tukey HSD controls for multiple testing and
# identifies which pairs of feed types differ.

##############################################################
# 3. Check ANOVA assumptions
##############################################################

# The ANOVA assumes:
# (1) Independence of observations
# (2) Homogeneity of variances (similar spread across groups)
# (3) Normally distributed residuals within each group

# Here we check normality within each feed group using Shapiro–Wilk tests
feeds <- unique(chickwts$feed)

for (i in 1:length(feeds)) {
  group <- feeds[i]
  test <- shapiro.test(chickwts$weight[chickwts$feed == group])
  cat("\nNormality test for feed:", group, "\n")
  print(test)
}
# If any group has p < 0.05, that group deviates from normality.

##############################################################
# 4. Nonparametric alternative (Kruskal–Wallis test)
##############################################################

# Use Kruskal–Wallis when ANOVA assumptions are violated
kruskal.test(x = chickwts$weight, g = chickwts$feed)
# This tests for differences in median weight among feed groups.

##############################################################
# 5. Nonparametric post hoc test (Dunn’s test)
##############################################################

# Install/load the dunn.test package if needed
# install.packages("dunn.test")
library(dunn.test)

# Perform pairwise comparisons for the Kruskal–Wallis test
dunn.test(x = chickwts$weight, g = chickwts$feed)
# Dunn’s test identifies which specific groups differ,
# analogous to Tukey’s HSD but for rank-based tests.

##############################################################
# 6. Simple Linear Regression Examples (using iris dataset)
##############################################################

# Load the built-in iris dataset
data(iris)

# Fit linear regression: Petal.Length predicted by Petal.Width
fit1 <- lm(Petal.Length ~ Petal.Width, data = iris)
summary(fit1)
# Interprets how petal length increases as petal width increases.

# Fit another regression: Sepal.Width predicted by Petal.Length
fit2 <- lm(Sepal.Width ~ Petal.Length, data = iris)
summary(fit2)
# Examines whether petal length predicts sepal width.

##############################################################
# End of script
##############################################################
