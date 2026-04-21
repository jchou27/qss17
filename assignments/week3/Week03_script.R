## Data Visualization (GOVT16-QSS17) Spring 2026
## Week 3: ggplot2 Continued
##
## Name: Jack Chou
## Date: April 14- April 21, 2026


library(tidyverse)

theme_set(theme_minimal())

## Q1-a: Open IMDB and name movie. Check head tail.
movie <- read.csv("data/movie_metadata.csv")

movie

head(movie)
tail(movie)

## Q1-b: IMDB scores differ between color and black and white movies.
## Show in jittered scatter plot with either geom_jitter or position = "jitter"
## Remove NA
movie %>%
  ggplot(aes(x = color, y = imdb_score)) +
  geom_jitter() +
  labs(title = "IMDB Score by Color", x = "", y = "IMDB Score")


movie %>%
  filter(!is.na(color), color != "") %>%
  ggplot(aes(x = color, y = imdb_score)) +
  geom_jitter() +
  labs(title = "IMDB Score by Color", x = "", y = "IMDB Score")

## Q1-c: plot same vars but make it into a histogram. Distinguish levels of color
## with a fill aesthetic.
## Note: could use after_stat but used ..density.. to be more accurate to hw instruction

movie %>%
  filter(!is.na(color), color != "") %>%
  ggplot(aes(x = imdb_score, fill = color)) +
  geom_histogram(aes(y = ..density..), binwidth = 0.5) +
  facet_wrap(~color, ncol = 1) +
  scale_fill_manual(values = c("#6b6b6b", "#c97d4e")) +
  labs(title = "IMDB Score Distribution by Film Color", x = "IMDB Score", 
       y = "Density") +
  theme_minimal() +
  theme(legend.position = "none",
        plot.title = element_text(hjust = 0.5))

## Q2 Load data set calling approve. Look at head and tail
approve <- read.csv("data/approval_data.csv")

approve

head(approve)
tail(approve)

glimpse(approve)

## 2-a (i) make a quick line plot of year on the x-axis and approve on the y-axis
approve %>%
  ggplot(aes(x = year, y = approve)) +
  geom_line() +
  labs(title = "Presidential Approval Ratings Over Time (1977-2002)", x = "Year", y = "Approval Rating")

## 2-a (ii) Make a new variable combining year and qrt into one year-quarter variable
approve <- approve %>%
  mutate(year_qrt = year + (qrt - 1) / 4)
approve

glimpse(approve)
  
## 2-a (iii) Subset to time variable, econapp, and fpapp
## 2-a (iv) Pivot to long form with type and value columns
approve_long <- approve %>%
  select(year_qrt, econapp, fpapp) %>%
  pivot_longer(cols = c(econapp, fpapp), names_to = "type", values_to = "value")
approve_long

## Q2-b: Line plot of two approval types over time
approve_long %>%
  ggplot(aes(x = year_qrt, y = value, color = type)) +
  geom_line(linewidth = 0.75) +
  scale_color_manual(values = c("econapp" = "#6aab80", "fpapp" = "#9b7fc7"),
                     labels = c("econapp" = "Economic Approval", "fpapp" = "Foreign Policy Approval")) +
  labs(title = "Presidential Approval Ratings Over Time (1977-2002)",
       x = "Year", y = "Approval Rating", color = "Type")

## Q2-c: Plot same graph but as scatterplot with smoother line geom
## Make points more transparent than the smoother lines via alpha at 0.4

approve_long %>%
  ggplot(aes(x = year_qrt, y = value, color = type)) +
  geom_point(alpha = 0.4) +
  geom_smooth() +
  scale_color_manual(values = c("econapp" = "#6aab80", "fpapp" = "#9b7fc7"),
                     labels = c("econapp" = "Economic Approval", "fpapp" = "Foreign Policy Approval")) +
  labs(title = "Presidential Approval Ratings Over Time (1977-2002)",
       x = "Year", y = "Approval Rating", color = "Type")

## Q2-d: Line plot of quarterly inflation and unemployment over time
econ_long <- approve %>%
  select(year_qrt, qrtinfl, qrtunem) %>%
  pivot_longer(cols = c(qrtinfl, qrtunem), names_to = "type", values_to = "value")
econ_long

econ_long %>%
  ggplot(aes(x = year_qrt, y = value, color = type)) +
  geom_line(linewidth = 0.75) +
  scale_color_manual(values = c("qrtinfl" = "#c0392b", "qrtunem" = "#2e86c1"),
                     labels = c("qrtinfl" = "Quarterly Inflation", "qrtunem" = "Quarterly Unemployment")) +
  scale_y_continuous(labels = scales::label_number(suffix = "%")) +
  labs(title = "Quarterly Inflation and Unemployment Over Time (1977-2002)",
       x = "Year", y = "Percentage", color = "Type")

## Q3: Open up the WIID dataset, look at head and tail
library(readxl)

wiid <- read_excel("data/WIID_30JUN2022_0.xlsx")
wiid
head(wiid)
tail(wiid)
glimpse(wiid)

## Q3-a: Create a comparison between countries that is NOT a bar plot.
## Plot avg GINI index values as points for 5 countries: GER, FRA, ITA, SPA, NOR
## Add labels to the points that says names of countries
## Make sure labels do not overlap with the points
wiid %>%
  filter(country %in% c("Germany", "France", "Italy", "Spain", "Norway"),
         year == 2000) %>%
  group_by(country) %>%
  summarize(mean_gini = mean(gini, na.rm = TRUE)) %>%
  ggplot(aes(x = country, y = mean_gini)) +
  geom_point() +
  geom_text(aes(label = country), nudge_y = 0.2, size = 3) +
  labs(x = "", y = "Average GINI Index Value", title = "Average GINI Index Value Across 5 Countries") +
  theme(axis.text.x = element_blank())

## Q3-b: Density plot of Gini by UN subregion for Africa
wiid %>%
  filter(region_un == "Africa", !is.na(gini)) %>%
  ggplot(aes(x = gini, fill = region_un_sub)) +
  geom_density(alpha = 0.25) +
  scale_fill_manual(values = colorRampPalette(c("#1a5276", "#e67e22"))(5)) +
  labs(
    title = "Income Inequality in Africa",
    x     = "Gini Index",
    y     = "Density",
    fill  = "Subregion"
  )

glimpse(wiid)
         