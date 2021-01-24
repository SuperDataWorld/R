# Uncomment and run below if you dont have installed
# install.packages('tidyverse')
library(tidyverse)

dat <- tibble(
  id = seq(1,100),
  num = runif(100, 5.0, 5.2)
)

# Base R 
hist(dat$num,
     border="black", 
     col="red", 
     xlab='Number', 
     ylab='Frequency', 
     main='Sample Histogram')

# GGPLOT
pl1 <- ggplot(dat, aes(num)) 
pl1 + geom_histogram()

# binwidth
pl1 + geom_histogram(binwidth=0.05)
pl1 + geom_histogram(bins=50)
pl1 + geom_histogram(binwidth=0.1)



# color fill alpha
pl1  + geom_histogram(binwidth=0.1, color='red', fill='blue')

# color fill alpha
pl2 <- pl1 + geom_histogram(binwidth=0.1, color='black', fill='#8ade5a',alpha=.5) 
pl2

#labels 
pl3 <- pl2 + xlab('Number') + ylab('Frequency') + ggtitle('Histogram') 
pl3

# theme
# Uncomment and run below if you dont have installed
# install.packages("ggthemes")

pl3 + theme_wsj()
pl3 + theme_bw()
pl3 + theme_base()
pl4 <- pl3 + theme_economist()
pl4

# Reference Line 
pl4 + geom_vline(xintercept=(mean(dat$num)))


# Reference Line Coloured and Dotted
pl4 + geom_vline(xintercept=(mean(dat$num)), color='red', linetype = "dashed")

# Real Data - Whats is the count of bikerides per month in 2015

# Uncomment and run below if you dont have installed
# install.packages('rio')
# install.packages('lubridate')

library(lubridate)
library(rio)
bikeshare <- import('bikeshare.csv', setclass="tibble")

glimpse(bikeshare)

ggplot(bikeshare, aes(duration_sec)) +
  geom_histogram(bins=20, color='black', fill='#8ade5a') +
  xlab('Seconds') + ylab('Frequency') + ggtitle('Duration of Biketrips in Seconds') +
  theme_economist() +
  geom_vline(xintercept=(mean(bikeshare$duration_sec)), color='red', linetype = "dashed")

# find outliers
max(bikeshare$duration_sec)
min(bikeshare$duration_sec)
mean(bikeshare$duration_sec)
median(bikeshare$duration_sec)
boxplot(bikeshare$duration_sec)

# limit the axis
ggplot(bikeshare, aes(duration_sec)) +
  geom_histogram(bins=100, color='black', fill='grey') +
  xlab('Seconds') + ylab('Frequency') + ggtitle('Duration of Biketrips in Seconds') +
  theme_economist_white()+
  geom_vline(xintercept=(median(bikeshare$duration_sec)), color='black', linetype = "solid") +
  xlim(0,5000) 






