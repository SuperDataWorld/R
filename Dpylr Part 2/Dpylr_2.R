setwd("~/Desktop/Data Analytics/R")
library(rio)
library(tidyverse)
dat <- import('bestsellers.csv', setclass="tibble") %>% rename(Rating = `User Rating`)

# Question 1: Average Book Price Per Year
dat %>% group_by(Year) %>% summarise(price = mean(Price, na.rm=TRUE))
x <- dat %>% group_by(Year) %>% summarise(price = mean(Price, na.rm=TRUE))
plot(x,ylab='Price',type="b")

# Question 2: Average Rating Per Year
dat %>% group_by(Year) %>% summarise(rating = mean(Rating, na.rm=TRUE))
x <- dat %>% group_by(Year) %>% summarise(rating = mean(Rating, na.rm=TRUE))
plot(x,ylab='Rating',type="b")


# Question 3: Total Reviews Per Year 
dat %>% group_by(Year) %>% summarise(Total_Reviews = sum(Reviews, na.rm=TRUE))
x <- dat %>% group_by(Year) %>% summarise(Total_Reviews = sum(Reviews, na.rm=TRUE)) 
options(scipen=5)
plot(x,ylab='Total Reviews',type="b")

# Question 4: Fiction V Non-Fiction?
dat %>% group_by(Year) %>% summarise(Fiction = sum(Genre == "Fiction", na.rm=TRUE)) %>% mutate(Non_Fiction = 50 - Fiction)

# Multi Summary
dat %>% group_by(Year) %>% summarise(avg_price = mean(Price, na.rm=TRUE), avg_rating = mean(Rating, na.rm=TRUE), Total_Reviews = sum(Reviews, na.rm=TRUE))

# Question 5: Do Some Authors Appear Multiple Times?
n_distinct(dat$Author)
dat %>% count(Author) %>% arrange(desc(n))
dat %>% filter(Author == 'Jeff Kinney')
dat %>% filter(Price == 0)

# Question 6: What are the Average User Ratings of Authors with the Most Books on the Chart. 
dat %>% group_by(Author) %>% summarise(rating = mean(Rating), appears = count <- n()) %>%  arrange(desc(appears))

# Question 7: What are the Rating Trends Over the 11 Years 
dat %>% group_by(Year) %>% summarise(rating_over_4.8 = sum(Rating > 4.8), rating_over_4.5  = sum(Rating > 4.5), rating_over_4.25  = sum(Rating > 4.25), 
          rating_over_4  = sum(Rating > 4)) %>% arrange(desc(Year))

# Question 8: What are the Worst and Best Ranked Books

# Worst 
dat %>%
  group_by(Year) %>% 
  filter(min_rank(Rating) == 1) %>%
  arrange(desc(Year))

# Best
dat %>%
  group_by(Year) %>% 
  filter(min_rank(desc(Rating)) == 1) %>%
  arrange(desc(Year))

# Question 9: What is The Most Frequent Rating Each Year?
dat %>% group_by(Year, Rating) %>% summarise(rating_count=n()) %>% filter(min_rank(desc(rating_count)) == 1) %>% arrange(desc(Year))


# Question 10: Which Authors Have Had the Most Books on the Chart in a Single Year?
dat %>% group_by(Author, Year) %>% summarise(appears=n()) %>% arrange(desc(appears))
dat %>% filter(Author == 'Stephenie Meyer' & Year == 2009)












