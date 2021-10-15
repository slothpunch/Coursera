# D:\1. Data365\1. Data Analyst Portfolio\R
# https://www.kaggle.com/jessemostipak/dive-into-dplyr-tutorial-1

getwd()

setwd("D:/1. Data365/1. Data Analyst Portfolio/R")

# we have a couple of options here - we can load the entire tidyverse or we can just load the 
# tidyverse packages that we're interested in using. I'm going to load the tidyverse, but alternatively you
# could run the following instead:

#library(readr)
#library(dplyr)

# Load a library
library(tidyverse)

# Load a csv file and save it into penguins
penguins <- read_csv('penguins_size.csv')

# Check the data
glimpse(penguins) # rows (observations), columns (variables), dtypes
head(penguins)    # first 6 rows, dtypes 
summary(penguins) # char - total observations, numer - min max median mean 1st,3rd Qu, null values

names(penguins)   # shows columns

# dplyr functions: filter(), arrange(), select(), mutate(), summarise()

# SELECT * FROM penguins WHERE island == "Torgersen"
# pipe operator %>% is Python dot operation?
penguins %>%
  filter(island == "Torgersen") %>%
  head()


# arrange() ascending order lower to higher
penguins %>%
  arrange(island) %>% 
  head()

penguins %>%
  arrange(culmen_length_mm) %>% 
  head()

# create a random subset of the penguins dataset
set.seed(406)

penguins_subset <- penguins %>%
  sample_n(12) # take random 12 rows 

head(penguins,12) # different result


# shows different results
penguins_subset <- penguins %>%
  sample_n(12) %>%
  arrange()

penguins_subset <- penguins %>%
  arrange() %>%
  sample_n(12) 
# 

penguins_subset

penguins_subset %>%
  arrange(species)

penguins_subset %>%
  arrange(desc(species))

penguins_subset %>%
  filter(culmen_length_mm > 40)

# between two values
penguins_subset %>%
  filter(between (flipper_length_mm, 180, 190))

# select/pick columns 
penguins_subset %>%
  select(species, island, sex)

# select all char data
penguins_subset %>%
  select(where(is.character))

penguins_subset %>%
  select(where(is_null))

penguins_subset %>%
  select(where(is.null))

penguins_subset %>%
  select(where(is.numeric))

penguins_subset %>%
  select(!where(is.numeric))

# mutate() is often used with group_by()?
# mutate() is used to add new variables/columns

# converting grams to pounds
# notice how the order of our columns stays the same, and the new column, body_weight_pounds, gets placed at the 
# far right of the dataframe. what function could we use to change this order?
penguins_subset %>%
  mutate(body_weight_pounds = body_mass_g / 453.59237)

# change the order of the variables
penguins_subset %>%
  mutate(body_weight_pounds = body_mass_g / 453.59237) %>%
  select(species, body_mass_g, body_weight_pounds, everything())

summarise(penguins) 

penguins_subset %>%
  summarise(mean(body_mass_g))

# avg_body_mass is the name for the column
penguins_subset %>%
  summarise(avg_body_mass = mean(body_mass_g)) 

penguins %>%
  summarise(avg_body_mass = mean(body_mass_g)) # displays NA as there are NAs 

penguins %>%
  select(where(is.null))

# na.rm - means na = NA(Not Available), rm = remove
penguins %>%
  summarise(avg_body_mass = mean(body_mass_g, na.rm = TRUE))

penguins %>%
  group_by(species) %>%
  summarise(avg_body_mass = mean(body_mass_g, na.rm = TRUE))

penguins %>%
  group_by(species, island) %>%
  summarise(avg_body_mass = mean(body_mass_g, na.rm = TRUE))

a <- read_csv('penguins_lter.csv')
summary(a)

# gganimate
# https://www.kaggle.com/mrisdal/gganimate

library(gganimate)

# install.packages("gganimate")

p <- ggplot(iris, aes(x = Petal.Width, y = Petal.Length)) +
  geom_point()

plot(p)

anim <- p +
  transition_states(Species,
                    transition_length = 2,
                    state_length = 1)

anim

# 2
# https://www.kaggle.com/jessemostipak/dive-deeper-into-dplyr-tutorial-2



