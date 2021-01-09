setwd("~/Desktop/Data Analytics/R")
library(rio)
library(tidyverse)

# Tidy Data 
# Variable - Column
# Observation - Row
# Value - Cell

# Gather - Makes tables narrower and longer 
# Used when multiple observations contained within a row 

# Make grades tibble
name <- c('John','Mary','Pat','Tim','Sandra')
grade1 <- c(19,20,24,32,45)
grade2 <- c(34,56,78,43,34)
grades <- tibble(name,grade1, grade2)
grades

# Gather grades
grades <- grades %>% gather('grade1','grade2',key=grade,value=result)
grades

# Import population 
pop <- import('population.csv',setclass = 'tibble')
view(pop)

# Gather three rows - this keeps the rest
pop %>% gather('year_1960','year_1970','year_1980',key="year", value='population')

# Gather range of rows and single row - this keeps the rest
pop %>% gather(year_1960:year_1970,'year_1980',key="year", value='population') %>% 
  select(country,year,population) %>% 
  filter(country == 'France')

# Cyprus dataset 1960 - 1980
cyprus <- pop %>% gather(year_1960:year_1980,key="year", value='population') %>% 
  select(country,year,population) %>% 
  mutate(year = substr(year,6,10)) %>% 
  filter(country == 'Cyprus') 

cyprus

# Plot Cyprus Data
plot(cyprus$population,cyprus$year,xlab='Population',ylab='Year',type='l')

# Ireland Dataset for 1960 - 2017
ireland <- pop %>% select(-year_2018) %>% 
  # gather all rows except 2
  gather(key="year", value='population',-country, -country_code) %>% 
  mutate(year = substr(year,6,10)) %>% 
  filter(country == 'Ireland') 

ireland

# Plot Ireland Data
plot(ireland$population,ireland$year,xlab='Population',ylab='Year',type='l')


# Spread- Makes tables wider and shorter
# Observation is scattered across multiple columns 

# Undo gather on grades
grades
grades %>% spread(key = grade, value = result)

# Create staff tibble 
name <- c('John','Mary','Pat','Tim','Sandra','John','Mary','Pat','Tim','Sandra')
category <- c('age','age','age','age','age','PPS','PPS','PPS','PPS','PPS')
details <- c(34,56,78,43,34, '234567V', '453789M','788983R','N467896O','909808I')
staff <- tibble(name,category, details)
staff

# Tidy Staff Tibble
staff <- staff %>% spread(key = category, value = details)
staff

# Undo gather on Ireland data set
ireland
ireland <- ireland %>% spread(key = year, value = population)
view(ireland)
