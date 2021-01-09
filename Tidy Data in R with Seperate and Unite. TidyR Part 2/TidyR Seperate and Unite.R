setwd("~/Desktop/Data Analytics/R")
library(rio)
library(tidyverse)

# Tidy Data 
# Variable - Column
# Observation - Row
# Value - Cell

# Separate - Separates one column in to multiple columns 

# Sample Data Set
name <- c('John Brady','Mary Tierney','Pat Spat','Tim Hin','Sandra Gregg')
weight_height <- c('100kg/1.82m','67kg/1.6m','110kg/1.91m','70kg/1.8m','80kg/1.82m')
class <- c(12,11,21,22,12)
credit <- c(50.10,19.28,34.56,20.56,12.3)
dat <- tibble(name,weight_height, class, credit)
dat

# Auto seperate on non alpha character
dat %>% separate(name, into=c('first_name','last_name'))

dat %>% separate(weight_height, into=c('weight','height'))

# Seperate using defined symbol
dat %>% separate(weight_height, into=c('weight','height'), sep="/")

# Convert Using separator location
dat %>% separate(class, into=c('floor','room'), sep=1)

# Convert to chr
dat %>% separate(credit, into=c('cr_$','cr_cent'))

# Convert Type
dat %>% separate(credit, into=c('cr_$','cr_cent'), convert = TRUE)

#import tree dataset
trees <- import('sanfran_tree.csv',setclass = 'tibble')
trees

# Separate with a regular expression - https://rstudio.com/wp-content/uploads/2016/09/RegExCheatsheet.pdf

# Seperate with pattern
trees %>% separate(site_info, into=c('place1','place2','type'), sep = ': ')
trees %>% separate(site_info, into=c('place1','place2','type'), sep = ' : ')

# Seperate with regular expression
trees %>% separate(site_info, into=c('place1','place2','type'), sep = '\\s*:\\s*')
trees <- trees %>% separate(site_info, into=c('place1','place2','type'), sep = '\\s*:\\s*')

# Unite - Combines multiple columns in to one column 

# Sample Data set
name <- c('John Brady','Mary Tierney','Pat Spat','Tim Hin','Sandra Gregg')
hours <- c(1,1,2,1,2)  
minutes <- c(23,12,56,12,12)
seconds <- c(12,11,22,33,NA)
dat2 <- tibble(name,hours, minutes, seconds)
dat2

# unite with default seperator 
dat2 %>% unite('time',hours, minutes, seconds)

# unite with defined seperator 
dat2 %>% unite('time',hours, minutes, seconds,sep=':')

# Remove NA from unite
dat2 %>% unite('time',hours, minutes, seconds,sep=':', na.rm=TRUE)

# Uniting our site info
trees
trees %>% unite('site_info',place1,place2,type,sep='_')












