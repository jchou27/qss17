## Data Visualization (GOVT16-QSS17) Spring 2026
## Intro to The Tidyverse
##
## Name: Jack Chou
## Date: April 7th - April 14th, 2026

## Q1: Filter

## 1a. Load tidyverse package
library(tidyverse)

## 1b. Load swiss dataset with data command, look at head.
## Data represents a few key socioeconomic indicators of Switzerland
## in the late 19th-century
data("swiss")
head(swiss)

# Question mark to see more info about data
?swiss

## 1c. Turn dataset into a tibble
swiss_tibble <- as_tibble(swiss); swiss_tibble

## 1d. Filter dataset for provinces that have less than 50% male
## involvement in agriculture. Use pipe operator
## Note: This does not change the original dataset, just filters
swiss %>%
  filter(Agriculture < 50)

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

## Q3: Mutate

## 3a. Download IMDB movie dataset and name it movies
## Note: Use read_csv(), optional to use file.choose() or file path
movies <- read_csv("data/movie_metadata.csv")

## 3b. Explore movie dataset via glimpse or str
glimpse(movies)
str(movies)

## 3c. Add a new variable to dataset budget2 with the mutate function
## and measure budget in millions of dollars
## Note: 1e6 = 1,000,000
movies <- movies %>%
  mutate(budget2 = budget / 1e6)

glimpse(movies)

## 3d. Add a length variable that is properly measured in hours
movies <- movies %>%
  mutate(length = duration / 60)

glimpse(movies)

## 3e. Subset movie dataset from "Spectre" to "Skyfall"
## Note: Use the titles in movie_title to do this, not row col numbers
## str_which() returns the row indices where the pattern matches
## [1] outside str_which() takes the first match, in case of multiple hits
first_ind <- str_which(movies$movie_title, "Spectre")[1]
sec_ind <- str_which(movies$movie_title, "Skyfall")[1]

movies[first_ind:sec_ind, ]

## Q4: Plots & ggplot2

## 4a. Read WIID and call it wiid.
## Note: Need to install readxl package to use read_excel() function
library(readxl)
wiid <- read_excel("data/WIID_30JUN2022_0.xlsx")

## 4b. Show head, tail, and glimpse of dataset
head(wiid)
tail(wiid)
glimpse(wiid)

## 4c. Filter dataset for just North American countries (include Mexico).
## Produce scatterplot of Gini coefficient over time (gini vs. year).
## Map country onto color

# To find the unique values for filtering
unique(wiid$region_wb)
unique(wiid$region_un_sub)

# Filter for North American countries
wiid_na <- wiid %>%
  filter(region_wb == "North America" | country == "Mexico")
wiid_na

wiid_na %>%
  ggplot(aes(x = year, y = gini, color = country)) +
  geom_point() +
  labs(
    x = "Year",
    y = "Gini Index",
    title = "Gini Coefficient Over Time in North America",
    color = "Country"
  ) +
  theme_minimal()

## 4d. Repeat the same problem but use a line plot instead and comment
wiid_na %>%
  ggplot(aes(x = year, y = gini, color = country)) +
  geom_line() +
  labs(
    x = "Year",
    y = "Gini Index",
    title = "Gini Coefficient Over Time in North America (Line Plot)",
    color = "Country"
  ) +
  theme_minimal()
# The lines are messy because the WIID dataset contains multiple Gini
# observations per country-year from different sources and income definitions
# (e.g., gross vs. net, household vs. per capita). geom_line() connects all
# of them in order, causing erratic zigzagging within each country.

## Q5: Basic statistics and summaries with summarize

## 5a. Use pipe operator and summarize the gini index, q1, and q5 with median
wiid %>%
  summarize(
    median_gini = median(gini, na.rm = TRUE),
    median_q1 = median(q1, na.rm = TRUE),
    median_q5 = median(q5, na.rm = TRUE)
  )

## 5b. For year 2000, find highest values for gini, d1, and d10 for Africa
## d1 = income share of bottom decile, d10 = income share of top decile
wiid %>%
  filter(region_un == "Africa", year == 2000) %>%
  summarize(
    max_gini = max(gini, na.rm = TRUE),
    max_d1   = max(d1, na.rm = TRUE),
    max_d10  = max(d10, na.rm = TRUE)
  )

## 5c. Filter for United States in 2000, show Gini index val w/o summarize
wiid %>%
  filter(country == "United States", year == 2000) %>%
  select(gini)
# There are multiple Gini values for the US in 2000 because the WIID compiles
# data from many different surveys and income definitions (gross vs. net,
# household vs. per capita). Each row is a separate observation from a
# different source. This is why the line plot in 4d looked so messy.

## 5d. Filter for African countries, report means, medians, and SDs of gini
## grouped by UN sub-region (not country — the hint says "just a few rows")
wiid %>%
  filter(region_un == "Africa") %>%
  group_by(region_un_sub) %>%
  summarize(
    mean_gini   = mean(gini, na.rm = TRUE),
    median_gini = median(gini, na.rm = TRUE),
    sd_gini     = sd(gini, na.rm = TRUE)
  ) %>%
  ungroup()

## Q6: More Plots

## Find the unique levels of region_un before converting to a factor
unique(wiid$region_un)

## Convert region_un to a factor column fact_region_un following the fact_ naming convention
wiid <- wiid %>%
  mutate(fact_region_un = factor(region_un))

glimpse(wiid)

## 6a. Group WIID data by UN region and year, faceted scatterplots of mean Gini
## facet_wrap() creates one panel per region within one plot environment
## ungroup() removes the grouping structure after summarize
wiid %>%
  group_by(fact_region_un, year) %>%
  summarize(mean_gini = mean(gini, na.rm = TRUE)) %>%
  ungroup() %>%
  ggplot(aes(x = year, y = mean_gini, color = fact_region_un)) +
  geom_point() +
  facet_wrap(~ fact_region_un) +
  labs(
    x = "Year",
    y = "Mean Gini Index",
    title = "Mean Gini Index by UN Region Over Time",
    color = "UN Region"
  ) +
  theme_minimal()

## 6b. Group the WIID data by OECD status and year, scatter plots of median Gini
## color = factor(oecd) maps OECD membership onto color so both groups appear on
## the same plot. geom_smooth() adds a smoother trend line per group
wiid %>%
  group_by(oecd, year) %>%
  summarize(median_gini = median(gini, na.rm = TRUE)) %>%
  ungroup() %>%
  ggplot(aes(x = year, y = median_gini, color = factor(oecd))) +
  geom_point() +
  geom_smooth() +
  labs(
    x = "Year",
    y = "Median Gini Index",
    title = "Median Gini Index by OECD Status Over Time",
    color = "OECD Member"
  ) +
  theme_minimal()

## 6c. Bar plot of median Gini by UN region and year, filtered to post-1945
## fill = fact_region_un maps region to bar color. facet_wrap separates by region
wiid %>%
  filter(year > 1945) %>%
  group_by(fact_region_un, year) %>%
  summarize(median_gini = median(gini, na.rm = TRUE)) %>%
  ungroup() %>%
  ggplot(aes(x = year, y = median_gini, fill = fact_region_un)) +
  geom_col() +
  facet_wrap(~ fact_region_un) +
  labs(
    x = "Year",
    y = "Median Gini Index",
    title = "Median Gini Index by UN Region Over Time (Post-1945)",
    fill = "UN Region"
  ) +
  theme_minimal()

## 6d. Histogram of top decile income share (d10) by UN region
## fill colors bar interiors (tied to variable = aesthetic)
## color would only outline the bars, not fill them
wiid %>%
  ggplot(aes(x = d10, fill = fact_region_un)) +
  geom_histogram() +
  labs(
    x = "Income Share of Top Decile (%)",
    y = "Count",
    title = "Distribution of Top Decile Income Share by UN Region",
    fill = "UN Region"
  ) +
  theme_minimal()

## 6e. Adapt the histogram to show density instead of count, with overlapping regions
## after_stat(density) transforms the y-axis from raw count to probability density
## position = "identity" makes bars overlap instead of stack (the default)
## alpha = 0.6 adds transparency so overlapping bars from different regions remain visible
wiid %>%
  ggplot(aes(x = d10, fill = fact_region_un, y = after_stat(density))) +
  geom_histogram(position = "identity", alpha = 0.6) +
  labs(
    x = "Income Share of Top Decile (%)",
    y = "Density",
    title = "Density of Top Decile Income Share by UN Region",
    fill = "UN Region"
  ) +
  theme_minimal()

## 6f. Boxplots of lowest quintile income share (q1) split by UN region
## q1 = percent of national income held by the bottom 20% of the population
## angle = 45 rotates x-axis labels so they don't overlap
wiid %>%
  ggplot(aes(x = fact_region_un, y = q1)) +
  geom_boxplot() +
  labs(
    x = "UN Region",
    y = "Income Share of Lowest Quintile (%)",
    title = "Lowest Quintile Income Share by UN Region"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

## 6g. Boxplots of Gini by income group, faceted by UN region
## factor() with explicit levels orders income groups from low to high income
## Transformation is kept inside the pipe so wiid is not permanently overwritten
## coord_flip() rotates axes so income group labels are readable without overlap
wiid %>%
  mutate(incomegroup = factor(incomegroup,
    levels = c("Low income", "Lower middle income",
               "Upper middle income", "High income"), ordered = TRUE)) %>%
  ggplot(aes(x = incomegroup, y = gini)) +
  geom_boxplot() +
  facet_wrap(~ fact_region_un) +
  coord_flip() +
  labs(
    x = "Income Group",
    y = "Gini Index",
    title = "Gini Scores by Income Group and UN Region"
  ) +
  theme_minimal()
