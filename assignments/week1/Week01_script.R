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
## Q1: Objects
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

## Q2: Calculations
# Note: Order of operations is key
# a-h
7546 + 9918
3467 - 8493
37 * 47 + 30
(3 + 67) * (8 - 29)
656 + 23 / 53
74 ^ 2
999 %% 77 # Modulo

## Q3: (Atomic) Vectors
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

## Q4: Matrices
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
print(all_wiz_scores["Hermione", c("test2", "test3")])
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
