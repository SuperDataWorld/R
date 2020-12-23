library(rio)
library(tidyverse)
dat <- import("bestsellers.csv", setclass = "tibble")
str(dat)

#Improved str from dpylr
glimpse(dat)

#Select Columns
dat[,1:3,]
select(dat, Name)
dat %>% select(Name)
dat %>% select(Name:Reviews)
dat %>% select(Name:Reviews, -Author)
dat %>% select(-Genre, -Name)

#Rename Columns
dat <- dat %>% rename(Rating = `User Rating`)
 
#Filter
dat %>% filter(Year == 2019)
dat %>% filter(Year == 2019, Rating > 4.8)

#Order lowest to Highest to order highest to lower wrap in desc  
dat %>% arrange(Reviews)
dat %>% arrange(desc(Reviews))

#Filter and Arrange
dat %>% filter(Reviews > 10000) %>% arrange(desc(Reviews))
dat %>% filter(Year == 2019) %>% arrange(desc(Rating))
dat %>% filter(Year == 2019) %>% arrange(desc(Rating),desc(Reviews))

#Mutate
dat <- dat %>% mutate(Price_Cat = ifelse(Price > 10,'High',ifelse(Price > 5,'Medium','Low')))
dat2 <- dat %>% mutate(Rating = Rating * 20, Price_in_Eur = Price / 1.1)
glimpse(dat2)


#Transmute
dat %>% transmute(Name, Price_In_GBP = Price / 1.2)
dat %>% filter(Reviews > 5000 & Year == 2017) %>% transmute(Name,Author, percentage_rating = Rating * 20) %>% arrange(desc(percentage_rating))

#Bringing it all Together
final_data <- dat %>% select(-Genre) %>% rename(Rating = `User Rating`) %>% 
  filter(Year == 2019) %>% arrange(desc(Rating)) %>% 
  mutate(Price_Cat = ifelse(Price > 10,'High',ifelse(Price > 5,'Medium','Low')),Rating = Rating * 20, Price_in_Eur = Price / 1.1) 

#Top Ten Books of 2019 by Rating 
head(final_data, 10)

