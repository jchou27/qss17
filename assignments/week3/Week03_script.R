## Data Visualization (GOVT16-QSS17) Spring 2026
## Week 3: ggplot2 Continued
##
## Name: Jack Chou
## Date: April 14- April 21, 2026


library(tidyverse)

# Set global default for every plot to have theme_minimal()
theme_set(theme_minimal())

## Q1-a: Open IMDB and name movie. Check head tail.
movie <- read.csv("data/movie_metadata.csv")

movie

head(movie)
tail(movie)

## Q1-b: IMDB scores differ between color and black and white movies.
## Show in jittered scatter plot with either geom_jitter or position = "jitter"
## Remove NA

# First plot intentionally left with NA to demonstrate the problem the PDF flags.
movie %>%
  ggplot(aes(x = color, y = imdb_score)) +
  geom_jitter() +
  labs(x = "", y = "IMDB Score", title = "IMDB Score by Color")

# filter catches both R's NA type and empty strings (""), both of which appear in
# this dataset's color column.
movie %>%
  filter(!is.na(color), color != "") %>%
  ggplot(aes(x = color, y = imdb_score)) +
  geom_jitter() +
  labs(x = "", y = "IMDB Score", title = "IMDB Score by Color")

## Q1-c: plot same vars but make it into a histogram. Distinguish levels of color
## with a fill aesthetic.
## Note: could use after_stat but used ..density.. to be more accurate to hw instruction

movie %>%
  filter(!is.na(color), color != "") %>%
  ggplot(aes(x = imdb_score, fill = color)) +
  geom_histogram(aes(y = ..density..), binwidth = 0.5) +
  facet_wrap(~ color, ncol = 1) +
  scale_fill_manual(values = c("#6b6b6b", "#c97d4e")) +
  labs(x = "IMDB Score", y = "Density", title = "IMDB Score Distribution by Film Color") +
  theme(legend.position = "none", plot.title = element_text(hjust = 0.5))

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
  labs(x = "Year", y = "Approval Rating", title = "Presidential Approval Ratings Over Time (1977-2002)")

## 2-a (ii) Make a new variable combining year and qrt into one year-quarter variable

approve <- approve %>%
  mutate(year_qrt = year + (qrt - 1) / 4)
approve

glimpse(approve)

## 2-a (iii) Subset to time variable, econapp, and fpapp
## 2-a (iv) Pivot to long form with type and value columns
## Did these 2 questions together

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
  labs(x = "Year", y = "Approval Rating", title = "Presidential Approval Ratings Over Time (1977-2002)",
       color = "Type")

## Q2-c: Plot same graph but as scatterplot with smoother line geom
## Make points more transparent than the smoother lines via alpha at 0.4

approve_long %>%
  ggplot(aes(x = year_qrt, y = value, color = type)) +
  geom_point(alpha = 0.4) +
  geom_smooth() +
  scale_color_manual(values = c("econapp" = "#6aab80", "fpapp" = "#9b7fc7"),
                     labels = c("econapp" = "Economic Approval", "fpapp" = "Foreign Policy Approval")) +
  labs(x = "Year", y = "Approval Rating", title = "Presidential Approval Ratings Over Time (1977-2002)",
       color = "Type")

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
  labs(x = "Year", y = "Percentage %", title = "Quarterly Inflation and Unemployment Over Time (1977-2002)",
       color = "Type")

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
         year == 2000, !is.na(gini)) %>%
  group_by(country) %>%
  summarize(mean_gini = mean(gini, na.rm = TRUE)) %>%
  ungroup() %>%
  ggplot(aes(x = country, y = mean_gini)) +
  geom_point() +
  geom_text(aes(label = country), nudge_y = 0.1, size = 3) +
  labs(x = "", y = "Average Gini Index", title = "Average GINI Index Value Across 5 Countries") +
  theme(axis.text.x = element_blank())

## Q3-b: Density plot of Gini by UN subregion for Africa
wiid %>%
  filter(region_un == "Africa", !is.na(gini)) %>%
  ggplot(aes(x = gini, fill = region_un_sub)) +
  geom_density(alpha = 0.25) +
  scale_fill_manual(values = colorRampPalette(c("#1a5276", "#e67e22"))(5)) +
  labs(x = "Gini Index", y = "Density", title = "Income Inequality in Africa", fill = "Subregion")

## Q3-c: Bar plot of difference from Africa's average Gini per country
africa_avg <- wiid %>%
  filter(region_un == "Africa", !is.na(gini)) %>%
  summarize(continent_avg = mean(gini, na.rm = TRUE)) %>%
  pull(continent_avg)
africa_avg

wiid %>%
  filter(region_un == "Africa", !is.na(gini)) %>%
  group_by(country) %>%
  summarize(mean_gini = mean(gini, na.rm = TRUE)) %>%
  ungroup() %>%
  mutate(diff = mean_gini - africa_avg) %>%
  ggplot(aes(x = reorder(country, diff), y = diff)) +
  geom_col(fill = "#2e7d8c") +
  coord_flip() +
  labs(x = "", y = "Difference from Continental Average",
       title = "Deviation from Africa's Average Gini Index")

## Q3-d: Point plot of mean Gini by country for Europe, flipped and reordered
wiid %>%
  filter(region_un == "Europe", !is.na(gini)) %>%
  group_by(country) %>%
  summarize(mean_gini = mean(gini, na.rm = TRUE)) %>%
  ungroup() %>%
  ggplot(aes(x = reorder(country, mean_gini), y = mean_gini)) +
  geom_point() +
  coord_flip() +
  labs(x = "", y = "Mean Gini Index", title = "Mean Gini Index by European Country") +
  theme(axis.text.y = element_text(size = 6))

## Q3-e: Median Gini by year for Americas subregions with overall gray smoother
americas_sub <- wiid %>%
  filter(region_un == "Americas", !is.na(gini)) %>%
  group_by(region_un_sub, year) %>%
  summarize(median_gini = median(gini, na.rm = TRUE), .groups = "drop")
americas_sub

americas_sub %>%
  ggplot(aes(x = year, y = median_gini, color = region_un_sub)) +
  geom_point(alpha = 0.3) +
  geom_smooth(se = FALSE) +
  geom_smooth(aes(group = 1), color = "#d3d3d3", se = FALSE) +
  scale_color_manual(values = c("#e67e22", "#1a5276", "#27ae60", "#8e44ad")) +
  labs(x = "Year", y = "Median Gini Index", title = "Median Gini Index by Year for Americas Subregions",
       color = "Subregion")

## Q3-f: Dotplot of Gini by income group for Western Asia, with median summary
wiid %>%
  filter(region_un_sub == "Western Asia", !is.na(gini), !is.na(incomegroup)) %>%
  ggplot(aes(x = incomegroup, y = gini)) +
  geom_dotplot(
    binaxis = "y",
    stackdir = "center",
    alpha = 0.6,
    dotsize = 0.5
  ) +
  stat_summary(fun = median, geom = "point", color = "#c0392b", size = 3) +
  labs(x = "Income Group", y = "Gini Index", title = "Gini Index by Income Group in Western Asia")
