setwd("/Users/adamgrant/Desktop/Data Analytics/R")
library(rio)
library(tidyverse)
dat <- import('bestsellers.csv')

dat %>% filter(Reviews > 10000) %>% select(Author, Price) %>% mutate(price_point= 'expensive', Price = Price * 100 ) %>%  
  arrange(desc(Price)) %>% rename(COST = Price, NAME = Author)

dat %>% transmute(Price = Price * 5, Author = Author)

# Useful stuff in mutate and transmute 
x <- c(1,12,3,2,5)
cumsum(x)
cummean(x)
min_rank(desc(x))

# Integer Division
100 %/% 10.7

# MODULAR 
520 %% 100

# Summarize
dat2 <- group_by(dat,Year)
summarise(dat2, price = mean(Price), rating = mean(`User Rating`), Total_Reviews = sum(Reviews))

dat %>% group_by(Author) %>% summarise(rating = mean(`User Rating`), appears = count <- n())  arrange(desc()))
