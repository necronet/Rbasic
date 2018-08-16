# Chapter 5 On Data transformation
library(nycflights13)
library(tidyverse)

# How could you use arrange() to sort all missing values to the start? (Hint: use is.na()).
# Abit cumbersome but here it goes:
arrange(flights, !is.na(year),
        !is.na(month),
        !is.na(day),
        !is.na(dep_time),
        !is.na(sched_dep_time),
        !is.na(dep_delay), 
        !is.na(arr_time),
        !is.na(sched_arr_time),
        !is.na(arr_delay),
        !is.na(carrier),
        !is.na(flight),
        !is.na(tailnum), 
        !is.na(origin),
        !is.na(dest),
        !is.na(air_time),
        !is.na(distance),
        !is.na(hour),
        !is.na(minute),
        !is.na(time_hour))

# What happens if you include the name of a variable multiple times in a select() call?
# Meh! nothing it will be uniquely selected
select(flights,year,year)

# What does the one_of() function do? Why might it be helpful in conjunction with this vector?
vars <- c("year", "month", "day", "dep_delay", "arr_delay")
# Helpful for example in select to go from 
select(flights,year,month,day, dep_delay, arr_delay)
# to this is nicer:
select(flights,one_of(vars))
  

# Does the result of running the following code surprise you? 
# How do the select helpers deal with case by default? How can you change that default?
# Ans. No suprises will select any column with time in it doesnt matter the case.
select(flights, contains("TIME"))




