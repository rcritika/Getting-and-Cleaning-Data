# This R script gets and performs some cleaning on human activity data, built
# from recordings of subjects performing daily activities while carrying
# smartphone.

#Check if directory already exist and download the zip file
if(!file.exists("./Assignment"))    dir.create("./Assignment")
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, "./Assignment/Dataset.zip")

#unzip the file
unzip("./Assignment/Dataset.zip", exdir = "data")

#Reading test and train data sets
#Test data sets
X_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

#Train data set
X_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

#Feature data set
features <- read.table("./data/UCI HAR Dataset/features.txt")

#Activity_labels data set
activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")

#Assign column names
colnames(X_test) <- features[,2]
colnames(y_test) <- "activity_id"
colnames(subject_test) <- "subject_id"

colnames(X_train) <- features[,2]
colnames(y_train) <- "activity_id"
colnames(subject_train) <- "subject_id"

colnames(activity_labels) <- c("activity_id","activity_type")

#Merge the the training and the test sets to create one data set
mrg_test <- cbind(y_test, subject_test, X_test)
mrg_train <- cbind(y_train, subject_train, X_train)
mrg_all <- rbind(mrg_train, mrg_test)

#Extracts only the measurements on the mean 
#and standard deviation for each measurement
#table(grepl("*mean()",colnames(mrg_all)))
#table(grepl("*std()",colnames(mrg_all)))
column_names <- colnames(mrg_all)
mean_std_column_names <- column_names[grepl("*mean\\(\\)|*std\\(\\)", column_names)]
dataset_mean_std <- mrg_all[,c("activity_id","subject_id",mean_std_column_names)]

#Uses descriptive activity names to name the activities in the data set
dataset_activitylablels <- merge(dataset_mean_std,activity_labels, by = "activity_id")

#Appropriately labels the data set with descriptive variable names
names(dataset_activitylablels) <- gsub("^t", "time", names(dataset_activitylablels))
names(dataset_activitylablels) <- gsub("^f", "frequency", names(dataset_activitylablels))
names(dataset_activitylablels) <- gsub("Acc", "Accelerometer", names(dataset_activitylablels))
names(dataset_activitylablels) <- gsub("Gyro", "Gyroscope", names(dataset_activitylablels))
names(dataset_activitylablels) <- gsub("Mag", "Magnitude", names(dataset_activitylablels))
names(dataset_activitylablels) <- gsub("BodyBody", "Body", names(dataset_activitylablels))

#From the data set in step 4, creates a second, independent tidy
#data set with the average of each variable for each activity and each subject
tidy_dataset <- dataset_activitylablels[order(dataset_activitylablels$subject_id,
                                              dataset_activitylablels$activity_id),]
write.table(tidy_dataset,"tidydata.txt", row.names = FALSE)