library(tidyverse)
library(rio)
library(lubridate)
setwd("~/Desktop/Data Analytics/R")

bikeshare <- import('bikeshare.csv', setclass="tibble")
glimpse(bikeshare)

# Remove current duration row and convert 
bikeshare <- bikeshare %>% select(-duration_sec)
bikeshare <- bikeshare %>% mutate(start_date = ymd_hms(start_date) ,end_date = ymd_hms(end_date))
glimpse(bikeshare)

# Using lubridate with filtering  

# Bike rides from April 2015 
bikeshare %>% filter(month(start_date) == 4 & year(start_date) == 2015)

# Bike rides from 1st Quarter 2016 
bikeshare %>% filter(quarter(start_date) == 1 & year(start_date) == 2016)

# Bike rides with a different start and end day 
bikeshare %>% filter(day(start_date) != day(end_date))

# Bike rides on a Sunday
bikeshare %>% filter(wday(start_date) == 1)

# Bike rides that started between 10 and 10.30 am 
bikeshare %>% filter(hour(start_date) == 10 & minute(start_date) <= 30)


# Using lubridate with aggregation 

# Rides by Day of the week
bikeshare %>% mutate(Weekday = wday(start_date, label = TRUE, abbr=TRUE))
wd <- bikeshare %>% mutate(weekday = wday(start_date, label = TRUE, abbr=TRUE)) %>% group_by(weekday) %>% summarise(rides = n())
plot(wd)

# Rides by Month
bikeshare %>% mutate(month = month(start_date, label = TRUE, abbr=TRUE))
mth <- bikeshare %>% mutate(month = month(start_date, label = TRUE, abbr=TRUE)) %>% group_by(month) %>% summarise(rides = n())
plot(mth)

# What is the peak hour to start travel 
bikeshare %>% mutate(hour = hour(start_date)) %>% group_by(hour) %>% summarise(num_trips = n()) %>% arrange(desc(num_trips))
hour <- bikeshare %>% mutate(hour = hour(start_date)) %>% group_by(hour) %>% summarise(num_trips = n()) %>% arrange(desc(num_trips))
plot(hour)

# Start station rides per quarter
bikeshare %>% group_by(start_station_name, quarter(start_date)) %>% summarise(trips = n()) %>% arrange(`quarter(start_date)`,desc(trips))

# End station rides per year
bikeshare %>% group_by(end_station_name, year(start_date)) %>% summarise(trips = n()) %>% arrange(`year(start_date)`,desc(trips))

# Top ride durations using calculated duration 

bikeshare %>% mutate(duration = end_date - start_date)
bikeshare %>% mutate(duration = end_date - start_date) %>% arrange(desc(duration))
bikeshare <- bikeshare %>% mutate(duration = end_date - start_date) %>% arrange(desc(duration))

# Rounding Datetimes 

# Nearest Quarter
bikeshare %>% mutate(quarter = round_date(start_date,unit='quarter')) %>% select(quarter, duration)

# Nearest quarter aggregate
bikeshare %>% mutate(quarter = round_date(start_date,unit='quarter')) %>% group_by(quarter) %>% summarise(total_travelled = sum(duration))

# Floor quarter aggregate    
bikeshare %>% mutate(quarter = floor_date(start_date,unit='quarter')) %>% group_by(quarter) %>% summarise(total_travelled = sum(duration))

# Floor year aggregate    
bikeshare %>% mutate(year = floor_date(start_date,unit='year')) %>% group_by(year) %>% summarise(total_travelled = sum(duration))

# Display only year
bikeshare %>% mutate(year = floor_date(start_date,unit='year')) %>% group_by(year) %>% summarise(total_travelled = sum(duration)) %>% mutate(year = year(year))



                                                                           
                     