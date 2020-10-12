a <- 1
b <- 1
c <- -1
a
ls()
# solving the quadratic equation
(-b + sqrt(b^2 - 4*a*c) ) / ( 2*a )
(-b - sqrt(b^2 - 4*a*c) ) / ( 2*a )
log(8)
log(a)
exp(1)
log(2.718282)
log(exp(1))
log(8, base = 2)
log(8, 2)
2^3
data()
Co2
co2
n <- 100
n*(n+1)/2

n <- 1000
x <- seq(1,n)
sum(x)

n <- 1000
n*(n+1)/2

sqrt(log10(100))
library(dslabs)
data("murders")
class("murders")
class(murders)
str(murders)

# showing the first 6 lines of the dataset
head(murders)

# using the accessor operator to obtain the population column
murders$population
# displaying the variable names in the murders dataset
names(murders)
# determining how many entries are in a vector
pop <- murders$population
length(pop)
# vectors can be of class numeric and character
class(pop)
class(murders$state)

# logical vectors are either TRUE or FALSE
z <- 3 == 2
z
class(z)

# factors are another type of class
class(murders$region)
# obtaining the levels of a factor
levels(murders$region)

# solving the quadratic equation
a <- 2
b <- -1
c <- -4
(-b + sqrt(b^2 - 4*a*c) ) / ( 2*a )
(-b - sqrt(b^2 - 4*a*c) ) / ( 2*a )
log(1024, base = 4)

library(dslabs)
data(movielens)
str(movielens)
nlevels(movielens$genres)

library(dslabs)
data(heights)
options(digits = 3)
# average height
heights
avg_h <- mean(heights$height)
avg_h
ind <- c(heights$height > avg_h)
sum(ind)
sum(ind & heights$sex == "Female")
sum(heights$sex == "Female"/heights$sex)
min(heights$height)
match(min(heights$height), heights$height)
heights$sex[29]
max(heights$height)
x <- 50:82
sum(x %in% heights$height)
heights2 <- mutate(heights, ht_cm = height*2.54)
heights2 <- mutate(heights, ht_cm = height*2.54)
heights2
heights2$ht_cm[18]
mean(heights2$ht_cm)
fil_temp <- filter(heights2, sex =="Female")
fil_temp
fil_temp$ht_cm
fil_sum <- sum(fil_temp$ht_cm)
fil_sum/238
library(dslabs)
data(olive)
head(olive)
per_palmitic <- olive$palmitic*100
pmc <- olive$palmitoleic
plot(per_palmitic, pmc)
hist(olive$eicosenoic*100)
boxplot(palmitic~region, data = olive)

#conditionals
x <- c(1, 2, -3, 4)
if(all(x>0)){
  print("All Positives")
} else{
  print("Not All Positives")
}

# any() and all() functions
z <- c(TRUE, FALSE, FALSE) 
any(z) 
any(!z)
all(z)
all(!z)

z <- c(TRUE, TRUE, TRUE) 
any(z) 
any(!z)
all(z)
all(!z)

#inches to feet
inches_to_feet <- function(inches){
  feet <- inches / 12
  feet
}
inches_to_feet(144)

library(dplyr)
library(dslabs)
data(heights)
heights$height

# adding a column with mutate 
heights <- mutate(heights, ht_inches_ft = height / 12)
heights
sum(heights$ht_inches_ft < 5)

sex_m_f <- ifelse(heights$sex=="Female", 1, 2)
sum(sex_m_f)

# mean of resulting vector
ht_mean <- ifelse(heights$height > 72, heights$height, 0)
mean(ht_mean)

# which of the following are true
any(TRUE, TRUE, TRUE)
any(TRUE, TRUE, FALSE)
any(TRUE, FALSE, FALSE)
any(FALSE, FALSE, FALSE)
all(TRUE, TRUE, TRUE)
all(TRUE, TRUE, FALSE)
all(TRUE, FALSE, FALSE)
all(FALSE, FALSE, FALSE)


# factorial function
# define a vector of length m
m <- 10
f_n <- vector(length = m)

# make a vector of factorials
for(n in 1:m){
  f_n[n] <- factorial(n)
}

# inspect f_n
f_n
