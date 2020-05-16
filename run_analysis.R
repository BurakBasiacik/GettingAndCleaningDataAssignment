####Merges the training and the test sets to create one data set

##load required libraries
library(dplyr)
library(reshape2)

##Download and Unzip Files

if(!file.exists("./data")){dir.create("./data")}
ZipUrl<- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(ZipUrl, destfile= "./data/dataset.zip")

foldername<-"data/UCI HAR Dataset"
if(!file.exists(foldername)) {
      unzip("./data/dataset.zip" , exdir= "./data")
}


##Read features and activity labels
features<- read.table(file.path(foldername, "features.txt"), 
                      col.names= c("index", "functions"))
activity_labels<- read.table(file.path(foldername, "activity_labels.txt"),
                              col.names= c("activity","Label"))


##Read training and test data
x_training<- read.table(file.path(foldername, "train", "X_train.txt"), 
                        col.names= features$functions)
y_training<- read.table(file.path(foldername, "train", "y_train.txt"),
                        col.names= "activity")
subject_training<- read.table(file.path(foldername, "train", "subject_train.txt"),
                              col.names= "subject")

x_test<- read.table(file.path(foldername, "test", "X_test.txt"),
                     col.names= features$functions)
y_test<- read.table(file.path(foldername, "test", "y_test.txt"),
                     col.names= "activity")
subject_test<- read.table(file.path(foldername, "test", "subject_test.txt"),
                           col.names="subject")

##Merge the datasets

training_data<- cbind(subject_training,y_training,x_training)
testing_data<- cbind(subject_test,y_test,x_test)
merged<- rbind(training_data,testing_data)

####Extract only the measurements on the mean and standard deviation for each measurement

merged_clean<- merged[,grepl("subject|activity|mean|std",colnames(merged))]

#####Use descriptive activity names to name the activities in the data set

merged_clean$activity<- activity_labels[merged_clean$activity,2]

#####Appropriately label the data set with descriptive variable names.

##Remove characters
names(merged_clean) <- gsub("\\()", "", names(merged_clean))

##Replace abbrevations with full names and use capitals
names(merged_clean)<- gsub("Acc", "Accelerometer", names(merged_clean))
names(merged_clean)<- gsub("angle", "Angle", names(merged_clean))
names(merged_clean)<- gsub("BodyBody", "Body", names(merged_clean))
names(merged_clean)<- gsub("freq", "Frequency", names(merged_clean))
names(merged_clean)<- gsub("gravity", "Gravity", names(merged_clean))
names(merged_clean)<- gsub("Gyro", "Gyroscope", names(merged_clean))
names(merged_clean)<- gsub("Mag", "Magnitude", names(merged_clean))
names(merged_clean)<- gsub("mean", "Mean", names(merged_clean))
names(merged_clean)<- gsub("std", "StandardDeviation", names(merged_clean))
names(merged_clean)<- gsub("tBody", "TimeBody", names(merged_clean))
names(merged_clean)<- gsub("^t", "Time", names(merged_clean))
names(merged_clean)<- gsub("^f", "Frequency", names(merged_clean))

names(merged_clean)<- gsub("Subject", "subject", names(merged_clean))
names(merged_clean)<- gsub("Activity", "activity", names(merged_clean))

####create a second, independent tidy data set with the average of each variable for each activity and each subject

##summarize the table by subject and activity

summarized_data<- merged_clean %>% group_by(subject, activity) %>%
      summarise_all(funs(mean))

##Unpivot summarized data to create tidy data

tidy_data<- melt(data= summarized_data, id= c("subject","activity"))

##Capitalize tidy_data column names

colnames(tidy_data)<- c("Subject","Activity","Variable","AverageValue")

##Write the dataset to a file

write.table(tidy_data, "TidyData.txt", row.name=FALSE)
