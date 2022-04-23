# Week 7 assignment 
library(tidyverse)
library(skimr)
library(janitor)
library(car)
data <- readr::read_csv('http://www.minethatdata.com/Kevin_Hillstrom_MineThatData_E-MailAnalytics_DataMiningChallenge_2008.03.20.csv')

clean_names(data)

data$history_segment <- as.factor(data$history_segment)
data$zip_code <- as.factor(data$zip_code)
data$channel <- as.factor(data$channel)
data$segment <- as.factor(data$segment)
data$mens <- as.factor(data$mens)
data$womens <- as.factor(data$womens)
data$newbie <- as.factor(data$newbie)

# Practice using pivot_longer/wider() or separate()
# The greatest area of untidyness in the data set involves the columns for men (as binary), for women (as binary) in the household
# Here I used case_when() in place of options for pivot_longer()

lift_data <- data %>% 
  mutate(occupancy = case_when(
    mens == 1 & womens == 0 ~ "Men only",
    mens == 1 & womens == 1 ~ "Both men and women",
    mens == 0 & womens == 1 ~ "Women only",
    TRUE ~ NA_character_
  )) %>% 
  select(-contains("mens")) # removes unneeded columns

# View random selection of observation to check results
some(lift_data)

# Remove original data frame
rm(data)