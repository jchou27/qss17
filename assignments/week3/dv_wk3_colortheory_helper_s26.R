# Data Visualization Spring 2026
# Color Theory Helper Script 
# Professor Robert A. Cooper

library(tidyverse) # everything!
library(colorspace) # conversion of RGB to hex code, among other things. 
library(colorBlindness) # cool color blind tester. 
library(gridExtra) # This is for multiple plots on one visualization. 
# library(cowplot)

# The Anscombe quartet. 

data(anscombe); anscombe

g1 <-ggplot(anscombe, aes(x = x1, y = y1)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(x = "X1", y = "Y1") +
  expand_limits(y = 0, x = 4) +
  theme_minimal()

g1

g2 <- ggplot(anscombe, aes(x = x2, y = y2)) +
  geom_point(aes(x = x2, y = y2)) +
  geom_smooth(method = "lm") +
  labs(x = "X2", y = "Y2") +
  expand_limits(y = 0, x = 4) +
  theme_minimal()

g3 <- ggplot(anscombe, aes(x = x3, y = y3)) +
  geom_point(aes(x = x3, y = y3)) +
  geom_smooth(method = "lm") +
  labs(x = "X3", y = "Y3") +
  expand_limits(y = 0, x = 4) +
  theme_minimal()

g4 <- ggplot(anscombe, aes(x = x4, y = y4)) +
  geom_point(aes(x = x4, y = y4)) +
  geom_smooth(method = "lm") +
  labs(x = "X4", y = "Y4") +
  expand_limits(y = 0, x = 4) +
  theme_minimal()

# Take all four plots and place in one visualization. 

grid.arrange(g1, g2, g3, g4,  nrow = 2, top = "The Anscombe Quartet")

# To confirm, run the separate linear models. 

lm1 <- lm(y1 ~ x1, data = anscombe); summary(lm1)
lm2 <- lm(y2 ~ x2, data = anscombe); summary(lm2)
lm3 <- lm(y3 ~ x3, data = anscombe); summary(lm3)
lm4 <- lm(y4 ~ x4, data = anscombe); summary(lm4)

####
# COLOR THEORY.

# HUE. What is the true underlying color from color wheel.
# VALUE. Lightness/darkness. Translates to grayscale.
# INTENSITY. Purity of hue. Is there any white or black added to hue?

# TINTING V. SHADING. People screw these up all the time. 

# https://www.color-hex.com/
# USE HEX CODES FOR COLORS! 16,777,216 combinations!

###############################################################################
# COLOR THEORY RECTANGLES. 
# Let's make some colors. 
# Be creative. Try your own. 

rect <- data.frame(x1 = 3, x2 = 5, y1 = 2, y2 = 5); rect
rect2 <- data.frame(x1 = 5, x2 = 7, y1 = 2, y2 = 5); rect2
rect3 <- data.frame(x1 = 3.75, x2 = 4.25, y1 = 3, y2 = 4); rect3
rect4 <- data.frame(x1 = 5.75, x2 = 6.25, y1 = 3, y2 = 4); rect4
rect5 <- data.frame(x1 = 4.25, x2 = 5.75, y1 = 3.3, y2 =  3.7); rect5

# Can you make two colors look like one?
# Can you make one color look like two? 

ggplot() +
  geom_rect(data = rect, aes(xmin = x1, xmax = x2, ymin = y1, ymax = y2), fill = "#ffe599") +
  geom_rect(data = rect2, aes(xmin = x1, xmax = x2, ymin = y1, ymax = y2), fill = "#1f00e3") +
  geom_rect(data = rect3, aes(xmin = x1, xmax = x2, ymin = y1, ymax = y2), fill = "#e5ac23") +
  geom_rect(data = rect4, aes(xmin = x1, xmax = x2, ymin = y1, ymax = y2), fill = "#e5ac23") +
  theme_minimal()

# Let's explore the notion of `transparent` colors. 
# It's not really transparency that is happening; it's averaging over hue, intensity, value. 

rect6 <- data.frame(x1 = 3, x2 = 4, y1 = 2, y2 = 5); rect6
rect7 <- data.frame(x1 = 4, x2 = 5, y1 = 2, y2 = 5); rect7
rect8 <- data.frame(x1 = 5, x2 = 6, y1 = 2, y2 = 5); rect8
rect9 <- data.frame(x1 = 6, x2 = 7, y1 = 2, y2 = 5); rect9
rect10 <- data.frame(x1 = 7, x2 = 8, y1 = 2, y2 = 5); rect10
rect11 <- data.frame(x1 = 8, x2 = 9, y1 = 2, y2 = 5); rect11
rect12 <- data.frame(x1 = 9, x2 = 10, y1 = 2, y2 = 5); rect12
rect13 <- data.frame(x1 = 10, x2 = 11, y1 = 2, y2 = 5); rect13
rect14 <- data.frame(x1 = 4.5, x2 = 9.5, y1 = 3.25, y2 = 3.75); rect14

# To get our palette for our colors, we can use colorRampPalette. 
# That creates a function. The argument allows us to return as many break points 
# as we like. 

rc_pal <- colorRampPalette(c("#de582b", "#A882DD")) # For the vermillion colors. 
rc_pal(4)
rc_pal(15)

hallow_pal <- colorRampPalette(c("#fb7417", "#f0a16b"))

# Other colors...
# Try coolors.co for a pretty nice palette generator for ideas. 
# Or a slightly more manual approach at https://www.color-hex.com/

# Colors interact with each other and vibrate. 
# Example: Blues and red-orange fields with another color band. 
# Practice on your own. 

ggplot() +
  geom_rect(data = rect6, aes(xmin = x1, xmax = x2, ymin = y1, ymax = y2), fill = "#0b2fb2") +
  geom_rect(data = rect7, aes(xmin = x1, xmax = x2, ymin = y1, ymax = y2), fill = "#2849bf") +
  geom_rect(data = rect8, aes(xmin = x1, xmax = x2, ymin = y1, ymax = y2), fill = "#4c68d0") +
  geom_rect(data = rect9, aes(xmin = x1, xmax = x2, ymin = y1, ymax = y2), fill = "#7f95e1") +
  geom_rect(data = rect10, aes(xmin = x1, xmax = x2, ymin = y1, ymax = y2), fill = "#DE582B") +
  geom_rect(data = rect11, aes(xmin = x1, xmax = x2, ymin = y1, ymax = y2), fill = "#E26439") +
  geom_rect(data = rect12, aes(xmin = x1, xmax = x2, ymin = y1, ymax = y2), fill = "#E77048") +
  geom_rect(data = rect13, aes(xmin = x1, xmax = x2, ymin = y1, ymax = y2), fill = "#EC7C56") +
  geom_rect(data = rect14, aes(xmin = x1, xmax = x2, ymin = y1, ymax = y2), fill = "#E6A91D") +
  theme_minimal()


#################################################################################

# Practical color lessons in R. Color brewer, palettes, etc.
# USE COLOR HEX CODES! There are almost 17 million colors!

# One color is okay. But why waste an opportunity?

data("mtcars")  

mtcars %>%
  ggplot(aes(x = wt, y = mpg)) +
  geom_point(color = "red") +
  theme_minimal()

# You could let color vary by...a lot of things. 

# Color can reinforce movement. 
# Color here can reinforce the notion of fuel efficiency.
# Think 'heaviness of the carbon footprint'. 

mtcars %>%
  ggplot(aes(x = wt, y = disp, color = mpg)) +
  geom_point() +
  labs(x = "Weight (in Thousands of Pounds)",
       y = "Engine Volume (in Cubic Inches)",
       title = "Fuel Efficiency by Weight and Engine Volume",
       color = "Fuel Efficiency") +
  scale_color_gradientn(colors = c("black", "gray85")) +
  theme_minimal() + 
  theme(legend.position = "top")

?mtcars
glimpse(mtcars)

# colorRampPalette creates a function for any color scale.
# Pick the colors you want. 
# Doesn't have to be just two. This is how you can get creative. 


rc_pal <- colorRampPalette(c("blue", "#f59d12", "#9577ef"))

# Then choose the number of breaks you want. 
# The object created is a FUNCTION. 

rc_pal(9)

# You can also just stuff the function inside the plot.

# Check your number of categories; the palette has to match. 

mtcars %>%
  mutate(cyl_fact = factor(cyl)) %>%
  distinct(cyl_fact)

# In a discrete scale, the number inside should match. 

mtcars %>%
  ggplot(aes(x = wt, y = mpg, color = factor(cyl))) +
  geom_point() +
  labs(x = "Weight (in Thousands of Pounds)",
       y = "Miles Per Gallon",
       title = "Fuel Efficiency",
       subtitle = "By Weight and # of Cylinders",
       color = "Cylinders") +
  scale_color_manual(values = rc_pal(3)) + # See the function stuffed here. 
  theme_minimal() +
  theme(legend.position  = c(.8, .7),
        legend.background = element_rect(fill = "white", color = "gray80"),
        legend.title = element_text(size = 9))

# Using the colorspace library. 

# Let's say you want discrete colors from a continuous scale. 
# hcl =  hue (wavelength/'color' in layman's terms), chroma (intensity), & luminosity (value)    

# Figuring out your own funky palettes. 
# RGB: red-green-blue, 8 bits each, 0 to 255. 

# colorRamp v. colorRampPalette
# colorRamp returns RGB.
# colorRampPalette returns hex codes.
 
rc_pal <- colorRamp(c("orange", "blue"))
rc_pal(1) # Returns RGB values at lowest end.
rc_pal(0) # Returns at highest end.

rc_pal2 <- colorRampPalette(c("orange", "red"))
rc_pal2(3)
rc_pal2(7) # Returns hex codes. 

# Alternate ways to get a scale. 
# From the colorspace package. 

sequential_hcl(4, "Purples 3")
sequential_hcl(3, c(rc_pal(0), rc_pal(1))) 

# Convert between hex codes and RGB and vice versa.
# Also from colorspace package, for the hex2RGB function. 
# col2rgb is from grDevices, like colorRampPalette and colorRamp. 


hex2RGB("#ff0000") # Returned as RGB proportion. 
col2rgb("#ff0000") # Returned in units. Base R graphical device. 

##
library(tidyverse)
library(colorBlindness)

# Revisiting principles and best practices.

# Color theory. 

# A couple new geoms. 

# Details and Additions. 
# Facets. Scales, legends. Axes. Titles. Themes. 

# install.packages("colorBlindness")

plot1 <- mtcars %>%
  ggplot(aes(x = factor(cyl), fill = factor(cyl))) +
  geom_bar()

plot1

# Check the effect of various color blindnesses. 

cvdPlot(plot1)

# Deuteranopia = Blindness to green, green cones absent.
# Protanopia = Blindness to red, red cones absent. 
# Tritanopia = Blindness to blue, exceptionally rare. 
# Rod cells: brightness, shape, size.
# Cone cells: color. Red, blue, and green-sensitive cones.  

# Taking advantage of the likelihood of color blindness afflictions,
# the best bet is (a) vary value/lightness, and potentially (b) use blues. 

# Let's apply a new color scheme. 
# It works well, focuses on value/luminosity differences. 

col_new <- c("#304e8d", "#92e5ad", "#ee542d")

plot2 <- mtcars %>%
  ggplot(aes(x = factor(cyl), fill = factor(cyl))) +
  geom_bar() +
  scale_fill_manual(values = col_new) +
  theme_minimal()

colorBlindness::cvdPlot(plot2)

# You do not need the viridis scale, but it is a useful one. 

plot3 <- mtcars %>%
  ggplot(aes(x = factor(cyl), fill = factor(cyl))) +
  geom_bar() +
  scale_fill_viridis_d() +
  theme_minimal()

colorBlindness::cvdPlot(plot3)

# One hue, different values (and intensities, a bit). 
# Purplish blues. 

col_new2 <- c("#322671", "#5a48ba", "#9d8dee")

plot4 <- mtcars %>%
  ggplot(aes(x = factor(cyl), fill = factor(cyl))) +
  geom_bar() +
  scale_fill_manual(values = col_new2) +
  theme_minimal()

colorBlindness::cvdPlot(plot4)

# Result is almost as good as viridis!
