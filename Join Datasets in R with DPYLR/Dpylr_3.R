library(tidyverse)
library(rio)
library(lubridate)

orders <- import('Orders.csv', setclass="tibble")
products <- import('Products.csv', setclass="tibble")
customers <- import('Customers.csv', setclass="tibble")

customers
products 
View(orders) 

# Inner Join - Only Keep Matched Columns
orders %>% inner_join(products, by=c('Product_ID' = 'ID'))
orders %>% inner_join(products, by=c('Product_ID' = 'ID')) %>% group_by(Category, Service) %>% summarise(Total_Sales = sum(Price))

# Left Join - All of Left Data
orders %>% left_join(products, by=c('Product_ID' = 'ID'))

# Right Join - All of Right Data 
orders %>% right_join(products, by=c('Product_ID' = 'ID'))

# Full Join - Keep all Data
orders %>% full_join(products, by=c('Product_ID' = 'ID'))
View(orders %>% full_join(products, by=c('Product_ID' = 'ID')))


# Left Join By two seperately named columns
orders %>% left_join(customers, by=c('Customer_ID' = 'ID'))

# Left Join No By 
customers2 <- customers %>% rename(Customer_ID = ID)
left_join(orders, customers2)

# Double Join 
full_orders <- orders %>% left_join(customers, by = c('Customer_ID' = 'ID')) %>% left_join(products, by=c('Product_ID' = 'ID'))
full_orders
full_orders <- full_orders %>% filter(complete.cases(full_orders))
full_orders

# Filtering Joins - Semi and Anti Joins 

# lubridate month extraction 
month(full_orders$Date)
mar_orders <- full_orders %>% filter(month(Date) == 3)
mar_orders %>% select(-Customer_ID,-Product_ID,-ID)

# Which Customers Purchased in March 
semi_join(customers, mar_orders, by = c('ID'='Customer_ID'))

# Which Customers Didnt Purchase in March 
anti_join(customers, mar_orders, by = c('ID'='Customer_ID'))

# Which Products Sold in March 
semi_join(products, mar_orders, by = c('ID'='Product_ID'))

# Which Products Didnt Sell in March 
anti_join(products, mar_orders, by = c('ID'='Product_ID'))


