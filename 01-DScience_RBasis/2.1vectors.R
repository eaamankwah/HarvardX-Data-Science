Module 2: Vectors, Sorting
2.1 Vectors
c stands for concatenate

codes <- c(italy=380, canada=124, egypt=818)
codes
##  italy canada  egypt
##    380    124    818
use to access an element of a vector

codes[2]
## canada
##    124
codes[1:2]
##  italy canada
##    380    124
codes["canada"]
## canada
##    124
# codes["egypt","canada"]
x <- 1:5
x
## [1] 1 2 3 4 5
y <- as.character(x)
y
## [1] "1" "2" "3" "4" "5"
z <- as.numeric(y)
z
## [1] 1 2 3 4 5
x <- c("1", "b","3")
x
## [1] "1" "b" "3"
y <- as.numeric(x)
## Warning: NAs introduced by coercion
y
## [1]  1 NA  3
# EX 1: Numeric Vectors

# Here is an example creating a numeric vector named cost
cost <- c(50, 75, 90, 100, 150)

# Create a numeric vector to store the temperatures listed in the instructions into a vector named temp
# Make sure to follow the same order in the instructions
temp <- c("Beijing", 35, "Lagos", 88, "Paris", 42, "Rio de Janeiro", 84, "San Juan", 81, "Toronto", 30)
temp
##  [1] "Beijing"        "35"             "Lagos"          "88"
##  [5] "Paris"          "42"             "Rio de Janeiro" "84"
##  [9] "San Juan"       "81"             "Toronto"        "30"
temp <- c(35, 88, 42, 84, 81, 30)
# EX 2: Character vectors

# here is an example of how to create a character vector
food <- c("pizza", "burgers", "salads", "cheese", "pasta")

# Create a character vector called city to store the city names
# Make sure to follow the same order as in the instructions
city <- c("Beijing", "Lagos", "Paris",  "Rio de Janeiro", "San Juan","Toronto")
city
## [1] "Beijing"        "Lagos"          "Paris"          "Rio de Janeiro"
## [5] "San Juan"       "Toronto"
# EX 3: Connecting Numeric and Character Vectors

# Associate the cost values with its corresponding food item
cost <- c(50, 75, 90, 100, 150)
food <- c("pizza", "burgers", "salads", "cheese", "pasta")
names(cost) <- food

# You already wrote this code
temp <- c(35, 88, 42, 84, 81, 30)
city <- c("Beijing", "Lagos", "Paris", "Rio de Janeiro", "San Juan", "Toronto")

# Associate the temperature values with its corresponding city
names(temp) <- city
temp
##        Beijing          Lagos          Paris Rio de Janeiro       San Juan
##             35             88             42             84             81
##        Toronto
##             30
# EX 4: Subsetting vectors

# cost of the last 3 items in our food list:
cost[3:5]
## salads cheese  pasta
##     90    100    150
# temperatures of the first three cities in the list:
temp[0:3]
## Beijing   Lagos   Paris
##      35      88      42
temp[c(1,2,3)]
## Beijing   Lagos   Paris
##      35      88      42
# EX 5: Subsetting vectors continued...

# Access the cost of pizza and pasta from our food list
cost[c(1,5)]
## pizza pasta
##    50   150
# Define temp
temp <- c(35, 88, 42, 84, 81, 30)
city <- c("Beijing", "Lagos", "Paris", "Rio de Janeiro", "San Juan", "Toronto")
names(temp) <- city

# Access the temperatures of Paris and San Juan
temp[c(3,5)]
##    Paris San Juan
##       42       81
# EX 6: Sequences

# Create a vector m of integers that starts at 32 and ends at 99.
m <- 32:99

# Determine the length of object m.
length(m)
## [1] 68
# Create a vector x of integers that starts 12 and ends at 73.
x <- 12:73
# Determine the length of object x.
length(x)
## [1] 62
# EX 7: Sequences continued...

# Create a vector with the multiples of 7, smaller than 50.
seq(7, 49, 7)
## [1]  7 14 21 28 35 42 49
# Create a vector containing all the positive odd numbers smaller than 100.
# The numbers should be in ascending order
seq(1, 99, 2)
##  [1]  1  3  5  7  9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39 41 43 45
## [24] 47 49 51 53 55 57 59 61 63 65 67 69 71 73 75 77 79 81 83 85 87 89 91
## [47] 93 95 97 99
# EX 8: Sequences and length

# We can a vector with the multiples of 7, smaller than 50 like this
seq(7, 49, 7)
## [1]  7 14 21 28 35 42 49
# But note that the second argument does not need to be last number.
# It simply determines the maximum value permitted.
# so the following line of code produces the same vector as seq(7, 49, 7)
seq(7, 50, 7)
## [1]  7 14 21 28 35 42 49
# Create a sequence of numbers from 6 to 55, with 4/7 increments and determine its length
length(seq(6, 55, 4/7))
## [1] 86
# EX 9: Sequences of certain length

# Store the sequence in the object a
a <- seq(1, 10, length.out = 100)

# Determine the class of a
class(a)
## [1] "numeric"
# EX 10: Integers

# Store the sequence in the object a
a <- seq(1, 10)

# Determine the class of a
class(a)
## [1] "integer"
# EX 11: Integers and Numerics

# Check the class of 1, assigned to the object a
class(1)
## [1] "numeric"
# Confirm the class of 1L is integer
class(1L)
## [1] "integer"
# EX 12: Coercion

# Define the vector x
x <- c(1, 3, 5,"a")

# Note that the x is character vector
class(x)
## [1] "character"
# Typecast the vector to get an integer vector
# You will get a warning but that is ok
x <- as.integer(x)
## Warning: NAs introduced by coercion
