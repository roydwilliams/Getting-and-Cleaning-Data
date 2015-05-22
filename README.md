# Getting-and-Cleaning-Data

## Files contained within this repo:  
README.md  
CodeBook.md  
tidydata.txt  
run_analysis.R  

### CodeBook.md
This document describes the process for accessing the data, cleaning the data and creating a tidy data set

### tidydata.txt
This document is the output document from the R code satisfying the ultimate goal of this project

### run-analysis.R
This document captures the R code developed to perform this project.  It is designed to automatically access the data from the internet, create the appropriate sub-directory for storing this data on your local machine and download the data files into that sub-directory.  It steps thru the 5 required steps of the project:  

1) Merges the training and the test sets to create one data set.  
2) Extracts only the measurements on the mean and standard deviation for each measurement.  
3) Uses descriptive activity names to name the activities in the data set  
4) Appropriately labels the data set with descriptive variable names.  
5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Execution of project steps using R code captured in run_analysis.R
The R script for cleaning and tidying the data consists of 7 parts.  

Part 1 ==>> Access, download and unzip data files  
This part consists of 3 steps:  
Step 1 - Download the zipped file and put it in the "data" folder using download.file - create "data" folder if it doesn't already exist  
Step 2 - Unzip the file using unzip function and store files in "data" folder 
Step 3 - Get the list of the data files using list.files for "./data/UCI HAR Dataset" and create "files" to list of availabel files for accomplishing project

Part 2 ==>> Read the data from the files  
This part consists of 1 step with 3 sub-steps:  
Step 1 - Read data from the associated files into the corresponding major variable using read.table  
Step 1a - Read the SUBJECT files and create "SubjectTest" and "SubjectTrain"  
Step 1b - Read the ACTIVITY files and create "ActivityTest" and "ActivityTrain"  
Step 1c - Read FEATURE DATA files and create "FeatureDataTest" and "FeatureDataTrain"  

Part 3 ==>> Merge the training and the test sets to create one data set (AllData)  
Note:  Part 3 satisfies Getting and Cleaning Data Project Step 1  
This part consists of 2 steps and 4 sub-steps:  
Step 1 - Combine rows of related data sets using rbind  
Step 1a - Combine all rows of Subject, Activity and Feature data sets respectively and create SubjectCombined, ActivityCombined and FeatureDataCombined  
Step 1b - Establish the column names (aka variable names) for SubjectCombined and ActivityCombined using names() = c()  
Step 1c - Extract features names from features.txt using read.table and create "FeaturesNames"  
Step 1d - Assign FeaturesNames column two (V2) as variable names to FeatureDataCombined using names() = second column  
Step 2 - Combine all columns of the combined Subject, Activity and Feature data sets using cbind to create one composite data set (AllData)

Part 4 ==>> Extract only the measurements on the mean and standard deviation for each measurement feature (FinalData)  
Note:  Part 4 satisfies Getting and Cleaning Data Project Step 2  
This part consists of 3 steps:  
Step 1 - Extract desired column/variable names from list of features names (FeaturesNames column 2) created in Part 3 above using grep function to match desired variables - mean() and std() and create "Desired"  
Step 2 - Create new object (SubsetAllData) consisting of subject, activity and Desired and change "Desired" from factor to character by setting SubsetAllData = c()  
Step 3 - Subset AllData from Part 3 to create "FinalData" consisting of desired data variables by selecting only those variables defined in SubsetAlldata

Part 5 ==>> Use descriptive activity names to name the activities in the data set  
Note:  Part 5 satisfies Getting and Cleaning Data Project Step 3  
This part consists of 3 steps:  
Step 1 - Extract activity names from activity_labels.txt using read.table and create "ActivityNames"  
Step 2 - Establish the column names for ActivityNames using colnames() = c() to be "activitynumber" and "activityname"  
Step 3 - Use ActivityNames to change the activity number in the activity column of FinalData from Part 4 to the corresponding activity name using the factor function

Part 6 ==>> Appropriately label the data set with descriptive variable names  
Note:  Part 6 satisfies Getting and Cleaning Data Project Step 4  
This part consists of 1 step:  
Step 1 - Replace variable name abbreviations with descriptive names using gsub function

Part 7 ==>> From the data set in step 4 (Part 6 above), create a second, independently tidy data set with the average of each variable for each activity and each subject and create a txt file using write.table function for uploading  
Note:  Part 7 satisfies Getting and Cleaning Data Project Step 5  
This part consists of 3 steps:  
Step 1 - The tidy data set (FDtidy) will be established using the aggregate function in the plyr package applied to FinalData thus creating a wide set of tidy data  
Step 2 - Order the data in FDtidy by subject first and activity second by applying the order function to the subset of these respective columns in FDtidy  
Step 3 - Create a txt file (tidydata.txt) from FDtidy using write.table and automatically place the new document in the same folder as the other project files





