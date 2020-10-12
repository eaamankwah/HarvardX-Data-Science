# Module 1: R Basics, Functions, and Data Types
## 1.1 Motivation
## 1.2 R Basics
log(1)


exp(1)
## [1] 2.718282
log(exp(1))
## [1] 1
# EX 2: Variable names

# Load package and data

library(dslabs)
data(murders)

# Use the function names to extract the variable names
names(murders)

# EX 3: Examining Variables

# To access the population variable from the murders dataset use this code:
p <- murders$population

# To determine the class of object `p` we use this code:
class(p)
## [1] "numeric"
# Use the accessor to extract state abbreviations and assign it to a
a <- murders$abb

# Determine the class of a
class(a)
## [1] "character"

# EX 4: Multiple ways to access variables

# We extract the population like this:
p <- murders$population

# This is how we do the same with the square brackets:
o <- murders[["population"]]

# We can confirm these two are the same
identical(o, p)
## [1] TRUE
# Use square brackets to extract `abb` from `murders` and assign it to b
b <- murders[["abb"]]
# Check if `a` and `b` are identical
identical(a,b)
## [1] TRUE

