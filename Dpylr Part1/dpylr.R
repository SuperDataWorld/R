library(rio)
library(tidyverse)
dat <- import("bestsellers.csv", setclass = "tibble")

dat

#Select 
select(dat, Name)
dat %>% select(Name)
dat %>% select(Name:Reviews)
dat %>% select(Name:Reviews, -Author)
dat %>% select(-Genre, -Name)

#Rename
dat <- dat %>% rename(Rating = `User Rating`)
 
#Filter and Arrange
dat %>% filter(Reviews > 10000) %>% arrange(desc(Reviews))
dat %>% filter(Year == 2019) %>% arrange(desc(Rating))
dat %>% filter(Year == 2019) %>% arrange(desc(Rating),desc(Reviews))

#Mutate



#Transmute
dat %>% filter(Reviews > 5000 & Year == 2017) %>% transmute(Name,Author, percentage_rating = Rating * 20) %>% arrange(desc(percentage_rating))

                                                                                                               