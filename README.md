# How the script works?
This scripts needs to be executed from a directory where also exists the
directory "UCI HAR Dataset" containing all the data from:
 * https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Once executed, will load all the files, do the following steps:
 1. Merges the training and the test sets to create one data set.
 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
 3. Uses descriptive activity names to name the activities in the data set
 4. Appropriately labels the data set with descriptive variable names. 
 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

And will print some debugging information in the output.

As a final step, generates a file named "tidy_data.txt" containing the data from the step 5.

# Code book
The variables in the tidy_data.txt file are:
 * subject_id   : the identifier of the subject (number between 1 and 30)
 * activity_desc: the activity that subject were doing when measured (one of the activity labels mentioned in the "activity_labels.txt" file, in the data set)
 * measure      : the measurement of a mean or std of a signal (name of the signal indicating the axis, if is a mean or a std)
 * mean(value)  : the mean of all the values obtained for the measure (normalized between -1 and 1)
