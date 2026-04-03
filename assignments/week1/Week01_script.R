## Data Visualization (GOVT16-QSS17) Spring 2026
## Intro to R, Part 1 & 2
##
## Name: Jack Chou
## Date: April 2, 2026

## Assignment Notes:
# Write comments
# Use TRUE/FALSE as synonyms, not T/F
# When creating object, print object after creation
# Use R documentation for understanding

## Objects, Vectors, and Matrices

## Q1-1: Objects
# a: Create object Harry using the assignment operator <-
# The <- operator assigns the value on the right to the name on the left
Harry <- 50; Harry

# b: Create object Hermione
Hermione <- 47; Hermione

# c: Create object Ron
Ron <- 44; Ron

# d: Create object Ginny
Ginny <- 40; Ginny

# e: Prove (Harry + Ginny) is NOT greater than (Ron + Hermione) using a logical operator
# The > operator returns a single logical value (TRUE or FALSE)
# We expect FALSE, which proves Harry + Ginny is NOT greater
Harry + Ginny > Ron + Hermione

# f: Create another object Snape
Snape <- 49; Snape

# g: Create an object that is the multiplicative inverse (reciprocal) of Harry
# The multiplicative inverse of x is 1/x, so that x * (1/x) = 1
Voldemort <- 1 / Harry; Voldemort

# h: Prove Harry and Voldemort are inverses of each other
# The result should be exactly 1: any number times its reciprocal equals 1
# Note: due to floating point representation, the result may occasionally differ
# by a tiny fraction, but for clean integers like 50 the result is exact
Voldemort * Harry

## Q1-2: Calculations
# Note: order of operations applies
# a: basic addition
7546 + 9918

# b: basic subtraction
3467 - 8493

# c: multiplication takes precedence over addition, so 37*47 is computed first, then +30
37 * 47 + 30

# d: parentheses override default order, so both sums are computed before multiplying
(3 + 67) * (8 - 29)

# e: division takes precedence over addition, so 23/53 is computed first, then +656
656 + 23 / 53

# f: exponentiation with the ^ operator (74 raised to the power of 2)
74 ^ 2

# g: modulo with the %% operator returns the remainder after integer division
# 999 divided by 77 is 12 remainder 75, so 999 %% 77 = 75
# Alternative: use %/% for integer division (quotient only): 999 %/% 77 = 12
999 %% 77

## Q1-3: (Atomic) Vectors
# a: Create wizards1 by combining Harry and Hermione into a vector
# c() stands for "concatenate", collapses multiple elements/objects
# into a single flat, 1D vector
wizards1 <- c(Harry, Hermione); wizards1

# b: Create wizards2 by combining Ginny and Ron
wizards2 <- c(Ginny, Ron); wizards2

# c: Create wizards by combining wizards1 and wizards2 end to end
# c() flattens nested vectors
# Result is still a 1D atomic vector of length 4
wizards <- c(wizards1, wizards2); wizards

# d: Attach a name label to each element using names() assignment
# names() on the left side of <- receives the character vector of labels
names(wizards) <- c("Harry", "Hermione", "Ginny", "Ron"); names(wizards)

# e: Remove Snape from the environment using remove() (synonym: rm())
# remove() permanently deletes named objects from the current environment
remove(Snape, Voldemort)

# f: Confirm deletion by attempting to print the removed objects
# These lines intentionally produce errors: "object 'Snape' not found"
# and "object 'Voldemort' not found"
print(Snape)
print(Voldemort)

# g: Extract Ginny's score by name. Named indexing returns the element with that label
wizards["Ginny"]

# h: Extract Hermione and Ron's scores; supply a character vector to extract multiple
# named elements simultaneously (must wrap names in c())
wizards[c("Hermione", "Ron")]

# i: Extract elements 2 through 4 using a positional range
# The colon operator generates an integer sequence
wizards[2:4]

# j: Use a logical comparison to show which wizards scored below 45
# The < operator applied to a vector produces a logical vector (TRUE/FALSE),
# one element per wizard: TRUE where the score is less than 45, FALSE otherwise
wizards < 45

## Q1-4: Matrices
# a: Create a raw numeric vector called scores to supply matrix data
# c() collects the 9 individual test scores into a 1D vector
scores <- c(75, 49, 68, 83, 97, 91, 98, 89, 91); scores

# b: Reshape scores into a 3x3 matrix called wiz_scores
# byrow = TRUE fills the matrix row by row (left to right, top to bottom)
# Without byrow = TRUE, R defaults to column by column (top to bottom, left to right)
wiz_scores <- matrix(scores, nrow = 3, ncol = 3, byrow = TRUE); wiz_scores

# c: Assign row and column labels to wiz_scores
# rownames() and colnames() on the left side of <- receive the label vectors
rownames(wiz_scores) <- c("Ron", "Harry", "Hermione"); rownames(wiz_scores)
colnames(wiz_scores) <- c("test1", "test2", "test3"); colnames(wiz_scores)
wiz_scores

# d: Build wiz_scores2 by appending an average column to wiz_scores
# cbind() appends columns side by side; rowMeans() computes the mean of each row
# Alternative for rowMeans: apply(wiz_scores, 1, mean), where the 1 means "apply by row"
wiz_scores2 <- cbind(wiz_scores, rowMeans(wiz_scores)); wiz_scores2
colnames(wiz_scores2)[4] <- "avg" # label the new avg column
colnames(wiz_scores2)
wiz_scores2

# e: Create the otherwiz matrix for Neville and Ginny following the same multistep pattern:
#   1) build raw vector, 2) reshape to matrix, 3) append avg column, 4) add labels
# colnames are copied from wiz_scores2 so both matrices share identical column structure
otherwiz <- c(81, 80, 78, 92, 87, 84) # step 1: raw data vector
otherwiz
otherwiz <- matrix(otherwiz, nrow = 2, ncol = 3, byrow = TRUE) # step 2: reshape
otherwiz
otherwiz <- cbind(otherwiz, rowMeans(otherwiz)) # step 3: append avg column
otherwiz
rownames(otherwiz) <- c("Neville", "Ginny") # step 4a: row labels
rownames(otherwiz)
colnames(otherwiz) <- colnames(wiz_scores2) # step 4b: col labels (copied)
colnames(otherwiz)
otherwiz

# f: Stack wiz_scores2 and otherwiz vertically using rbind()
# rbind() requires both matrices to have the same number of columns (and matching names)
all_wiz_scores <- rbind(wiz_scores2, otherwiz); all_wiz_scores

# g: Extract Hermione's 2nd and 3rd test scores using named row/column indexing
# Syntax: matrix[row_name, column_names_vector]
all_wiz_scores["Hermione", c("test2", "test3")]
# Alternative using positional indexing: all_wiz_scores[3, 2:3]

# h: Build allwiz_sub by dropping test2 and avg columns from all_wiz_scores
allwiz_sub <- all_wiz_scores[, !colnames(all_wiz_scores) %in% c("test2", "avg")]; allwiz_sub
allwiz_sub <- cbind(allwiz_sub, rowMeans(allwiz_sub)); allwiz_sub
colnames(allwiz_sub)[3] <- "newavg"; colnames(allwiz_sub)
allwiz_sub

# i: Update Neville's test3 score in place, then recalculate the average column
# Step 1: in place value assignment; bracket indexing on the left of <- overwrites the cell
# Alternative positional: allwiz_sub[4, 2]
allwiz_sub["Neville", "test3"] <- 98; allwiz_sub
# Step 2: newavg must be recalculated AFTER test3 changes. rowMeans on test1 and test3 only
allwiz_sub[, "newavg"] <- rowMeans(allwiz_sub[, c("test1", "test3")]); allwiz_sub
# Step 3: rename the avg column to finalavg, which is just a colnames assignment
colnames(allwiz_sub)[3] <- "finalavg"; colnames(allwiz_sub)
allwiz_sub

## Factors, Data Frames, and Lists

## Q2-1: Characters and Factors
# a: Create a character object called truth containing a string value
# Character objects store text; any value wrapped in quotes is of class "character"
truth <- "Dartmouth is, like, way better than all the other schools. Like, it's not even close, you guys."

# b: Print truth and confirm its class is "character"
truth; class(truth)

# c: Create a character vector called colors
colors <- c("red", "blue", "green", "red", "blue"); colors

# d: Convert the colors character vector into a factor
# factor() auto-generates levels alphabetically from all unique values in the input
# table() returns a frequency count for each level
# levels() shows the ordered set of valid categories
factor_colors <- factor(colors); factor_colors
table(factor_colors)
levels(factor_colors)

# e: Create factor2_colors restricting levels to only "red" and "blue"
# Any value in colors not in the specified levels ("green") is coerced to NA
# This is useful when you need to restrict a factor to a predefined set of valid values
# or impose a custom sort order on categories
factor2_colors <- factor(colors, levels = c("red", "blue")); factor2_colors
table(factor2_colors)
levels(factor2_colors)
# Comparing factor_colors and factor2_colors: "green" becomes NA in factor2_colors
# because it falls outside the explicitly defined levels

# f: Compare summary() behavior on character vs. factor objects
# summary() on a character vector reports length, class, and mode (not very informative)
# summary() on a factor returns a frequency table, which is much more useful for categorical data
summary(colors)
summary(factor_colors)
summary(factor2_colors)

# g: Create a raw character vector called ideology with 10 unordered political values
ideology <- c("liberal", "conservative", "very liberal", "very conservative", "middle of the road",
              "slightly conservative","slightly liberal", "liberal", "conservative", "middle of the road")
ideology

# h: Convert ideology into an ordered factor called fact_ideo
# ordered = TRUE enables magnitude comparisons between levels (e.g., "liberal" < "conservative")
# The levels argument must explicitly list all categories from most liberal to most conservative (left to right = lowest to highest)
fact_ideo <- factor(ideology, levels = c("very liberal", "liberal", "slightly liberal", "middle of the road",
                                         "slightly conservative", "conservative", "very conservative"), ordered = TRUE)
fact_ideo
table(fact_ideo)
levels(fact_ideo)

# i: Create a character vector of respondent names
# This vector will become a column in the data frame built in Q2-2
respondents <- c("Susie", "Abdul", "Maria", "Fred", "Wilma", "Barney", "Dino", "Ajax", "Thor", "Betty"); respondents

## Q2-2 Data Frames
# a: Create a numeric vector called income
# Numeric vectors store double precision floating point values
income <- c(100000, 75000, 48000, 62000, 31000, 52500, 274000, 88000, 21000, 74000); income

# b: Combine respondents, ideology, and income into a data frame called data1
# data.frame() requires all input vectors to have the same length
# Column names default to the names of the input vectors
data1 <- data.frame(respondents, ideology, income); data1

# c: Inspect the first 3 rows of data1 using head()
# head() defaults to 6 rows
head(data1)

# d: Inspect the last 3 rows of data1 using tail()
# tail() mirrors head() but reads from the bottom of the data frame
tail(data1)

# e: Inspect the structure of data1 using str()
# str() reports the class of the object, its dimensions, and the first few values
# of each column along with each column's data type
str(data1)

# f: Create orderdat, a copy of data1 sorted by income in descending order
# order() returns a permutation of row indices that would sort the vector
# Passing that index vector inside [, ] reorders the rows, the trailing comma keeps all columns
# data1 itself is unchanged, orderdat is a new independent copy
orderdat <- data1[order(data1$income, decreasing = TRUE), ]; orderdat
data1 # confirm the original data1 is unchanged

# g: Extract the entire row for the respondent with the lowest income
# which.min() returns the index of the first occurrence of the minimum value
# use this when you need the row, not just the value
# Alternative: data1[data1$income == min(data1$income), ]
data1[which.min(data1$income), ]

# h: Select the respondents column entries for rows 4 through 8 (Fred to Ajax)
# Positional indexing on the $respondents column using a range: [4:8]
data1$respondents[4:8]

# i: Add a log_income column to data1 using the natural logarithm (base e)
# log() in R computes the natural log by default
# Log transforming income compresses right skewed distributions, making large outliers
# easier to compare
data1$log_income <- log(data1$income); data1

## Q2-3: Lists
# a: Combine ideology, respondents, and income into a heterogeneous list called survey
# list() (unlike c()) preserves each element's original class and structure,
# allowing a single container to hold vectors of different types and lengths
survey <- list(ideology, respondents, income); survey

# b: Create an object called session with value 2
session <- 2; session

# c: Create a 3x3 matrix called weeks containing integers 1 through 9
# 1:9 generates the integer sequence c(1, 2, ..., 9), byrow = TRUE fills row first
weeks <- matrix(1:9, nrow = 3, ncol = 3, byrow = TRUE); weeks

# d: Build dv_list from truth, session, weeks, data1, and survey, then rename elements
# names() applied to a list assigns the $ access labels for each element
dv_list <- list(truth, session, weeks, data1, survey); dv_list
names(dv_list) <- c("truth", "sess1", "wk", "dat", "svy"); names(dv_list)

# e: Extract the center element (row 2, col 2) of the weeks matrix stored inside dv_list
# $ accesses the named list element; [2, 2] subsets the matrix within it
# Alternative double bracket syntax: dv_list[["wk"]][2, 2]
dv_list$wk[2, 2]

# f: Halve the income column in the data frame stored inside dv_list
# dv_list$dat refers to the copy of data1 stored in the list at creation time
# Modifying dv_list$dat["income"] does not affect the original data1 object
dv_list$dat["income"] <- dv_list$dat["income"] / 2
dv_list$dat
