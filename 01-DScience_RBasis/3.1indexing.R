# 3.1 Indexing
murder_rate <- murders$total / murders$population * 100000

# murder rate in Italy is 0.71, find us states with similar or lower rates
index <- murder_rate < 0.71
index
##  [1] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [12]  TRUE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE
## [23] FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE
## [34] FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [45] FALSE  TRUE FALSE FALSE FALSE FALSE FALSE
# which states
murders$state[index]
## [1] "Hawaii"        "Iowa"          "New Hampshire" "North Dakota"
## [5] "Vermont"
# how many states
sum(index)
## [1] 5
# we want to find a states with mountains (West) and safe (murder_rate <= 1)
west <- murders$region == "West"
safe <- murder_rate <= 1
index <- safe & west

murders$state[index]
## [1] "Hawaii"  "Idaho"   "Oregon"  "Utah"    "Wyoming"
which
x <- c(FALSE, TRUE, FALSE, TRUE, TRUE, FALSE)
which(x)
## [1] 2 4 5
# Ex we want to look up the murderrate in Massachusetts
index <- which(murders$state =="Massachusetts")
index
## [1] 22
# so to get the murder rate, we use the index
murder_rate[index]
## [1] 1.802179
# Now we want to match severral states
index <- match(c("New York", "Florida", "Texas"), murders$state)
index
## [1] 33 10 44
# To confirm we got it right
murder_state <- murders$state
murder_state[index]
## [1] "New York" "Florida"  "Texas"
# and the murder rate of these states
murder_rate[index]
## [1] 2.667960 3.398069 3.201360
x <- c("a", "b", "c", "d", "e")
y <- c("a", "d", "f")

# so we can ask if y is in x
y %in% x
## [1]  TRUE  TRUE FALSE
# check if three states are actually states
c("Boston", "Dakota", "Washington") %in% murders$state
## [1] FALSE FALSE  TRUE
# EX 1: Logical Vectors

# Store the murder rate per 100,000 for each state, in `murder_rate`
murder_rate <- murders$total / murders$population * 100000
#
# Store the `murder_rate < 1` in `low`
low <- murder_rate < 1
# EX 2: which

# Store the murder rate per 100,000 for each state, in murder_rate
murder_rate <- murders$total/murders$population*100000

# Store the murder_rate < 1 in low
low <- murder_rate < 1

# Get the indices of entries that are below 1
which(low)
##  [1] 12 13 16 20 24 30 35 38 42 45 46 51
# EX 3: Ordering vectors

# Store the murder rate per 100,000 for each state, in murder_rate
murder_rate <- murders$total/murders$population*100000

# Store the murder_rate < 1 in low
low <- murder_rate < 1

# Names of states with murder rates lower than 1
murders$state[low]
##  [1] "Hawaii"        "Idaho"         "Iowa"          "Maine"
##  [5] "Minnesota"     "New Hampshire" "North Dakota"  "Oregon"
##  [9] "South Dakota"  "Utah"          "Vermont"       "Wyoming"
# EX 4: Filtering

# Store the murder rate per 100,000 for each state, in `murder_rate`
murder_rate <- murders$total/murders$population*100000

# Store the `murder_rate < 1` in `low`
low <- murder_rate < 1

# Create a vector ind for states in the Northeast and with murder rates lower than 1.
ind <- (murders$region == "Northeast") & (murder_rate < 1)

# Names of states in `ind`
murders$state[ind]
## [1] "Maine"         "New Hampshire" "Vermont"
# EX 5: Filtering continued

# Store the murder rate per 100,000 for each state, in murder_rate
murder_rate <- murders$total/murders$population*100000


# Compute average murder rate and store in avg using `mean`
avg <- mean(murder_rate)

# How many states have murder rates below avg ? Check using sum
sum(murder_rate < avg)
## [1] 27
# EX 6: Match

# Store the 3 abbreviations in abbs in a vector (remember that they are character vectors and need quotes)
abbs <- c("AK", "MI", "IA")

# Match the abbs to the murders$abb and store in `ind`
ind <- match(abbs , murders$abb)

# Print state names from `ind`
murders$state[ind]
## [1] "Alaska"   "Michigan" "Iowa"
# EX 7: %in%

# Store the 5 abbreviations in `abbs`. (remember that they are character vectors)
abbs <- c("MA", "ME", "MI", "MO", "MU")

# Use the %in% command to check if the entries of abbs are abbreviations in the the murders data frame
abbs %in% murders$abb
## [1]  TRUE  TRUE  TRUE  TRUE FALSE
# EX 8: Logical operator

# Store the 5 abbreviations in abbs. (remember that they are character vectors)
abbs <- c("MA", "ME", "MI", "MO", "MU")

# Use the `which` command and `!` operator to find out which abbreviation are not actually part of the dataset and store in ind

ind <- which(!abbs %in% murders$abb)

# What are the entries of abbs that are not actual abbreviations
abbs[ind]
## [1] "MU"
