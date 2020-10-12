#1.3 Data Types

class(2)
## [1] "numeric"
class("programming")
## [1] "character"
class(ls)
## [1] "function"
class(murders)
## [1] "data.frame"
class(murders$state)
## [1] "character"
class(murders$region)
## [1] "factor"
# structure
str(murders)
## 'data.frame':    51 obs. of  5 variables:
##  $ state     : chr  "Alabama" "Alaska" "Arizona" "Arkansas" ...
##  $ abb       : chr  "AL" "AK" "AZ" "AR" ...
##  $ region    : Factor w/ 4 levels "Northeast","South",..: 2 4 4 2 4 4 1 2 2 2 ...
##  $ population: num  4779736 710231 6392017 2915918 37253956 ...
##  $ total     : num  135 19 232 93 1257 ...
names(murders)
## [1] "state"      "abb"        "region"     "population" "total"
head(murders)
##        state abb region population total
## 1    Alabama  AL  South    4779736   135
## 2     Alaska  AK   West     710231    19
## 3    Arizona  AZ   West    6392017   232
## 4   Arkansas  AR  South    2915918    93
## 5 California  CA   West   37253956  1257
## 6   Colorado  CO   West    5029196    65
# EX 2: Variable names

# Load package and data

library(dslabs)
data(murders)

# Use the function names to extract the variable names
names(murders)
## [1] "state"      "abb"        "region"     "population" "total"
# EX 5: Factors

# We can see the class of the region variable using class
class(murders$region)
## [1] "factor"
# Determine the number of regions included in this variable
length(levels(murders$region))
## [1] 4
# EX 6: Tables

# Here is an example of what the table function does
x <- c("a", "a", "b", "b", "b", "c")
table(x)
## x
## a b c
## 2 3 1
# Write one line of code to show the number of states per region
table(murders$region)
