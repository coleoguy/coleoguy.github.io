# This script will demonstrate the basics of using the `glm` function in R
# for both continuous and binary response variables with various predictor variables.

# 1. Example of a Simple Linear Model Using `glm`

# Let's start by creating some basic data for a continuous response
set.seed(123)  # Set seed for reproducibility

# Create a data frame with one continuous predictor
simple_data <- data.frame(
  predictor = rnorm(100, mean = 50, sd = 10)  # Predictor variable with normal distribution
)
# Create a response variable that has a true linear relationship with the predictor
simple_data$response <- 5 + 0.3 * simple_data$predictor + rnorm(100, mean = 0, sd = 2)

# Plot the data to visualize the relationship
plot(simple_data$predictor, simple_data$response, 
     main = "Scatterplot of Predictor vs Response",
     xlab = "Predictor",
     ylab = "Response")

# Fit a simple linear model using `glm`
# Note: family = gaussian() is the default for continuous response data
simple_model <- glm(response ~ predictor, data = simple_data)

# Summary of the model to interpret results
summary(simple_model)

# 2. Example of a Logistic Regression Model with a Binary Response Variable

# Create a data frame with one predictor and a binary response
set.seed(456)
logistic_data <- data.frame(
  predictor = rnorm(100, mean = 50, sd = 10)
)
# Create a response variable with a true logistic relationship to the predictor
logistic_data$response <- rbinom(100, 1, plogis(-50 + 0.8 * logistic_data$predictor))

# Plot the data
plot(logistic_data$predictor, logistic_data$response, 
     main = "Scatterplot of Predictor vs Binary Response",
     xlab = "Predictor",
     ylab = "Binary Response")

# Fit a logistic regression model using `glm`
# Here, we specify family = binomial() since the response is binary
logistic_model <- glm(response ~ predictor, data = logistic_data, family = binomial)

# Summary of the model to interpret the coefficients
summary(logistic_model)

# 3. Adding More Predictors to the Model

# Create data with two predictors for a more complex model
set.seed(789)
complex_data <- data.frame(
  predictor1 = rnorm(100, mean = 50, sd = 10),
  predictor2 = rnorm(100, mean = 20, sd = 5)
)
# Create a response variable with a true logistic relationship to the predictors
complex_data$response <- rbinom(100, 1, plogis(-30 + 0.5 * complex_data$predictor1 + 0.7 * complex_data$predictor2))

# Fit a logistic regression model with two predictors
complex_model <- glm(response ~ predictor1 + predictor2, data = complex_data, family = binomial())

# Summary of the model to see the effects of each predictor
summary(complex_model)

# 4. Including Interaction Terms in the Model

# Adding interaction between predictor1 and predictor2
interaction_model <- glm(response ~ predictor1 * predictor2, data = complex_data, family = binomial())

# Summary to see interaction effects
summary(interaction_model)


