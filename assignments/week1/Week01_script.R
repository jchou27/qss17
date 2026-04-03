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
# a-d: creating objects
Harry <- 50; Harry
Hermione <- 47; Hermione
Ron <- 44; Ron
Ginny <- 40; Ginny

# e: prove (Harry + Ginny) !> (Ron + Hermione) using logic operator
# Result shld be a logical Vector (TRUE/FALSE)
Harry + Ginny > Ron + Hermione

# f: Create another object
Snape <- 49; Snape

# g: Create an object that is the inverse of Harry
Voldemort <- 1 / Harry; Voldemort

# h: Prove Harry and Voldemort are inverse of each other
# Answer shld be 1
Voldemort * Harry

## Q1-2: Calculations
# Note: Order of operations is key
# a-h
7546 + 9918
3467 - 8493
37 * 47 + 30
(3 + 67) * (8 - 29)
656 + 23 / 53
74 ^ 2
999 %% 77 # Modulo

## Q1-3: (Atomic) Vectors
# a-c: Creating 2 vectors wizards1 and wizards2, then create longer vector with
# wizards 2 at the end of wizards2 
# Think of c() as concate or combine elements/objects etc.
wizards1 = c(Harry, Hermione); wizards1
wizards2 = c(Ginny, Ron); wizards2
wizards = c(wizards1, wizards2); wizards

# d: attach wizard name to rating
names(wizards) <- c("Harry", "Hermione", "Ginny", "Ron"); names(wizards)

# e-f: remove Snape and Voldemort, make sure they are gone by printing error msg
remove(Snape, Voldemort)
print(Snape)
print(Voldemort)

# g-i: Extract values
# Use brackets
wizards["Ginny"]
wizards[c("Hermione", "Ron")] # Have to use a vector c() to extract multiple values
wizards[2:4] # Colon to specify range

# j: Use logical operator to show whose scores are < 45
# Results shld be series of non-numbers
wizards < 45

## Q1-4: Matrices
# a: Create vector named scores
scores <- c(75, 49, 68, 83, 97, 91, 98, 89, 91); scores 

# b: change to matrix, specify 3 row and col, label wiz_scores
wiz_scores <- matrix(scores, nrow = 3, ncol = 3, byrow = TRUE); wiz_scores

# c: Label rows with names, col with test1 ... test3, row shld start with Ron
rownames(wiz_scores) <- c("Ron", "Harry", "Hermione"); rownames(wiz_scores)
colnames(wiz_scores) <- c("test1", "test2", "test3"); colnames(wiz_scores)
wiz_scores

# d: make new matrix wiz_scores2, use wiz_scores + add a col of avg scores
wiz_scores2 <- cbind(wiz_scores, rowMeans(wiz_scores)); wiz_scores2 # mean avg
colnames(wiz_scores2)[4] <- "avg"; colnames(wiz_scores2) # col label for avg
wiz_scores2

# e: Create new matrix otherwiz and add Neville and Ginny score, include avg
otherwiz <- c(81, 80, 78, 92, 87, 84); otherwiz # first create vector
otherwiz <- matrix(otherwiz, nrow = 2, ncol = 3, byrow = TRUE); otherwiz # transform to matrix
otherwiz <- cbind(otherwiz, rowMeans(otherwiz)); otherwiz # calc avg
rownames(otherwiz) <- c("Neville", "Ginny"); rownames(otherwiz) # naming row
colnames(otherwiz) <- colnames(wiz_scores2); colnames(otherwiz) # naming col
otherwiz

# f: bind otherwiz and wiz_scores2 using rbind, label all_wiz_scores
all_wiz_scores <- rbind(wiz_scores2, otherwiz); all_wiz_scores

# g: Extract Hermione's 2nd and 3rd scores using matrix subsetting operator
all_wiz_scores["Hermione", c("test2", "test3")]
# alternatively, all_wiz_scores[3, 2:3])

# h: create allwiz_sub and delete test 2 from matrix, recalc avg and replace avg col with newavg
allwiz_sub <- subset(all_wiz_scores, select = -test2); allwiz_sub # alternatively, select = -2
allwiz_sub <- subset(allwiz_sub, select = -avg); allwiz_sub # alternatively, select =-3
allwiz_sub <- cbind(allwiz_sub, rowMeans(allwiz_sub)); allwiz_sub
colnames(allwiz_sub)[3] <- "newavg"; colnames(allwiz_sub)
allwiz_sub

# i: Change Neville's test3 to 98, recalc avg, remove old avg col and rename finalavg
allwiz_sub["Neville", "test3"] <- 98; allwiz_sub # alternatively, allwiz_sub[4, 2]
allwiz_sub[ , "newavg"] <- rowMeans(subset(allwiz_sub, select = c("test1", "test3"))); allwiz_sub
colnames(allwiz_sub)[3] <- "finalavg"; colnames(allwiz_sub)
allwiz_sub

## Factors, Data Frames, and Lists

## Q2-1: Characters and Factors
# a-b: Create obj label truth and takes a string value, check class
truth <- "Dartmouth is, like, way better than all the other schools. Like, it’s not even close, you guys."
truth; class(truth)

# c: Create vector called colors
colors <- c("red", "blue", "green", "red", "blue"); colors

# d: Create factor vector called factor_colors from colors vector
factor_colors <- factor(colors); factor_colors
table(factor_colors)
levels(factor_colors)

# e: Create factor2_colors and set arg levels to red and blue
factor2_colors <- factor(colors, levels = c("red", "blue")); factor2_colors
table(factor2_colors)
levels(factor2_colors)
# comparing the two vectors, we can see that the element green is substituted with NA
# the levels argument within factors defines the allowed categorical values to be included in the analysis
# if levels is not specified, R auto assigns levels based on unique values present in the input vector
# it can also be used for custom sorting of categorical values

# f: Report summaries of colors, factor_colors, and factor2_colors using summary function
summary(colors)
summary(factor_colors)
summary(factor2_colors)

# g: Create vector called ideology that take 10 values
ideology <- c("liberal", "conservative", "very liberal", "very conservative", "middle of the road", 
              "slightly conservative","slightly liberal", "liberal", "conservative", "middle of the road")
ideology

# h: Create factor called fact_ideo and order levels
fact_ideo <- factor(ideology, levels = c("very liberal", "liberal", "slightly liberal", "middle of the road", 
                                         "slightly conservative", "conservative", "very conservative"), ordered = TRUE)
fact_ideo
table(fact_ideo)
levels(fact_ideo)

# i: Create char vector labeled respondents taking in 10 value
respondents <- c("Susie", "Abdul", "Maria", "Fred", "Wilma", "Barney", "Dino", "Ajax", "Thor", "Betty"); respondents

## Q2-2 Data Frames
# a: Create vector called income that take in numerical val
income <- c(100000, 75000, 48000, 62000, 31000, 52500, 274000, 88000, 21000, 74000); income

# b: Create data frame called data1 from respondents, ideology, and income
data1 <- data.frame(respondents, ideology, income); data1

# c: show head of data1
head(data1, n = 3 )

# d: show tail of data1
tail(data1, n = 3)

# e: show structure of data1
str(data1)

# f: Order observations in dataset by income in desc, make new copy named orderdat
orderdat <- data1[order(data1$income, decreasing = TRUE), ]; orderdat # space at the end to return all columns

data1 # Show original has not changed

# g: extract data1 with lowest income, subset/iso entire row, pull and print
data1[which.min(data1$income), ] # which.min returns index of 1st occurrence of min value

# h: Select data1 the names of all respondents starting with Fred and ending with Ajax
data1$respondents[4:8]

# i: Add new var called log_income to data1, which take natural log of income var to find large outlier
data1$log_income <- log(data1$income); data1

## Q2-3: Lists
# a: Take ideology, respondents, and income var, put them into list obj called survey
survey <- list(ideology, respondents, income); survey

#b: Create an obj session that take value 2
session <- 2

# c: Create an object weeks that is a 3x3 matrix num 1-9
weeks <- matrix(1:9, nrow = 3, ncol = 3, byrow = TRUE); weeks

# d: Create dv_list that takes truth, session, weeks, data1, survey and rename
dv_list <- list(truth, session, weeks, data1, survey); dv_list
names(dv_list) <- c("truth", "sess1", "wk", "dat", "svy"); names(dv_list)

# e: Extract middle element from the weeks matrix from dv_list
dv_list$wk[2, 2] # Or dv_list[["wk"]][2, 2]


# f: Change income var in data1 from within dv_list. Divide income by 2.
dv_list$dat["income"] <- dv_list$dat["income"] / 2
dv_list$dat