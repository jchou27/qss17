## Data Visualization (GOVT16-QSS17) Spring 2026
## Intro to The Tidyverse
##
## Name: Jack Chou
## Date: April 7th - April 14th, 2026

## Q1: Filer

## 1a. Load tidyverse package
library(tidyverse)

## 1b. Load swiss dataset with data command, look at head.
# Data represents a few key socieconomic indicators of Switzerland
# in the late 19th-century
data("swiss")
head(swiss)

# Question mark to see more info about data
?swiss

## 1c. Turn dataset into a tibble
swiss_tibble <- as_tibble(swiss); swiss_tibble

## 1d. Filter dataset for provinces that have les than 50% male
## involvement in agriculture. Use pipe operator
# Note: This does not change the original dataset, just filters
swiss %>%
  filter(Agriculture < 50.0)

## 1e. Filter swiss dataset above 50% Catholic and below 70% fertility
swiss %>%
  filter(Catholic > 50, Fertility < 70)

## Q2: Arrange

## 2a. Take swiss dataset and arrange by Infant.Mortality
swiss %>%
  arrange(Infant.Mortality)

## 2b. Arrange swiss dataset by Catholic in descending order
## Note: descending function
swiss %>%
  arrange(desc(Catholic))

## 2c. Take swiss dataset, filter data for provinces with less than 
## 50% Catholic and arrange by Fertility
swiss %>%
  filter(Catholic < 50) %>%
  arrange(Fertility)

## 3. Mutate

## 3a. Download IMDB movie dataset and name it movies
## Note: Use read_csv(), optional to use file.choose() or file path
movies <- read_csv("data/movie_metadata.csv")

## 3b. Explore movie dataset via glimpse or str
glimpse(movies)
str(movies)

## 3c. Add a new variable to dataset budget2 with the mutate function
## and measure budget in millions of dollars
movies <- movies %>%
  mutate(budget2 = budget / 10e6)

glimpse(movies)

## 3d. Add a length variable that is properly measured in hours
movies <- movies %>%
  mutate(length = duration / 60)

glimpse(movies)

## 3e. Subset movie dataset from "Spectre" to "Skyfall"
## Note: Use the titles in movie_title to do this, not row col numbers
## str_which() = return instance where the pattern matches the string
## [1] = first instance
first_ind <- str_which(movies$movie_title, "Spectre"[1])
sec_ind <- str_which(movies$movie_title, "Skyfall"[1])

movies[first_ind:sec_ind, ]


