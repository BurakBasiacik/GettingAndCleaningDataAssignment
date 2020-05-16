# Getting And Cleaning Data Peer Graded Assignment
This is the submission for the Coursera's Data Science Specialization - Getting and Cleaning Data Peer Graded Assignment.

## Introduction

The purpose of this project is to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

Original dataset is downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Explanation about the data set: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

RStudio with R version 3.5.1 is used to complete this assignment.

## Contents of the Repository
1. ReadMe
2. Code Book
3. run_analysis.R
4. Tidy data set created by run_analysis.R

## run_analysis.R

The script downloads the UCI HAR Dataset, unzips the contents of dataset in the working directory and then does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
