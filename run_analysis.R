library(dplyr)

### OBJECTIVE

# The submitted data set is tidy.
# The Github repo contains the required scripts.
# GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.
# The README that explains the analysis files is clear and understandable.
# The work submitted for this project is the work of the student who submitted it.

## SEE HOW TO USE GITHUB
# Make a different repo?
# Only push the projects?

# info on the data
"http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones"


### OBJECTIVE

## create one R script called run_analysis.R that does the following
# 1 Merges the training and the test sets to create one data set.
# 2 Extracts only the measurements on the mean and standard deviation for each measurement.
# 3 Uses descriptive activity names to name the activities in the data set
# 4 Appropriately labels the data set with descriptive variable names.
# 5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### STEP 1 - Merge

# load and check train set, labels and subjects
train_set <- 
        read.table("./data/week4_dataset/train/X_train.txt") 
head(train_set, 1)

train_labels <- 
        read.table("./data/week4_dataset/train/y_train.txt")
head(train_labels)

train_subject <- 
        read.table("./data/week4_dataset/train/subject_train.txt")
head(train_subject)

# load and check test set, labels and subjects
test_set <- 
        read.table("./data/week4_dataset/test/X_test.txt") 
head(test_set, 1)

test_labels <- 
        read.table("./data/week4_dataset/test/y_test.txt")
head(test_labels)

test_subject <- 
        read.table("./data/week4_dataset/test/subject_test.txt")
head(test_subject)

# Manage feature (these are the variables names)
features_name <- 
        read.table("./data/week4_dataset/features.txt", header = F)
head(features_name)
View(features_name)

# assign variable names to df
colnames(train_set)  <- features_name[,2]
View(train_set) # train set

colnames(test_set)  <- features_name[,2]
View(test_set) # test set

colnames(train_labels) <- c("activity") # a better name would be "activity"!!!
colnames(test_labels) <- c("activity")

colnames(train_subject) <- c("subject")
colnames(test_subject) <- c("subject")

# add label coloumn
train_complete <- cbind(train_labels, train_subject, train_set)
test_complete <- cbind(test_labels, test_subject, test_set)

# add train and test column
ID <- "train"
train <- cbind(ID, train_complete)
View(train)

ID <- "test"
test <- cbind(ID, test_complete)
View(test)

# merge (bind?) train and test
complete_df <- rbind(train, test)
View(complete_df)

# select coloumn with mean and sd

Mean_df <- complete_df %>%
        select(matches("mean"))
# this gives an error, 
# checking the "features" file, some coloumn have the same name

# check if they have different valure or are replicates
samename_df <- complete_df[,c(304, 318, 332)]
View(samename_df) 
# they are different

colnames(complete_df) <- make.names(colnames(complete_df), unique = TRUE)
colnames(complete_df)
# names changed, some "()" substituted with ".."

# Same line as before to esxtract the mean coloumns
Mean_df <- complete_df %>%
        select(matches("mean"))
View(Mean_df)

# same with std
std_df <- complete_df %>%
        select(matches("std"))
View(std_df)

# report useful coloumn
id_activity <- complete_df %>%
        select(activity, ID, subject)
View(id_activity)

# bind the 3 df to get what we want
selected_df <- cbind(id_activity, Mean_df, std_df)
View(selected_df)

### Substitute the activity number with the name

# load activity table
activity_df <- 
        read.table("./data/week4_dataset/activity_labels.txt")
View(activity_df)

# name activity table
colnames(activity_df) <- c("activity", "activity_name")

merge_test <- merge(activity_df, selected_df, by = "activity")
# Merge by the number of the activity create a coloumn with the name
colnames(merge_test)
View(merge_test)

tidy_df <- merge_test[,-c(2, 3)] %>%
        group_by(subject, activity) %>%
        summarise_all(funs(mean))
View(tidy_df)
