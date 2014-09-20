# What this script does?
#  1. Merges the training and the test sets to create one data set.
#  2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#  3. Uses descriptive activity names to name the activities in the data set
#  4. Appropriately labels the data set with descriptive variable names. 
#  5. From the data set in step 4, creates a second, independent tidy data set with 
#     the average of each variable for each activity and each subject.

library(dplyr)


# Returns a list with the following elements:
# - sid
# - x
# - y
# - ...
# Each one is a dataframe with the same length, containing part of the information
# for the data in test (or train)
loadDir <- function(kind="test") {
  result <- list()
  result$sid <- read.table(file = sprintf("UCI HAR Dataset/%s/subject_%s.txt", kind,kind), header=F)
  result$x   <- read.table(file = sprintf("UCI HAR Dataset/%s/X_%s.txt", kind,kind), header=F)
  result$y   <- read.table(file = sprintf("UCI HAR Dataset/%s/y_%s.txt", kind,kind), header=F)

  result$bodyAccX <- read.table(file = sprintf("UCI HAR Dataset/%s/Inertial Signals/body_acc_x_%s.txt", kind,kind), header=F)
  result$bodyAccY <- read.table(file = sprintf("UCI HAR Dataset/%s/Inertial Signals/body_acc_y_%s.txt", kind,kind), header=F)
  result$bodyAccZ <- read.table(file = sprintf("UCI HAR Dataset/%s/Inertial Signals/body_acc_z_%s.txt", kind,kind), header=F)

  result$bodyGyroX <- read.table(file = sprintf("UCI HAR Dataset/%s/Inertial Signals/body_gyro_x_%s.txt", kind,kind), header=F)
  result$bodyGyroY <- read.table(file = sprintf("UCI HAR Dataset/%s/Inertial Signals/body_gyro_y_%s.txt", kind,kind), header=F)
  result$bodyGyroZ <- read.table(file = sprintf("UCI HAR Dataset/%s/Inertial Signals/body_gyro_z_%s.txt", kind,kind), header=F)

  result$totalAccX <- read.table(file = sprintf("UCI HAR Dataset/%s/Inertial Signals/total_acc_x_%s.txt", kind,kind), header=F)
  result$totalAccY <- read.table(file = sprintf("UCI HAR Dataset/%s/Inertial Signals/total_acc_y_%s.txt", kind,kind), header=F)
  result$totalAccZ <- read.table(file = sprintf("UCI HAR Dataset/%s/Inertial Signals/total_acc_z_%s.txt", kind,kind), header=F)
  
  result
}

# The ds consists in:
#  - subject id file column
#  - x file columns
#  - y file columns
#  - inertial signals files columns
# So, the first part is to combine all the columns in a single data frame.

####################
# Load the test data
test <- loadDir("test")
test.df <- tbl_df( data.frame(test) )
rm(test)
str(test.df)

# Load the train data
train <- loadDir("train")
train.df <- tbl_df( data.frame(train) )
rm(train)
str(train.df)


# Join everything in a big DF
full.df  <- union(test.df, train.df)
# Rename the "V1.1" col to "activity_id"
full.df <- full.df %>%
  mutate(activity_id=V1.1) %>%
  select(-V1.1)

rm(train.df)
rm(test.df)
####################

####################
# Append activity data
appendActivity <- function(df = tbl_df(data.frame())) {
  activity.labels <- read.table(file="UCI HAR Dataset/activity_labels.txt", header=F)
  names(activity.labels)[1] <- "activity_id"
  names(activity.labels)[2] <- "activity_desc"
  # activity.labels$activity_id <- as.character(activity.labels$activity_id)

  inner_join(x=df, y=activity.labels, by = "activity_id")
}

full.df  <- appendActivity(df=full.df)
####################

####################
# Rename the columns from the X files with a more descriptive name


# Load the descriptive information
features <- read.table(file="UCI HAR Dataset/features.txt", header=F)

# The columns are 2:562 because are 561 columns from the X file
# appended after the subject id column
names(full.df)[2:562] <- as.character(features$V2)
####################


####################
# Extracts only the measurements on the mean and standard deviation for each measurement. 
library(stringr)

# Select only:
#  - the column V1 (subject_id)
#  - the columns containing "mean(" or "std("
#  - the activity_id
#  - the activity_desc
full.df <- full.df %>%
  select(subject_id=V1, activity_id, activity_desc, matches("(mean\\(|std\\()"))
####################


####################
# Create the tidy data for upload

library(tidyr)
# this df will contain the columns:
#  - subject_id
#  - activity_desc
#  - measures (tBodyAcc-mean()-X, tBodyAcc-mean()-Y, tBodyAcc-mean()-Z, etc)
# Notes:
#  - dropped activity_id col
#  - each measure column contains the mean of all the values in that column for the
#    subject on the activity
tidy.df <- full.df %>% 
  select(-activity_id) %>%
  group_by(subject_id, activity_desc) %>%
  summarise_each(funs(mean))
####################

####################
# Generate output
write.table(x = tidy.df, row.names = F, file = "tidy_data.txt")
####################