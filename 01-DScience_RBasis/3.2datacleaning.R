# 3.2 Basic Data Wrangeling

library(dplyr)
we want to add the murder ae into the table

murders <- mutate(murders, rate=total/population * 100000)
murders
##                   state abb        region population total       rate
## 1               Alabama  AL         South    4779736   135  2.8244238
## 2                Alaska  AK          West     710231    19  2.6751860
## 3               Arizona  AZ          West    6392017   232  3.6295273
## 4              Arkansas  AR         South    2915918    93  3.1893901
## 5            California  CA          West   37253956  1257  3.3741383
## 6              Colorado  CO          West    5029196    65  1.2924531
## 7           Connecticut  CT     Northeast    3574097    97  2.7139722
## 8              Delaware  DE         South     897934    38  4.2319369
## 9  District of Columbia  DC         South     601723    99 16.4527532
## 10              Florida  FL         South   19687653   669  3.3980688
## 11              Georgia  GA         South    9920000   376  3.7903226
## 12               Hawaii  HI          West    1360301     7  0.5145920
## 13                Idaho  ID          West    1567582    12  0.7655102
## 14             Illinois  IL North Central   12830632   364  2.8369608
## 15              Indiana  IN North Central    6483802   142  2.1900730
## 16                 Iowa  IA North Central    3046355    21  0.6893484
## 17               Kansas  KS North Central    2853118    63  2.2081106
## 18             Kentucky  KY         South    4339367   116  2.6732010
## 19            Louisiana  LA         South    4533372   351  7.7425810
## 20                Maine  ME     Northeast    1328361    11  0.8280881
## 21             Maryland  MD         South    5773552   293  5.0748655
## 22        Massachusetts  MA     Northeast    6547629   118  1.8021791
## 23             Michigan  MI North Central    9883640   413  4.1786225
## 24            Minnesota  MN North Central    5303925    53  0.9992600
## 25          Mississippi  MS         South    2967297   120  4.0440846
## 26             Missouri  MO North Central    5988927   321  5.3598917
## 27              Montana  MT          West     989415    12  1.2128379
## 28             Nebraska  NE North Central    1826341    32  1.7521372
## 29               Nevada  NV          West    2700551    84  3.1104763
## 30        New Hampshire  NH     Northeast    1316470     5  0.3798036
## 31           New Jersey  NJ     Northeast    8791894   246  2.7980319
## 32           New Mexico  NM          West    2059179    67  3.2537239
## 33             New York  NY     Northeast   19378102   517  2.6679599
## 34       North Carolina  NC         South    9535483   286  2.9993237
## 35         North Dakota  ND North Central     672591     4  0.5947151
## 36                 Ohio  OH North Central   11536504   310  2.6871225
## 37             Oklahoma  OK         South    3751351   111  2.9589340
## 38               Oregon  OR          West    3831074    36  0.9396843
## 39         Pennsylvania  PA     Northeast   12702379   457  3.5977513
## 40         Rhode Island  RI     Northeast    1052567    16  1.5200933
## 41       South Carolina  SC         South    4625364   207  4.4753235
## 42         South Dakota  SD North Central     814180     8  0.9825837
## 43            Tennessee  TN         South    6346105   219  3.4509357
## 44                Texas  TX         South   25145561   805  3.2013603
## 45                 Utah  UT          West    2763885    22  0.7959810
## 46              Vermont  VT     Northeast     625741     2  0.3196211
## 47             Virginia  VA         South    8001024   250  3.1246001
## 48           Washington  WA          West    6724540    93  1.3829942
## 49        West Virginia  WV         South    1852994    27  1.4571013
## 50            Wisconsin  WI North Central    5686986    97  1.7056487
## 51              Wyoming  WY          West     563626     5  0.8871131
filter(murders, rate <= 0.71)
##           state abb        region population total      rate
## 1        Hawaii  HI          West    1360301     7 0.5145920
## 2          Iowa  IA North Central    3046355    21 0.6893484
## 3 New Hampshire  NH     Northeast    1316470     5 0.3798036
## 4  North Dakota  ND North Central     672591     4 0.5947151
## 5       Vermont  VT     Northeast     625741     2 0.3196211
select specific columns

new_table <- select(murders,state,region,rate)
new_table
##                   state        region       rate
## 1               Alabama         South  2.8244238
## 2                Alaska          West  2.6751860
## 3               Arizona          West  3.6295273
## 4              Arkansas         South  3.1893901
## 5            California          West  3.3741383
## 6              Colorado          West  1.2924531
## 7           Connecticut     Northeast  2.7139722
## 8              Delaware         South  4.2319369
## 9  District of Columbia         South 16.4527532
## 10              Florida         South  3.3980688
## 11              Georgia         South  3.7903226
## 12               Hawaii          West  0.5145920
## 13                Idaho          West  0.7655102
## 14             Illinois North Central  2.8369608
## 15              Indiana North Central  2.1900730
## 16                 Iowa North Central  0.6893484
## 17               Kansas North Central  2.2081106
## 18             Kentucky         South  2.6732010
## 19            Louisiana         South  7.7425810
## 20                Maine     Northeast  0.8280881
## 21             Maryland         South  5.0748655
## 22        Massachusetts     Northeast  1.8021791
## 23             Michigan North Central  4.1786225
## 24            Minnesota North Central  0.9992600
## 25          Mississippi         South  4.0440846
## 26             Missouri North Central  5.3598917
## 27              Montana          West  1.2128379
## 28             Nebraska North Central  1.7521372
## 29               Nevada          West  3.1104763
## 30        New Hampshire     Northeast  0.3798036
## 31           New Jersey     Northeast  2.7980319
## 32           New Mexico          West  3.2537239
## 33             New York     Northeast  2.6679599
## 34       North Carolina         South  2.9993237
## 35         North Dakota North Central  0.5947151
## 36                 Ohio North Central  2.6871225
## 37             Oklahoma         South  2.9589340
## 38               Oregon          West  0.9396843
## 39         Pennsylvania     Northeast  3.5977513
## 40         Rhode Island     Northeast  1.5200933
## 41       South Carolina         South  4.4753235
## 42         South Dakota North Central  0.9825837
## 43            Tennessee         South  3.4509357
## 44                Texas         South  3.2013603
## 45                 Utah          West  0.7959810
## 46              Vermont     Northeast  0.3196211
## 47             Virginia         South  3.1246001
## 48           Washington          West  1.3829942
## 49        West Virginia         South  1.4571013
## 50            Wisconsin North Central  1.7056487
## 51              Wyoming          West  0.8871131
filter(new_table, rate <= 0.71)
##           state        region      rate
## 1        Hawaii          West 0.5145920
## 2          Iowa North Central 0.6893484
## 3 New Hampshire     Northeast 0.3798036
## 4  North Dakota North Central 0.5947151
## 5       Vermont     Northeast 0.3196211
using pipe to put it all together

murders %>% select(state,region,rate) %>% filter(rate <= 0.71)
##           state        region      rate
## 1        Hawaii          West 0.5145920
## 2          Iowa North Central 0.6893484
## 3 New Hampshire     Northeast 0.3798036
## 4  North Dakota North Central 0.5947151
## 5       Vermont     Northeast 0.3196211
creating frames

grades <- data.frame(names=c("John", "juan","Jean","Yao"),
exam_1 = c(95, 80, 90, 85),
exam_2 = c(90, 85, 85, 90))
grades
##   names exam_1 exam_2
## 1  John     95     90
## 2  juan     80     85
## 3  Jean     90     85
## 4   Yao     85     90
class(grades$names)
## [1] "factor"
grades <- data.frame(names=c("John", "juan","Jean","Yao"),
exam_1 = c(95, 80, 90, 85),
exam_2 = c(90, 85, 85, 90),
stringsAsFactors = FALSE)

class(grades$names)
## [1] "character"
# EX 1: dplyr

# Loading data
library(dslabs)
data(murders)

# Loading dplyr
library(dplyr)

# Redefine murders so that it includes column named rate with the per 100,000 murder rates
murders <- mutate(murders, rate=total/population * 100000)
# EX 2: mutate

# Note that if you want ranks from highest to lowest you can take the negative and then compute the ranks
x <- c(88, 100, 83, 92, 94)
rank(-x)
## [1] 4 1 5 3 2
# Defining rate
rate <-  murders$total/ murders$population * 100000

# Redefine murders to include a column named rank
# with the ranks of rate from highest to lowest
murders <- mutate(murders, rank(-rate))
murders
##                   state abb        region population total       rate
## 1               Alabama  AL         South    4779736   135  2.8244238
## 2                Alaska  AK          West     710231    19  2.6751860
## 3               Arizona  AZ          West    6392017   232  3.6295273
## 4              Arkansas  AR         South    2915918    93  3.1893901
## 5            California  CA          West   37253956  1257  3.3741383
## 6              Colorado  CO          West    5029196    65  1.2924531
## 7           Connecticut  CT     Northeast    3574097    97  2.7139722
## 8              Delaware  DE         South     897934    38  4.2319369
## 9  District of Columbia  DC         South     601723    99 16.4527532
## 10              Florida  FL         South   19687653   669  3.3980688
## 11              Georgia  GA         South    9920000   376  3.7903226
## 12               Hawaii  HI          West    1360301     7  0.5145920
## 13                Idaho  ID          West    1567582    12  0.7655102
## 14             Illinois  IL North Central   12830632   364  2.8369608
## 15              Indiana  IN North Central    6483802   142  2.1900730
## 16                 Iowa  IA North Central    3046355    21  0.6893484
## 17               Kansas  KS North Central    2853118    63  2.2081106
## 18             Kentucky  KY         South    4339367   116  2.6732010
## 19            Louisiana  LA         South    4533372   351  7.7425810
## 20                Maine  ME     Northeast    1328361    11  0.8280881
## 21             Maryland  MD         South    5773552   293  5.0748655
## 22        Massachusetts  MA     Northeast    6547629   118  1.8021791
## 23             Michigan  MI North Central    9883640   413  4.1786225
## 24            Minnesota  MN North Central    5303925    53  0.9992600
## 25          Mississippi  MS         South    2967297   120  4.0440846
## 26             Missouri  MO North Central    5988927   321  5.3598917
## 27              Montana  MT          West     989415    12  1.2128379
## 28             Nebraska  NE North Central    1826341    32  1.7521372
## 29               Nevada  NV          West    2700551    84  3.1104763
## 30        New Hampshire  NH     Northeast    1316470     5  0.3798036
## 31           New Jersey  NJ     Northeast    8791894   246  2.7980319
## 32           New Mexico  NM          West    2059179    67  3.2537239
## 33             New York  NY     Northeast   19378102   517  2.6679599
## 34       North Carolina  NC         South    9535483   286  2.9993237
## 35         North Dakota  ND North Central     672591     4  0.5947151
## 36                 Ohio  OH North Central   11536504   310  2.6871225
## 37             Oklahoma  OK         South    3751351   111  2.9589340
## 38               Oregon  OR          West    3831074    36  0.9396843
## 39         Pennsylvania  PA     Northeast   12702379   457  3.5977513
## 40         Rhode Island  RI     Northeast    1052567    16  1.5200933
## 41       South Carolina  SC         South    4625364   207  4.4753235
## 42         South Dakota  SD North Central     814180     8  0.9825837
## 43            Tennessee  TN         South    6346105   219  3.4509357
## 44                Texas  TX         South   25145561   805  3.2013603
## 45                 Utah  UT          West    2763885    22  0.7959810
## 46              Vermont  VT     Northeast     625741     2  0.3196211
## 47             Virginia  VA         South    8001024   250  3.1246001
## 48           Washington  WA          West    6724540    93  1.3829942
## 49        West Virginia  WV         South    1852994    27  1.4571013
## 50            Wisconsin  WI North Central    5686986    97  1.7056487
## 51              Wyoming  WY          West     563626     5  0.8871131
##    rank(-rate)
## 1           23
## 2           27
## 3           10
## 4           17
## 5           14
## 6           38
## 7           25
## 8            6
## 9            1
## 10          13
## 11           9
## 12          49
## 13          46
## 14          22
## 15          31
## 16          47
## 17          30
## 18          28
## 19           2
## 20          44
## 21           4
## 22          32
## 23           7
## 24          40
## 25           8
## 26           3
## 27          39
## 28          33
## 29          19
## 30          50
## 31          24
## 32          15
## 33          29
## 34          20
## 35          48
## 36          26
## 37          21
## 38          42
## 39          11
## 40          35
## 41           5
## 42          41
## 43          12
## 44          16
## 45          45
## 46          51
## 47          18
## 48          37
## 49          36
## 50          34
## 51          43
# EX 3: select

# Load dplyr
library(dplyr)

# Use select to only show state names and abbreviations from murders
select(murders, state, abb)
##                   state abb
## 1               Alabama  AL
## 2                Alaska  AK
## 3               Arizona  AZ
## 4              Arkansas  AR
## 5            California  CA
## 6              Colorado  CO
## 7           Connecticut  CT
## 8              Delaware  DE
## 9  District of Columbia  DC
## 10              Florida  FL
## 11              Georgia  GA
## 12               Hawaii  HI
## 13                Idaho  ID
## 14             Illinois  IL
## 15              Indiana  IN
## 16                 Iowa  IA
## 17               Kansas  KS
## 18             Kentucky  KY
## 19            Louisiana  LA
## 20                Maine  ME
## 21             Maryland  MD
## 22        Massachusetts  MA
## 23             Michigan  MI
## 24            Minnesota  MN
## 25          Mississippi  MS
## 26             Missouri  MO
## 27              Montana  MT
## 28             Nebraska  NE
## 29               Nevada  NV
## 30        New Hampshire  NH
## 31           New Jersey  NJ
## 32           New Mexico  NM
## 33             New York  NY
## 34       North Carolina  NC
## 35         North Dakota  ND
## 36                 Ohio  OH
## 37             Oklahoma  OK
## 38               Oregon  OR
## 39         Pennsylvania  PA
## 40         Rhode Island  RI
## 41       South Carolina  SC
## 42         South Dakota  SD
## 43            Tennessee  TN
## 44                Texas  TX
## 45                 Utah  UT
## 46              Vermont  VT
## 47             Virginia  VA
## 48           Washington  WA
## 49        West Virginia  WV
## 50            Wisconsin  WI
## 51              Wyoming  WY
# EX 4: filter

# Add the necessary columns
murders <- mutate(murders, rate = total/population * 100000, rank = rank(-rate))

# Filter to show the top 5 states with the highest murder rates
filter(murders, rank <= 5)
##                  state abb        region population total      rate
## 1 District of Columbia  DC         South     601723    99 16.452753
## 2            Louisiana  LA         South    4533372   351  7.742581
## 3             Maryland  MD         South    5773552   293  5.074866
## 4             Missouri  MO North Central    5988927   321  5.359892
## 5       South Carolina  SC         South    4625364   207  4.475323
##   rank(-rate) rank
## 1           1    1
## 2           2    2
## 3           4    4
## 4           3    3
## 5           5    5
# EX 5: filter with !=

# Use filter to create a new data frame no_south
no_south <- filter(murders, region != "South")

# Use nrow() to calculate the number of rows
nrow(no_south)
## [1] 34
# EX 6: filter with %in%

# Create a new data frame called murders_nw with only the states from the northeast and the west
murders_nw <- filter(murders, region %in% c("Northeast", "West"))

# Number of states (rows) in this category
nrow(murders_nw)
## [1] 22
# EX 7: filtering by two conditions

# add the rate column
murders <- mutate(murders, rate =  total / population * 100000, rank = rank(-rate))

# Create a table, call it `my_states`, that satisfies both the conditions
my_states <- filter(murders, region %in% c("Northeast", "West") & rate < 1)

# Use select to show only the state name, the murder rate and the rank
select(my_states, state, rate, rank)
##           state      rate rank
## 1        Hawaii 0.5145920   49
## 2         Idaho 0.7655102   46
## 3         Maine 0.8280881   44
## 4 New Hampshire 0.3798036   50
## 5        Oregon 0.9396843   42
## 6          Utah 0.7959810   45
## 7       Vermont 0.3196211   51
## 8       Wyoming 0.8871131   43
# EX 8: Using the pipe %>%

## Define the rate and rank column
murders <- mutate(murders, rate =  total / population * 100000, rank = rank(-rate))

# show the result and only include the state, rate, and rank columns, all in one line
filter(murders, region %in% c("Northeast", "West") & rate < 1) %>%
select(state, rate, rank)
##           state      rate rank
## 1        Hawaii 0.5145920   49
## 2         Idaho 0.7655102   46
## 3         Maine 0.8280881   44
## 4 New Hampshire 0.3798036   50
## 5        Oregon 0.9396843   42
## 6          Utah 0.7959810   45
## 7       Vermont 0.3196211   51
## 8       Wyoming 0.8871131   43
# EX 9: mutate, filter and select

# Loading the libraries
library(dplyr)
data(murders)

# Create new data frame called my_states (with specifications in the instructions)
my_states <- murders %>%
mutate(rate =  total / population * 100000, rank = rank(-rate)) %>%
filter(region %in% c("Northeast", "West") & rate < 1) %>%
select(state, rate, rank)

my_states
##           state      rate rank
## 1        Hawaii 0.5145920   49
## 2         Idaho 0.7655102   46
## 3         Maine 0.8280881   44
## 4 New Hampshire 0.3798036   50
## 5        Oregon 0.9396843   42
## 6          Utah 0.7959810   45
## 7       Vermont 0.3196211   51
## 8       Wyoming 0.8871131   43
