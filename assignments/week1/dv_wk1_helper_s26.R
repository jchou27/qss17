# Data Visualization
# Prof. Robert A. Cooper
# Dartmouth College, Spring 2026

################################################################################
## Week 1 Practice material.  

## DAY 1. 

##  BREAK TO R #1. 

# First, let's open a new project. 

# Next, let's install a package. Might as well be tidyverse. 

# R has a LOT of code already in its base programming. 

# That said, there is a lot of code out there to be installed as 'packages'. 
# You install said code from CRAN repository,
# or maybe Github if it's a developer version. 

# There are at least 3 ways to install a package.

install.packages("tidyverse") # One way. 


# Go to Tools -> Install Packages # Way 2. 
# Go to Packages tab in plotting window, click Install, type package name. # Way 3.

# Once you have the package downloaded, you must activate/attach it. 

library(tidyverse)

# Next, let's practice creating an object. 

banana <- 15

banana 

banana
print(banana)

banana*7

# To show what's contained in the object, type it and enter or print() it. 

banana
print(banana)

# You can create multiple objects and interact them. 

apple <- 6
banana * apple

is.vector(apple) # Check to confirm the structure of the object. 

# Warning: you can easily overwrite objects. Easy mistakes made here.
# Lesson: more often than not, it's a bad idea to overwrite objects.  

apple <- 8
class(apple)

# A quick example on the difference between numerics and numbers as characters. 

apple <- 10
apple <- "10"

class(apple)

# Objects. 
 
# Objects are containers with labels. Inside is some piece of information. 
# Things in the R universe have classification, like plants v. animals. 
# Certain functions and forms work with certain classes and not others. 

# First classification distinction: homogeneous or heterogeneous?

# Some objects are all the same inside. Some can be made up of different types.

# Homogeneous: vectors, matrices, arrays.
# Heterogeneous: data frames, lists. 

# The assignment operator. '<-' or '=' (I suggest '<-')

# Vectors. "Atomic" vectors.  

# Vectors are 'flat' or one-dimensional. They can have length, but not
# more than one dimension. 

# Types: double/numeric, integer, factor, character/string, logical. 
# Rare types: complex, raw. Don't worry about it. 

a <- 4 # This is actually a vector of length 1. 

# Again, the mildest difference between typeof() and class(). 

typeof(a) # "double", same as below. 'double precision floating point decimal' 
class(a) # "numeric", same as above. 

b <- 3
d <- 5
e <- 7

# You can combine vectors with the c() function ("combine" or "concatenate")
# You can also create vectors with the c() function. 

# Vectors stay 1D, even when nesting. 

numbers <- c(a, b, d)
numbers
class(numbers)

numbers2 <- c(c(a, b), c(d, e)) # Note: c(a, b, d, e) would have done the same. 
numbers; numbers2
numbers2

# Vectors can take names with the names() function.
# Note: the `names' of the vector are empty and are taking the assignment.  

names(numbers2)

names(numbers2) <- c("a", "b", "d", "e")
numbers2 # Now, when, I print numbers2, I see the name labels as well. 
class(numbers2)

# Integer vector. The 'L' is the way to indicate integer/no decimal. 

int1 <- 3L; int1

int2 <- c(5L, 29L); int2
class(int2)

int3 <- c(int1, int2); int3
typeof(int3); class(int3)

# Character/string/text vector. 

dart <- c("Dartmouth", "rules"); dart
typeof(dart)
class(dart)

# Logical vector. TRUE/FALSE.
# Understanding these is very important to data transformation. 

logic1 <- TRUE
logic2 <- c(FALSE, FALSE, TRUE, TRUE, FALSE)
logic3 <- c(logic1, logic2)
logic3
class(logic3)
typeof(logic3)

# Logical operators. (When the end results in a TRUE/FALSE vector)
# You can use rules with comparison/logical operators to your advantage.

numbers2
numbers2 > 3
numbers2 == 3

##  Factors. 
# Factors are a combination of integers and character strings, in a sense. 
# They exist for categorical variables. 
# They have integer values. They have labels. 
# Note: they have predetermined acceptable levels.
# If you do not set the predefined levels, all unique values will become levels.

# letters is a vector of the English alphabet. 

letters
LETTERS

letterz <- sample(letters, 100, replace = TRUE)
letterz

letfact <- factor(letterz)
letfact # Note the lack of quotations. No longer a string variable. 

# We can check the levels of the factor with 'levels' or with 'attributes'

levels(letfact)
attributes(letfact)

class(letfact) # You see and work with it as a 'factor' with a label.
typeof(letfact) # R stores it as an integer in the memory.

# If we instead define the set of acceptable levels, the variable changes. 

letterz
letfact2 <- factor(letterz, levels = c("a", "b", "c", "d"))
letfact2

# If we want an ordered factor, add the ordered = TRUE argument.
# When you print an ordered factor, you can see the levels and their order. 

letfact3 <- factor(letterz,levels = c("a", "b", "e", "d", "c"), ordered = TRUE)
letfact3

letfact3

# Depending on the earlier sample function, one will be true, the other false. 

letfact[8]
letfact[12]

letfact3[8] > letfact3[12] 
letfact3[8] < letfact3[12] 

summary(letfact3)
table(letfact3)

## COERCION. VERY important to understand.##  

# When two objects of different classes are combined in a vector, 
# one is 'coerced' into the class of the other. 

# Best way to figure out the rules? Two-way competitions.
# Rock-paper-scissors style. 
numbers 
int3

vect1 <- c(numbers, int3); class(vect1) # Numerics beat integers. 
vect1 # Can't really 'see' the difference, but it's there. 

vect2 <- c(numbers, dart); class(vect2) # Character/strings beat numerics. 
vect2

vect3 <- c(int3, dart); class(vect3) # Character/string beats integers.
vect3

logic3
vect4 <- c(logic3, numbers); class(vect4) # INTERESTING! Numeric beats logicals.
vect4

vect5 <- c(dart, logic3); class(vect5) # Character beats logicals. 
vect5

vect6 <- c(dart, letfact); class(vect6) # Character beats factors. 
vect6

vect7 <- c(numbers, letfact); class(vect7) # numeric beats factors. 
vect7

vect8 <- c(int3, letfact); class(vect8) # integer beats factors. 
vect8

vect9 <- c(logic3, letfact); class(vect9) # INTEGER wins!!!! What???
vect9

# Just so we are clear what just happened. 

logic3
letfact

# Lesson: character will coerce ANYTHING. And integers often linger beneath. 

####################################################################
##### Matrices. 


1:9

mat1 <- matrix(1:9, nrow = 3, byrow = FALSE); mat1

# Matrices have two dimensions. Row and column. 
# Matrices are defined by row x column and whether you fill by row or column. 

dim(mat1)

# They cannot take different types of data or classes of objects. 
# They CAN BE different types of objects, as long as each element is the same.

mat2 <- matrix(letters, ncol = 2, byrow = TRUE)
mat3 <- matrix(letters, ncol = 2, byrow = FALSE)
mat2

####################################################################
##### Data Frames. 

# Let's call a dataset already in base R. 
data("mtcars") # Use the 'data' function to call native R data sets.

# R has many base datasets to practice with. I encourage you to use them.

# We can look at the data with 'head' or 'glimpse' or 'str' 

# Recall class and typeof can occasionally be different. 

class(mtcars)
typeof(mtcars)

head(mtcars)
tail(mtcars)
str(mtcars)
glimpse(mtcars) #str(mtcars) # stands for 'structure'

# Use the double colon to specify exactly what package a function is coming from.
# This is most helpful when two packages have functions with the same name.
# When this happens, one package function overtakes the other. "Masking."

# R has many base data sets to practice with. I encourage you to use them.

# Let's work with mtcars. 

head(mtcars)

# First, let's work through some base R subsetting of a data frame. 

# Using hard brackets, we can subset by row or column, as we see fit. 

mtcars[3,] # row by column. Thus, row on the left of comma, column on the right. 

mtcars[3,6]
mtcars["Toyota Corolla",]

mtcars[4,c(3:7)]

mtcars$wt
wt
# Data frames can take row and column names as identifiers. 

head(mtcars)
dim(mtcars)

mtcars[4,] # Extracts the fourth row. 
mtcars[, 4] # Extracts the fourth column's values
mtcars[3, 7] # The quarter-mile time for the Datsun 710. 

mtcars[,"disp"]
mtcars["Datsun 710",]
mtcars["Datsun", 3]

mtcars$disp[7]

rownames(mtcars)
colnames(mtcars)

#######################################################################
# Lists. 
# Lists have length, but do not have dimension. 
# Lists can take many different types and classes of objects. 

objects()

list1 <- list(mtcars, dart, apple, banana, vect5, mat1)
str(list1)

length(list1)
dim(list1) # returns NULL. 

# What happens if we just print it?

list1

list1[1] # points to the list element. 
list1[[1]] # gets me inside the list element. 

list1[[1]]$mpg[4]


list1[[2]][2] <- "is the best"
list1

dart[1] <- "dart" # recoding. 

list1[[1]][3,4]


########################################################################