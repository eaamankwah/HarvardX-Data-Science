# 2.2 Sorting

# how many murders
sort(murders$total)
##  [1]    2    4    5    5    7    8   11   12   12   16   19   21   22   27
## [15]   32   36   38   53   63   65   67   84   93   93   97   97   99  111
## [29]  116  118  120  135  142  207  219  232  246  250  286  293  310  321
## [43]  351  364  376  413  457  517  669  805 1257
x <- c(31,4,15,92,65)

sort(x)
## [1]  4 15 31 65 92
index <- order(x)
index
## [1] 2 3 1 5 4
# first we order the total murders and save it to index
index <- order(murders$total)

# then we use index to look up state ordered by murdercount from low to high
murders$abb[index]
##  [1] "VT" "ND" "NH" "WY" "HI" "SD" "ME" "ID" "MT" "RI" "AK" "IA" "UT" "WV"
## [15] "NE" "OR" "DE" "MN" "KS" "CO" "NM" "NV" "AR" "WA" "CT" "WI" "DC" "OK"
## [29] "KY" "MA" "MS" "AL" "IN" "SC" "TN" "AZ" "NJ" "VA" "NC" "MD" "OH" "MO"
## [43] "LA" "IL" "GA" "MI" "PA" "NY" "FL" "TX" "CA"
# which is the max murder number
max(murders$total)
## [1] 1257
# use to look up state
i_max <- which.max(murders$total)
i_max
## [1] 5
murders$state[i_max]
## [1] "California"
# which is the min murder number
min(murders$total)
## [1] 2
# use to look up state
i_min <- which.min(murders$total)
i_min
## [1] 46
murders$state[i_min]
## [1] "Vermont"
# ranking
rank(x)
## [1] 3 1 2 5 4
# EX 1: sort

# Access the `state` variable and store it in an object
states <- murders$state

# Sort the object alphabetically and redefine the object
states <- sort(states)

# Report the first alphabetical value
states[1]
## [1] "Alabama"
# Access population values from the dataset and store it in pop
pop <- murders$population
# Sort the object and save it in the same object
pop <- sort(pop)
# Report the smallest population size
pop[1]
## [1] 563626
# EX 2: order

# Access population from the dataset and store it in pop
pop <- murders$population

# Use the command order, to order pop and store in object o
o <- order(pop)
# Find the index number of the entry with the smallest population size
o[1]
## [1] 51
# EX 3: New Codes

# Find the smallest value for variable total
which.min(murders$total)
## [1] 46
# Find the smallest value for population
which.min(murders$population)
## [1] 51
# EX 4:Using the output of order

# Define the variable i to be the index of the smallest state
i <- which.min(murders$population)

# Define variable states to hold the states
states <- murders$state

# Use the index you just defined to find the state with the smallest population
states[i]
## [1] "Wyoming"
# EX 5: Ranks
# EX 5: Ranks

# Store temperatures in an object
temp <- c(35, 88, 42, 84, 81, 30)

# Store city names in an object
city <- c("Beijing", "Lagos", "Paris", "Rio de Janeiro", "San Juan", "Toronto")

# Create data frame with city names and temperature
city_temps <- data.frame(name = city, temperature = temp)

# Define a variable states to be the state names
states <- murders$state

# Define a variable ranks to determine the population size ranks
ranks <- rank(murders$population)

# Create a data frame my_df with the state name and its rank
my_df <- data.frame(states = states, ranks = ranks)
my_df
##                  states ranks
## 1               Alabama    29
## 2                Alaska     5
## 3               Arizona    36
## 4              Arkansas    20
## 5            California    51
## 6              Colorado    30
## 7           Connecticut    23
## 8              Delaware     7
## 9  District of Columbia     2
## 10              Florida    49
## 11              Georgia    44
## 12               Hawaii    12
## 13                Idaho    13
## 14             Illinois    47
## 15              Indiana    37
## 16                 Iowa    22
## 17               Kansas    19
## 18             Kentucky    26
## 19            Louisiana    27
## 20                Maine    11
## 21             Maryland    33
## 22        Massachusetts    38
## 23             Michigan    43
## 24            Minnesota    31
## 25          Mississippi    21
## 26             Missouri    34
## 27              Montana     8
## 28             Nebraska    14
## 29               Nevada    17
## 30        New Hampshire    10
## 31           New Jersey    41
## 32           New Mexico    16
## 33             New York    48
## 34       North Carolina    42
## 35         North Dakota     4
## 36                 Ohio    45
## 37             Oklahoma    24
## 38               Oregon    25
## 39         Pennsylvania    46
## 40         Rhode Island     9
## 41       South Carolina    28
## 42         South Dakota     6
## 43            Tennessee    35
## 44                Texas    50
## 45                 Utah    18
## 46              Vermont     3
## 47             Virginia    40
## 48           Washington    39
## 49        West Virginia    15
## 50            Wisconsin    32
## 51              Wyoming     1
# EX 6: Data Frames, Ranks and Orders

# Define a variable states to be the state names from the murders data frame
states <- murders$state

# Define a variable ranks to determine the population size ranks
ranks <- rank(murders$population)

# Define a variable ind to store the indexes needed to order the population values
ind <- order(murders$population)

# Create a data frame my_df with the state name and its rank and ordered from least populous to most
my_df <- data.frame(states = states[ind], ranks = ranks[ind])
my_df
##                  states ranks
## 1               Wyoming     1
## 2  District of Columbia     2
## 3               Vermont     3
## 4          North Dakota     4
## 5                Alaska     5
## 6          South Dakota     6
## 7              Delaware     7
## 8               Montana     8
## 9          Rhode Island     9
## 10        New Hampshire    10
## 11                Maine    11
## 12               Hawaii    12
## 13                Idaho    13
## 14             Nebraska    14
## 15        West Virginia    15
## 16           New Mexico    16
## 17               Nevada    17
## 18                 Utah    18
## 19               Kansas    19
## 20             Arkansas    20
## 21          Mississippi    21
## 22                 Iowa    22
## 23          Connecticut    23
## 24             Oklahoma    24
## 25               Oregon    25
## 26             Kentucky    26
## 27            Louisiana    27
## 28       South Carolina    28
## 29              Alabama    29
## 30             Colorado    30
## 31            Minnesota    31
## 32            Wisconsin    32
## 33             Maryland    33
## 34             Missouri    34
## 35            Tennessee    35
## 36              Arizona    36
## 37              Indiana    37
## 38        Massachusetts    38
## 39           Washington    39
## 40             Virginia    40
## 41           New Jersey    41
## 42       North Carolina    42
## 43             Michigan    43
## 44              Georgia    44
## 45                 Ohio    45
## 46         Pennsylvania    46
## 47             Illinois    47
## 48             New York    48
## 49              Florida    49
## 50                Texas    50
## 51           California    51
# EX 7: NA

# Using new dataset
library(dslabs)
data(na_example)

# Checking the structure
str(na_example)
##  int [1:1000] 2 1 3 2 1 3 1 4 3 2 ...
# Find out the mean of the entire dataset
mean(na_example)
## [1] NA
# Use is.na to create a logical index ind that tells which entries are NA
ind <- is.na(na_example)

# Determine how many NA ind has using the sum function
sum(ind)
## [1] 145
# EX 8: Rmoving NAs

# Note what we can do with the ! operator
x <- c(1, 2, 3)
ind <- c(FALSE, TRUE, FALSE)
x[!ind]
## [1] 1 3
# Create the ind vector
library(dslabs)
data(na_example)
ind <- is.na(na_example)

# We saw that this gives an NA
mean(na_example)
## [1] NA
# Compute the average, for entries of na_example that are not NA
mean(na_example[!ind])
## [1] 2.301754
