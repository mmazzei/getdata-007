# How the script works?
This scripts needs to be executed from a directory where also exists the
directory "UCI HAR Dataset" containing all the data from:
 * https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Once executed, will load all the files, do the following steps:
 1. Merges the training and the test sets to create one data set.
 2. Extracts only the measurements on the mean and standard deviation for each measurement. At this point, all the columns with names containing `mean()` or `std()` are considered (for example: `tGravityAcc-mean()-X`, `tBodyAccJerkMag-std()`).
 3. Uses descriptive activity names to name the activities in the data set
 4. Appropriately labels the data set with descriptive variable names. 
 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

And will print some debugging information in the output.

As a final step, generates a file named `tidy_data.txt` containing the data from the step 5.

This file is tidy data because contains one variable per column and one observation in each row.

The files provided in this repository are:
 * `run_analysis.R`: is the script that produces the `tidy_data.txt`
 * `tidy_data.txt` : is a file containing the output from the step (5) mentioned before.
 * `CodeBook.md`   : contains the codebook for the `tidy_data.txt` file.
