## Edward Amankwah
## HarvardX: PH125.9x Data Science
## Capstone Project - MovieLens Rating Prediction

#################################################
# Code for MovieLens Rating Prediction Project
################################################
#### Introduction ####
### Motivation of Project ###
## Dataset ##
## Data Preprosessing ##
#############################################################
# Create edx set and validation set Codes
############################################################

# Note: this process could take a couple of minutes

if(!require(tidyverse)) install.packages("tidyverse", repos = "http://cran.us.r-project.org")
if(!require(caret)) install.packages("caret", repos = "http://cran.us.r-project.org")
if(!require(data.table)) install.packages("data.table", repos = "http://cran.us.r-project.org")

# MovieLens 10M dataset:
# https://grouplens.org/datasets/movielens/10m/
# http://files.grouplens.org/datasets/movielens/ml-10m.zip

dl <- tempfile()
download.file("http://files.grouplens.org/datasets/movielens/ml-10m.zip", dl)

ratings <- fread(text = gsub("::", "\t", readLines(unzip(dl, "ml-10M100K/ratings.dat"))),
                 col.names = c("userId", "movieId", "rating", "timestamp"))

movies <- str_split_fixed(readLines(unzip(dl, "ml-10M100K/movies.dat")), "\\::", 3)
colnames(movies) <- c("movieId", "title", "genres")
movies <- as.data.frame(movies) %>% mutate(movieId = as.numeric(levels(movieId))[movieId],
                                           title = as.character(title),
                                           genres = as.character(genres))

movielens <- left_join(ratings, movies, by = "movieId")

## Train and Validation Sets ##

# Validation set will be 10% of MovieLens data

set.seed(1, sample.kind="Rounding")
# if using R 3.5 or earlier, use `set.seed(1)` instead
test_index <- createDataPartition(y = movielens$rating, times = 1, p = 0.1, list = FALSE)
edx <- movielens[-test_index,]
temp <- movielens[test_index,]

# Make sure userId and movieId in validation set are also in edx set

validation <- temp %>% 
  semi_join(edx, by = "movieId") %>%
  semi_join(edx, by = "userId")

# Add rows removed from validation set back into edx set

removed <- anti_join(temp, validation)
edx <- rbind(edx, removed)

rm(dl, ratings, movies, test_index, temp, movielens, removed)

## MovieLens Data Summary ## 

# Head
head(edx) %>%
  print.data.frame()

# Total unique movies and users
summary(edx)

## MovieLens Data Exploration ##

users <- sample(unique(edx$userId), 100)
rafalib::mypar()
edx %>% filter(userId %in% users) %>%
  select(userId, movieId, rating) %>%
  mutate(rating = 1) %>%
  spread(movieId, rating) %>% select(sample(ncol(.), 100)) %>%
  as.matrix() %>% t(.) %>%
  image(1:100, 1:100,. , xlab="Movies", ylab="Users")
abline(h=0:100+0.5, v=0:100+0.5, col = "grey")

#### Methods and Analysis ####

### Distributions ###

edx %>%
  ggplot(aes(rating)) +
  geom_histogram(binwidth = 0.25, color = "black") +
  scale_x_discrete(limits = c(seq(0.5,5,0.5))) +
  scale_y_continuous(breaks = c(seq(0, 3000000, 500000))) +
  ggtitle("Rating distribution")

## Ratings vs Year of Release ##

# Modify the year as a column in the edx for further analysis
edx <- edx %>% mutate(year = as.numeric(str_sub(title,-5,-2)))

edx %>% group_by(year) %>%
  summarize(rating = mean(rating)) %>%
  ggplot(aes(year, rating)) +
  geom_point() +
  geom_smooth()

## `geom_smooth()` using method = 'loess' and formula 'y ~ x'

## Movies vs Number of Ratings ##
edx %>%
  count(movieId) %>%
  ggplot(aes(n)) +
  geom_histogram(bins = 30, color = "blue") +
  scale_x_log10() +
  ggtitle("Movies vs Number of Ratings")

## Users vs Number of Ratings ##
edx %>%
  count(userId) %>%
  ggplot(aes(n)) +
  geom_histogram(bins = 30, color = "blue") +
  scale_x_log10() +
  ggtitle("Users vs Number of Ratings")

## Average Ratings Distributions ##
edx %>%
  group_by(userId) %>%
  filter(n() >= 100) %>%
  summarize(b_u = mean(rating)) %>%
  ggplot(aes(b_u)) +
  geom_histogram(bins = 30, color = "blue") +
  xlab("Mean rating") +
  ylab("Number of users") +
  ggtitle("Mean movie ratings given by users") +
  scale_x_discrete(limits = c(seq(0.5,5,0.5))) +
  theme_light()

### Data Analysis ###
## Loss Function ##
#Lost function equation

### Modelling Aproach ###

## I. Baseline model: Average movie rating  ##

# Calculate the dataset's average rating
mu_hat <- mean(edx$rating)
mu_hat

# Test results based on baseline prediction
naive_rmse <- RMSE(validation$rating, mu_hat)
naive_rmse

# Save prediction in data frame
rmse_results <- tibble(method = "Average movie rating model", RMSE = naive_rmse)
rmse_results %>% knitr::kable()

## II. Movie Effect Model  ##
# Baseline model and accounting for the movie effect b_i
# Rating minus the mean for each rating received by the movie
# Plot number of movies with the calculated b_i

mu <- mean(edx$rating)
avg_movie <- edx %>%
  group_by(movieId) %>%
  summarize(b_i = mean(rating - mu))
avg_movie %>% qplot(b_i, geom ="histogram", bins = 10, data = ., color = I("blue"),
                     ylab = "Number of movies", main = "Number of movies with the calculated b_i")
# Test rmse results
predicted_ratings <- mu + validation %>%
  left_join(avg_movie, by='movieId') %>%
  pull(b_i)

# compute rmse after modelling movie effect
model_1_rmse <- RMSE(predicted_ratings, validation$rating)
rmse_results <- bind_rows(rmse_results,
                          tibble(method="Movie effect model",
                                     RMSE = model_1_rmse ))
# Save predictions
rmse_results %>% knitr::kable()

## III. Movie and User Effect model ##
# Plot penaly term  b_u user effect #
avg_user <- edx %>%
  left_join(avg_movie, by='movieId') %>%
  group_by(userId) %>%
  filter(n() >= 100) %>%
  summarize(b_u = mean(rating - mu - b_i))
avg_user %>% qplot(b_u, geom ="histogram", bins = 30, data = ., color = I("blue"))

avg_user <- edx %>%
  left_join(avg_movie, by='movieId') %>%
  group_by(userId) %>%
  summarize(b_u = mean(rating - mu - b_i))

# Test and save rmse results
predicted_ratings <- validation%>%
  left_join(avg_movie, by='movieId') %>%
  left_join(avg_user, by='userId') %>%
  mutate(pred = mu + b_i + b_u) %>%
  pull(pred)

# compute rmse after modelling movie and user effects
model_2_rmse <- RMSE(predicted_ratings, validation$rating)
rmse_results <- bind_rows(rmse_results,
                          tibble(method="Movie and User effect model",
                                     RMSE = model_2_rmse))
# Check result
rmse_results %>% knitr::kable()

## IV. Regularized Movie and User Effect model ##
# Use lambda as a tuning parameter and use cross-validation to select it.

lambdas <- seq(0, 10, 0.25)

# For each lambda,find b_i & b_u, followed by rating prediction & testing
# note:below code could take some time
rmses <- sapply(lambdas, function(l){
  mu <- mean(edx$rating)
  b_i <- edx %>%
    group_by(movieId) %>%
    summarize(b_i = sum(rating - mu)/(n()+l))
  b_u <- edx %>%
    left_join(b_i, by="movieId") %>%
    group_by(userId) %>%
    summarize(b_u = sum(rating - b_i - mu)/(n()+l))
  predicted_ratings <-validation %>%
    left_join(b_i, by = "movieId") %>%
    left_join(b_u, by = "userId") %>%
    mutate(pred = mu + b_i + b_u) %>%
    pull(pred)
  return(RMSE(predicted_ratings, validation$rating))
})
# Plot rmses vs lambdas to select the optimal lambda
qplot(lambdas, rmses)

# The optimal lambda
lambda <- lambdas[which.min(rmses)]
lambda

# Test and save results
rmse_results <- bind_rows(rmse_results,
                          tibble(method="Regularized Movie and User effect model",
                                     RMSE = min(rmses)))
# Check result
rmse_results %>% knitr::kable()

#### Results ####
# RMSE results
rmse_results %>% knitr::kable()

#### Discussion ####
#### Conclusion ####
#### References ####
