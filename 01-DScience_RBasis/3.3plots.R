# 3.3 ## Basic Plots

more populus states have more murder

population_in_millions <- murders$population
total_gun_murders <- murders$total

plot(population_in_millions, total_gun_murders)

To look at the distribution of the data we use histogram

class(murders$rate)
## [1] "NULL"
murders <- mutate(murders, rate =  total / population * 100000, rank = rank(-rate))
murders
##                   state abb        region population total       rate rank
## 1               Alabama  AL         South    4779736   135  2.8244238   23
## 2                Alaska  AK          West     710231    19  2.6751860   27
## 3               Arizona  AZ          West    6392017   232  3.6295273   10
## 4              Arkansas  AR         South    2915918    93  3.1893901   17
## 5            California  CA          West   37253956  1257  3.3741383   14
## 6              Colorado  CO          West    5029196    65  1.2924531   38
## 7           Connecticut  CT     Northeast    3574097    97  2.7139722   25
## 8              Delaware  DE         South     897934    38  4.2319369    6
## 9  District of Columbia  DC         South     601723    99 16.4527532    1
## 10              Florida  FL         South   19687653   669  3.3980688   13
## 11              Georgia  GA         South    9920000   376  3.7903226    9
## 12               Hawaii  HI          West    1360301     7  0.5145920   49
## 13                Idaho  ID          West    1567582    12  0.7655102   46
## 14             Illinois  IL North Central   12830632   364  2.8369608   22
## 15              Indiana  IN North Central    6483802   142  2.1900730   31
## 16                 Iowa  IA North Central    3046355    21  0.6893484   47
## 17               Kansas  KS North Central    2853118    63  2.2081106   30
## 18             Kentucky  KY         South    4339367   116  2.6732010   28
## 19            Louisiana  LA         South    4533372   351  7.7425810    2
## 20                Maine  ME     Northeast    1328361    11  0.8280881   44
## 21             Maryland  MD         South    5773552   293  5.0748655    4
## 22        Massachusetts  MA     Northeast    6547629   118  1.8021791   32
## 23             Michigan  MI North Central    9883640   413  4.1786225    7
## 24            Minnesota  MN North Central    5303925    53  0.9992600   40
## 25          Mississippi  MS         South    2967297   120  4.0440846    8
## 26             Missouri  MO North Central    5988927   321  5.3598917    3
## 27              Montana  MT          West     989415    12  1.2128379   39
## 28             Nebraska  NE North Central    1826341    32  1.7521372   33
## 29               Nevada  NV          West    2700551    84  3.1104763   19
## 30        New Hampshire  NH     Northeast    1316470     5  0.3798036   50
## 31           New Jersey  NJ     Northeast    8791894   246  2.7980319   24
## 32           New Mexico  NM          West    2059179    67  3.2537239   15
## 33             New York  NY     Northeast   19378102   517  2.6679599   29
## 34       North Carolina  NC         South    9535483   286  2.9993237   20
## 35         North Dakota  ND North Central     672591     4  0.5947151   48
## 36                 Ohio  OH North Central   11536504   310  2.6871225   26
## 37             Oklahoma  OK         South    3751351   111  2.9589340   21
## 38               Oregon  OR          West    3831074    36  0.9396843   42
## 39         Pennsylvania  PA     Northeast   12702379   457  3.5977513   11
## 40         Rhode Island  RI     Northeast    1052567    16  1.5200933   35
## 41       South Carolina  SC         South    4625364   207  4.4753235    5
## 42         South Dakota  SD North Central     814180     8  0.9825837   41
## 43            Tennessee  TN         South    6346105   219  3.4509357   12
## 44                Texas  TX         South   25145561   805  3.2013603   16
## 45                 Utah  UT          West    2763885    22  0.7959810   45
## 46              Vermont  VT     Northeast     625741     2  0.3196211   51
## 47             Virginia  VA         South    8001024   250  3.1246001   18
## 48           Washington  WA          West    6724540    93  1.3829942   37
## 49        West Virginia  WV         South    1852994    27  1.4571013   36
## 50            Wisconsin  WI North Central    5686986    97  1.7056487   34
## 51              Wyoming  WY          West     563626     5  0.8871131   43
hist(murders$rate)

#One extreme value
murders$state[which.max(murders$rate)]
## [1] "District of Columbia"
boxplots are good at comparing different groupings like regions

boxplot(rate~region, data= murders)

# EX 1: Scatterplots

# Load the datasets and define some variables
library(dslabs)
data(murders)

population_in_millions <- murders$population/10^6
total_gun_murders <- murders$total

plot(population_in_millions, total_gun_murders)

# Transform population using the log10 transformation and save to object log10_population
log10_population <- log10(murders$population)

# Transform total gun murders using log10 transformation and save to object log10_total_gun_murders
log10_total_gun_murders <- log10(total_gun_murders)

# Create a scatterplot with the log scale transformed population and murders
plot(log10_population, log10_total_gun_murders)

# EX 2: Histograms

# Store the population in millions and save to population_in_millions
population_in_millions <- murders$population/10^6


# Create a histogram of this variable
hist(population_in_millions)

# EX 3: Boxplots

# Create a boxplot of state populations by region for the murders dataset
boxplot(murders$population~murders$region)
