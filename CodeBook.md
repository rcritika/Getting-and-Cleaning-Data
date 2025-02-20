# Introduction

The raw data used in this cookbook are available at the following address: http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

To get a description of the study, please visit the URL: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# Transformations to clean the data

* The following files of the train data set have been cbind in this order:
  * subject_train
  * Y_train
  * X_train

* The following files of the test data set have been cbind in this order:
  * subject_test
  * Y_test
  * X_test

* The 2 resulting data frames have been rbind
* Only the columns for the means and the standard deviations have been kept
* the columns have been labeled where 
  t replaced with time
  f replaced with frequency
  Acc replaced with Accelerometer
  Gyro replaced with Gyroscope
  Mag replaced with Magnitude
  BodyBody replaced with Body

# The script run_analysis.R

* downloads the data from UCI Machine Learning Repository
* merges the training and test sets to create one data set
* replaces activity values in the dataset with descriptive activity names
* extracts only the measurements (features) on the mean and standard deviation for   each measurement
* appropriately labels the columns with descriptive names
* creates a second, independent tidy dataset with an average of each variable for   each each activity and each subject. In other words, same type of measurements  * for a particular subject and activity are averaged into one value and the tidy    data set contains these mean values only. The processed tidy data set is also     exported as csv file.
  
# run_analysis.R

The script is parititioned into several levels such that it performs one by one 
each of the steps described above. To run whole cleaning procedure, run the script. The script also assumes that plyr library is already installed.

# The original data set

The original data set is split into training and test sets (70% and 30%, respectively) where each partition is also split into three files that contain

* measurements from the accelerometer and gyroscope
* activity label
* identifier of the subject

# Getting and cleaning data

If the data is not already available in the data directory, it is downloaded from UCI repository.

The first step of the preprocessing is to merge the training and test sets. Two sets combined, there are 10,299 instances where each instance contains 561 features (560 measurements and subject identifier). After the merge operation the resulting data, the table contains 562 columns (560 measurements, subject identifier and activity label).

After the merge operation, mean and standard deviation features are extracted for further processing. Out of 560 measurement features, 33 mean and 33 standard deviations features are extracted, yielding a data frame with 68 features (additional two features are subject identifier and activity label).

Next, the activity labels are replaced with descriptive activity names, defined in activity_labels.txt in the original data folder.

The final step creates a tidy data set with the average of each variable for each activity and each subject. 10299 instances are split into 180 groups (30 subjects and 6 activities) and 66 mean and standard deviation features are averaged for each group. The resulting data table has 180 rows and 66 columns. The tidy data set is exported to UCI_HAR_tidy.csv where the first row is the header containing the names for each column.
