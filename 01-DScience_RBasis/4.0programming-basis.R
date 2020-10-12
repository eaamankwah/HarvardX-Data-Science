# 3.3 ## Basic Plots

Module 4: Programming Basics
4.1 Introduction to Programming in R
4.2 Conditionals
library(dslabs)
data(murders)
murder_rate <- murders$total/murders$population*100000

ind <- which.min(murder_rate)

if(murder_rate[ind] < 0.5) {
    print(murders$state[ind])
} else{
    print("No state has murder rate that low")
}
## [1] "Vermont"
ind <- which.min(murder_rate)

if(murder_rate[ind] < 0.25) {
    print(murders$state[ind])
} else{
    print("No state has murder rate that low")
}
## [1] "No state has murder rate that low"
a <- c(0,1,2,-4,5)

result <- ifelse(a > 0, 1/a, NA)
result
## [1]  NA 1.0 0.5  NA 0.2
4.3 Functions
avg <- function(x) {
    s <- sum(x)
    n <- length(x)
    s/n
}

x <- c(5,4,3,2)

avg(x)
## [1] 3.5
4.4 For Loops
compute_s_n <- function(n){
    x <- 1:n
    sum(x)
}

compute_s_n(3) # 1+2+3
## [1] 6
compute_s_n(100)
## [1] 5050
we now want to repeat the process 25 times

m <- 25
# we create an empty vector
s_n <- vector(length = m)

for(n in 1:m) {
    s_n[n] <- compute_s_n(n)
}

s_n
##  [1]   1   3   6  10  15  21  28  36  45  55  66  78  91 105 120 136 153
## [18] 171 190 210 231 253 276 300 325
n <- 1:m
plot(n, s_n)

in stead of loops we use:

apply
sapply
tapply #
# EX 2: Conditionals

# Assign the state abbreviation when the state name is longer than 8 characters
new_names <- ifelse(nchar(murders$state)>8, murders$abb, murders$state)
new_names
##  [1] "Alabama"  "Alaska"   "Arizona"  "Arkansas" "CA"       "Colorado"
##  [7] "CT"       "Delaware" "DC"       "Florida"  "Georgia"  "Hawaii"
## [13] "Idaho"    "Illinois" "Indiana"  "Iowa"     "Kansas"   "Kentucky"
## [19] "LA"       "Maine"    "Maryland" "MA"       "Michigan" "MN"
## [25] "MS"       "Missouri" "Montana"  "Nebraska" "Nevada"   "NH"
## [31] "NJ"       "NM"       "New York" "NC"       "ND"       "Ohio"
## [37] "Oklahoma" "Oregon"   "PA"       "RI"       "SC"       "SD"
## [43] "TN"       "Texas"    "Utah"     "Vermont"  "Virginia" "WA"
## [49] "WV"       "WI"       "Wyoming"
# EX 4: Defining functions

# Create function called `sum_n`
sum_n <- function(n){
    x <- 1:n
    sum(x)
}

# Determine the sum of integers from 1 to 5000
sum_n(5000)
## [1] 12502500
# EX 5: Defining functions continued...

# Create `altman_plot`
altman_plot <- function(x, y){
    plot(x + y, y - x)
}

x <- c(1,2,3,4,5)

y <- c(2,4,6,8,10)

altman_plot(x,y)

# Run this code
x <- 3
my_func <- function(y){
    x <- 5
    y+5
}

# Print value of x

x
## [1] 3
# EX 7: For loops
# Here is a function that adds numbers from 1 to n
example_func <- function(n){
    x <- 1:n
    sum(x)
}

# Here is the sum of the first 100 numbers
example_func(100)
## [1] 5050
# Write the function with argument n, with the above mentioned specifications and store it in `compute_s_n`
compute_s_n <- function(n){
    x <- 1:n
    sum(x^2)
}

# Report the value of the sum when n=10
compute_s_n(10)
## [1] 385
# EX 8: For loops continued...

# Define a function and store it in `compute_s_n`
compute_s_n <- function(n){
    x <- 1:n
    sum(x^2)
}

# Create a vector for storing results
s_n <- vector("numeric", 25)

# Assign values to `n` and `s_n`
for(i in 1:25){
    s_n[i] <- compute_s_n(i)
}
# EX 9: Checking our math

# Define the function
compute_s_n <- function(n){
    x <- 1:n
    sum(x^2)
}

# Define the vector of n
n <- 1:25

# Define the vector to store data
s_n <- vector("numeric", 25)
for(i in n){
    s_n[i] <- compute_s_n(i)
}

#  Create the plot
plot(n, s_n)

# EX 10: Checking our math continued

# Define the function
compute_s_n <- function(n){
    x <- 1:n
    sum(x^2)
}

# Define the vector of n
n <- 1:25

# Define the vector to store data
s_n <- vector("numeric", 25)
for(i in n){
    s_n[i] <- compute_s_n(i)
}

# Check that s_n is identical to the formula given in the instructions.
identical(s_n, n*(n+1)*(2*n+1)/6)
## [1] TRUE
