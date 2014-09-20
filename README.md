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

In order to do that, load all the files from the train and test folders inside two lists (test and train), where each list element correspond to data from a file:
 * `test$sid` = data from the `subject_test.txt` file
 * `test$x` = data from the `X_test.txt` file
 * `test$y` = data from the `y_test.txt` file
 * etc

Then two dataframes are built from that lists (test.df and train.df) whose columns are the addition of all the columns from all the elements of the lists:
 * `test.df[,1]` = `test$sid` only column
 * `test.df[,2:562]` = `test$x` 561 columns
 * `test.df[,563]` = `test$y` only column
 * etc

And then both dataframes are mixed in a single one (union operation) to obtain the full.df.

At this point, the column names are unreadable, only know what each column means because the index of the column, but because in a further step will delete some columns, only rename a single one: "V1.1" (the 563th column) to `activity_id`, in order to simplify the merge process when load the description of the activity.

From the file `activity_labels.txt` the description corresponding to each `activity_id` is loaded and is appended to the full.df.

From the file `features.txt` the names of the 561 columns between 2 and 562 are loaded and these columns from full.df are renamed.

Then remove all the columns except:
 * `subject_id` (the first one)
 * `activity_id`
 * `activity_desc`
 * the ones whose name contains `mean()` or `std()` (there are only 66)

And, as a final step, generate tidy data with the mean of each one of the 66 rows of measures grouped by `subject_id` and `activity_desc` (the `activity_id` column is dropped). And, with that data, a file named `tidy_data.txt` is generated.

This file is tidy data because contains one variable per column and one observation in each row.

The files provided in this repository are:
 * `run_analysis.R`: is the script that produces the `tidy_data.txt`
 * `tidy_data.txt` : is a file containing the output from the step (5) mentioned before.
 * `CodeBook.md`   : contains the codebook for the `tidy_data.txt` file.
