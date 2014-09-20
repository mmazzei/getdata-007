# How the script works?
This scripts needs to be executed from a directory where also exists the
directory "UCI HAR Dataset" containing all the data from:
 * https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Once executed, will load all the files, do the following steps:
 1. Merges the training and the test sets to create one data set.
 2. Extracts only the measurements on the mean and standard deviation for each measurement. At this point, all the columns with names containing 'mean()' or 'std()' are considered (for example: 'tGravityAcc-mean()-X', 'tBodyAccJerkMag-std()').
 3. Uses descriptive activity names to name the activities in the data set
 4. Appropriately labels the data set with descriptive variable names. 
 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

And will print some debugging information in the output.

As a final step, generates a file named "tidy_data.txt" containing the data from the step 5.

This file is tidy data because contains one variable per column and one observation in each row.

# Code book
The variables in the tidy_data.txt file are:
 * *subject_id*   : (integer) the identifier of the subject (number between 1 and 30)
 * *activity_desc*: (character) the activity that subject were doing when measured (one of the activity labels mentioned in the "activity_labels.txt" file, in the data set)
 * *measures*     : (numeric) there are 66 columns, one for each measure of mean or std of a measurement (the measurements list is located in "features_info.txt" file, in the data set). The value in each column is the mean of all the values for the given measure, for the subject in the activity.
