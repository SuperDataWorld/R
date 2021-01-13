library(tidyverse)
library(lubridate)

# Sample Dates 

# POSIX Standard, Calendar Time 
a <- as.POSIXct("2020-10-21 07:00", 'Pacific/Auckland')
a

b <- as.Date('2020-10-01')
b

# Creating Lubridate Datetimes
# (stored as the number of seconds since 1970-01-01 00:00:00 UTC)

dt1 <- as_datetime(898999000)
dt1

# Creating Lubridate Dates 
# (stored as the number of days since 1970-01-01)

d1 <- as_date(18000)
d1

# Converting to Datetimes and Dates
dt2 <- as_datetime(a)
dt2
d2 <- as_date(b)
d2

# Parsing Dates from Strings and Ints

# format year month day numeric
ymd(20150110)

# format day month year string
dmy('10032020')

# format month day year hour numeric
mdy_h(0910200020)

# format  day month year hour minute string
dmy_hm('200320111009')

# format  year month day hour minute second string
ymd_hms('20201010161732')

# datetime arithmetic
dt2 - dt1

# datetime + 1 day (86400 seconds)
dt1 + 86400

# date arithmetic
d1 - d2

# date plus 365 days 
d1 + 365

# Get Methods
dt1

# month
month(dt1)

# hour
hour(dt1)

# minute
minute(dt1)

# quarter
quarter(dt1)

# Day of the month
day(dt1)

# Day of the week
wday(dt1)

# Set Methods
day(dt1) <- 1
year(dt1) <- 2020
month(dt1) <- 12
dt1

# Round Methods
dt2

# Rounds to floor month 
floor_date(dt2, unit='month')

# Rounds to nearest month
round_date(dt2, unit='month')

round_date(dt2, unit='day')

# Rounds to ceiling month
ceiling_date(dt2,unit='month')

# Rolls back to previous month
rollback(dt2)

rollback(dt2, roll_to_first = TRUE)

# Rounds to ceiling quarter
ceiling_date(dt2,unit='quarter')




