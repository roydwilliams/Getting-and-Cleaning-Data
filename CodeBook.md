---
# "Getting and Cleaning Data Project run_analysis.R CodeBook"  
author: "Roy D Williams"  
date: "Tuesday, May 19, 2015"  
---
 
## Project Description

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.  You will be required to submit: 
1) a tidy data set as described below, 
2) a link to a Github repository with your script for performing the analysis, and 
3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. 

You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

A full description of the data used for this project is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Create one R script called run_analysis.R that does the following. 
1) Merges the training and the test sets to create one data set.
2) Extracts only the measurements on the mean and standard deviation for each measurement. 
3) Uses descriptive activity names to name the activities in the data set
4) Appropriately labels the data set with descriptive variable names. 
5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Upload tidy data set as a txt file created with write.table() using row.name=FALSE

Submit a link to a Github repo with the code for performing your analysis. The code should have a file run_analysis.R in the main directory that can be run as long as the Samsung data is in your working directory. The output should be the tidy data set you submitted for part 1. You should include a README.md in the repo describing how the script works and the code book describing the variables.



## Study design and data processing

One of the most exciting areas in all of data science right now is wearable computing . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data for this project represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 

### Collection of the raw data

The experiments associated with these data files were carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using the smartphone's embedded accelerometer and gyroscope, data was captured for 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The obtained dataset was randomly partitioned into two sets, where 70% of the volunteers were selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

For each record, the following is provided:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- The associated activity label. 
- An identifier of the subject who carried out the experiment.

Notes: 
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.



## Creating the tidy datafile

Create a tidy data set with the average of each variable for each activity and each subject.


### Guide to create the tidy data file

The R script for creating the tidy data file is located in run_analysis.R. 
To create a tidy data set, first ensure you have an internet connection and then source run_analysis  

Part 1 ==>> Access, download and unzip data files.  
Source of data files is http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones  
Data files are located at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
Step 1 - Download the zipped file and put it in the "data" folder using download.file  
Content type 'application/zip' length 62556944 bytes (59.7 MB)  
Step 2 - Unzip the file using unzip function.  
List files using list.files for "data" folder to show that unzipped files are in the folder "./data/UCI HAR Dataset"  
Step 3 - Get the list of the data files using list.files for "./data/UCI HAR Dataset" and create "files".  
Calling "files" shows all of the files available for the project


Part 2 ==>> Read the data from the files  
There are three major variables ==>> SUBJECT performing the activity, ACTIVITY being performed and the associated FEATURE DATA collected for each activity performed by each subject  
SUBJECT data comes from subject_train.txt and subject_test.txt and it is only a subject number 1 - 30
ACTIVITY data comes from y_train.txt and y_test.txt and it is only an activity number 1 - 6 and the activity name associated with the activity number comes from activity_labels.txt  
FEATURE DATA comes from X_train.txt and X_text.txt and it is only the raw data and the names of the features comes from features.txt  
Step 1 - Read data from the associated files into the corresponding major variable using read.table.  
Step 1a - Read the SUBJECT files and create "SubjectTest" and "SubjectTrain"  
Step 1b - Read the ACTIVITY files and create "ActivityTest" and "ActivityTrain"  
Step 1c - Read FEATURE DATA files and create "FeatureDataTest" and "FeatureDataTrain"  
Step 2 - Review the properties of these 6 new objects using str function  
Step 2a - Reviewing SubjectTest shows it is a dataframe with 2947 observations and 1 variable (test group subject number)  
Step 2b - Reviewing SubjectTrain shows it is a dataframe with 7352 observations and 1 variable (training group subject number)  
Step 2c - Reviewing ActivityTest shows it is a dataframe with 2947 observations and 1 variable (activity number)  
Step 2d - Reviewing ActivityTrain shows it is a dataframe with 7352 observations and 1 variable (activity number)  
Step 2e - Reviewing FeatureDataTest shows it is a dataframe with 2947 observations and 561 variables (561 features)  
Step 2f - Reviewing FeatureDataTrain shows it is a dataframe with 7352 observations and 561 variables (561 features)


Part 3 ==>> Merge the training and the test sets to create one data set (AllData)  
Note:  Part 3 satisfies Getting and Cleaning Data Project Step 1  
Step 1 - Combine rows of related data sets using rbind  
Step 1a - Combine all rows of Subject, Activity and Feature data sets respectively and create "SubjectCombined", "ActivityCombined" and "FeatureDataCombined"  
Step 1b - Establish the column names (aka variable names) for SubjectCombined and ActivityCombined using names() = c()  
Step 1c - Extract features names from features.txt using read.table and create "FeaturesNames"
Calling the head of FeaturesNames shows 2 columns (V1 and V2) where V2 is the actual features names  
Step 1d - Assign FeaturesNames column two (V2) as variable names to FeatureDataCombined using names() = second column  
Test success  of steps 1b and 1d by showing the head of the combined data files  
Step 2 - Combine all columns of the combined Subject, Activity and Feature data sets using cbind to create one composite data set (AllData)  
Reviewing the properties of AllData using str function shows individual combined data files have been successfully combined into a singular object with correct variable names and shows 10299 observation (2947 from test + 7352 from train) and 563 variables (subject+Activity+561 features)


Part 4 ==>> Extract only the measurements on the mean and standard deviation for each measurement feature (FinalData)  
Note:  Part 4 satisfies Getting and Cleaning Data Project Step 2  
Step 1 - Extract desired column/variable names from list of features names (FeaturesNames column 2) created in Part 3 above using grep function to match desired variables - mean() and std() and create "Desired"  
Calling the class of Desired shows that it is a factor  
Step 2 - Create new object (SubsetAllData) consisting of subject, activity and Desired and change "Desired" from factor to character by setting SubsetAllData = c()  
Step 3 - Subset AllData from Part 3 to create "FinalData" consisting of desired data variables by selecting only those variables defined in SubsetAlldata  
Reviewing the  properties of FinalData using str function shows 10299 observation (2947 from test + 7352 from training) and 68 variables (subject+Activity+(8 features x 6 measurements + 9 features x 2 measurements) representing the mean and std variables only


Part 5 ==>> Use descriptive activity names to name the activities in the data set  
Note:  Part 5 satisfies Getting and Cleaning Data Project Step 3  
The activity names come from activity_labels.txt  
Step 1 - Extract activity names from activity_labels.txt using read.table and create "ActivityNames"  
Calling the head of ActivityNames shows two columns (V1 and V2) containing the activity number (V1) and activity name (V2)  
Step 2 - Establish the column names for ActivityNames using colnames() = c() to be "activitynumber" and "activityname"  
Step 3 - Use ActivityNames to change the activity number in the activity column of FinalData from Part 4 to the corresponding activity name using the factor function  
Calling the head of FinalData$activity shows the activity numbers have been successfully changed to the corresponding activity names  
Reviewing the properties of FinalData using str shows that the activity column is now a factor with 6 levels matching the actual names of the activities

    
Part 6 ==>> Appropriately label the data set with descriptive variable names  
Note:  Part 6 satisfies Getting and Cleaning Data Project Step 4  
The variable names in the data set (FinalData) come from features.txt and are abbreviations of the actual features (aka variables)  
Calling the names of FinalData using names() shows the abbreviated variable names  
Step 1 - Replace abbreviations with descriptive names using gsub function to replace the abbreviations with the following:  
1) For all variables starting with "t", change this to "time"  
2) For all variables with "Acc", change this to "Accelerometer"  
3) For all variables with "mean", change this to "MeanValue"
4) For all variables with "std", change this to "StandardDeviation"
5) For all variables with "Gyro", change this to "Gyroscope"
6) For all variables with "Mag", change this to "Magnitude"
7) For all variables starting with "f", change this to "frequency"
8) For all variables with "BodyBody", change this to "Body"  

Calling the names of FinalData to check the results shows the descriptive variable names applied
Reviewing the properties of FinalData using str now shows that the descriptive names have been applied   


Part 7 ==>> From the data set in step 4 (Part 6 above), create a second, independently tidy data set with the average of each variable for each activity and each subject and create a txt file using write.table function for uploading  
Note:  Part 7 satisfies Getting and Cleaning Data Project Step 5  
Step 1 - The tidy data set (FDtidy) will be established using the aggregate function in the plyr package applied to FinalData thus creating a wide set of tidy data  
From str(FinalData) we can see that only the measurement variables are numeric and therefore these are the only variables that are aggregated (columns 3 thru 68 of FinalData) and then averaged to estabish their respective mean values but they are aggregated by the first two columns (subject and activity) before the mean function is applied  
Calling the head of FDtidy shows the column names are proper and the data has been successfully aggregated and the data variables are now summarized and the mean function has been applied  
Step 2 - Order the data in FDtidy by subject first and activity second by applying the order function to the subset of these respective columns in FDtidy  
Calling the head of FDtidy now shows the data is now arranged by subject number first in sequence and each subject has 6 activities listed  
Reviewing the properties of FDtidy using str shows data is now tidy with 180 observations (30 subjects x 6 activities each) and 68 variables (subject + activity + 66 measurement variables associated with each combination of subject & activity)  
Step 3 - Create a txt file (tidydata.txt) from FDtidy using write.table and place the new document in the same folder as the other project files  
Calling list.files for the "data" folder now shows the tidydata.txt file has been created and is stored in the "data" folder along with the other files applicable to this project

### Cleaning of the data
The script for cleaning and tidying the data consisted of 7 parts.  
The readme document provides additional descriptions for the code used to accomplish this project.

Part 1 ==>> Access, download and unzip data files  
This part consisted of 3 steps:  
Step 1 - Download the zipped file and put it in the "data" folder using download.file  
Step 2 - Unzip the file using unzip function  
Step 3 - Get the list of the data files using list.files for "./data/UCI HAR Dataset" and create "files"

Part 2 ==>> Read the data from the files  
This part consisted of 1 step with 3 sub-steps:  
Step 1 - Read data from the associated files into the corresponding major variable using read.table  
Step 1a - Read the SUBJECT files and create "SubjectTest" and "SubjectTrain"  
Step 1b - Read the ACTIVITY files and create "ActivityTest" and "ActivityTrain"  
Step 1c - Read FEATURE DATA files and create "FeatureDataTest" and "FeatureDataTrain"  

Part 3 ==>> Merge the training and the test sets to create one data set (AllData)  
This part consisted of 2 steps and 4 sub-steps:  
tep 1 - Combine rows of related data sets using rbind  
Step 1a - Combine all rows of Subject, Activity and Feature data sets respectively and create SubjectCombined, ActivityCombined and FeatureDataCombined  
Step 1b - Establish the column names (aka variable names) for SubjectCombined and ActivityCombined using names() = c()  
Step 1c - Extract features names from features.txt using read.table and create "FeaturesNames"  
Step 1d - Assign FeaturesNames column two (V2) as variable names to FeatureDataCombined using names() = second column  
Step 2 - Combine all columns of the combined Subject, Activity and Feature data sets using cbind to create one composite data set (AllData)

Part 4 ==>> Extract only the measurements on the mean and standard deviation for each measurement feature (FinalData)  
This part consisted of 3 steps:  
Step 1 - Extract desired column/variable names from list of features names (FeaturesNames column 2) created in Part 3 above using grep function to match desired variables - mean() and std() and create "Desired"  
Step 2 - Create new object (SubsetAllData) consisting of subject, activity and Desired and change "Desired" from factor to character by setting SubsetAllData = c()  
Step 3 - Subset AllData from Part 3 to create "FinalData" consisting of desired data variables by selecting only those variables defined in SubsetAlldata

Part 5 ==>> Use descriptive activity names to name the activities in the data set  
This part consisted of 3 steps:  
Step 1 - Extract activity names from activity_labels.txt using read.table and create "ActivityNames"  
Step 2 - Establish the column names for ActivityNames using colnames() = c() to be "activitynumber" and "activityname"  
Step 3 - Use ActivityNames to change the activity number in the activity column of FinalData from Part 4 to the corresponding activity name using the factor function

Part 6 ==>> Appropriately label the data set with descriptive variable names  
This part consisted of 1 step:  
Step 1 - Replace variable name abbreviations with descriptive names using gsub function

Part 7 ==>> From the data set in step 4 (Part 6 above), create a second, independently tidy data set with the average of each variable for each activity and each subject and create a txt file using write.table function for uploading  
This part consisted of 3 steps:  
Step 1 - The tidy data set (FDtidy) will be established using the aggregate function in the plyr package applied to FinalData thus creating a wide set of tidy data  
Step 2 - Order the data in FDtidy by subject first and activity second by applying the order function to the subset of these respective columns in FDtidy  
Step 3 - Create a txt file (tidydata.txt) from FDtidy using write.table and place the new document in the same folder as the other project files



## Description of the variables in the tiny_data.txt file

Files available from the data set include:

"activity_labels.txt"                          
"features.txt"                                
"features_info.txt"                            
"README.txt"                                  
"test/Inertial Signals/body_acc_x_test.txt"    
"test/Inertial Signals/body_acc_y_test.txt"   
"test/Inertial Signals/body_acc_z_test.txt"    
"test/Inertial Signals/body_gyro_x_test.txt"  
"test/Inertial Signals/body_gyro_y_test.txt"   
"test/Inertial Signals/body_gyro_z_test.txt"  
"test/Inertial Signals/total_acc_x_test.txt"   
"test/Inertial Signals/total_acc_y_test.txt"  
"test/Inertial Signals/total_acc_z_test.txt"   
"test/subject_test.txt"                       
"test/X_test.txt"                              
"test/y_test.txt"                             
"train/Inertial Signals/body_acc_x_train.txt"  
"train/Inertial Signals/body_acc_y_train.txt"  
"train/Inertial Signals/body_acc_z_train.txt"  
"train/Inertial Signals/body_gyro_x_train.txt"  
"train/Inertial Signals/body_gyro_y_train.txt"  
"train/Inertial Signals/body_gyro_z_train.txt"  
"train/Inertial Signals/total_acc_x_train.txt"  
"train/Inertial Signals/total_acc_y_train.txt"  
"train/Inertial Signals/total_acc_z_train.txt"  
"train/subject_train.txt"                     
"train/X_train.txt"                            
"train/y_train.txt"   

The data files used to establish variables for project are:

1) test/subject_test.txt ==>> each row identifies the subject number (30% (9 of 30 subjects) = 2,4,9,10,12,13,18,20,24)
2) test/X_test.txt ==>> Test data set, 2947 observations (data for each feature associated with each activity performed by each test subject)
3) test/y_test.txt ==>> Test labels (activity numbers where==>>1=walking,2=walking upstairs,3=walking downstairs, 4=sitting,5=standing,6=lying)
4) train/subject_train.txt ==>> each row identifies the subject number (70% (21 of 30 subjects) = 1,3,5,6,7,8,11,14,15,16,17,19,21,22,23,25,26,27,28,29,30)
5) train/X_train.txt ==>> Training data set, 7352 observations (data for each feature associated with each activity performed by each training subject)
6) train/y_train.txt ==>> Training labels (activity numbers where==>>1=walking,2=walking upstairs,3=walking downstairs, 4=sitting,5=standing,6=lying)
7) activity_labels.txt ==>> activity number and name (1=walking,2=walking upstairs,3=walking downstairs,4=sitting, 5=standing,6=lying)
8) features.txt ==>> 561 features names, these are the column names to be used (aka variables)  

Note:  Inertial Signals files are not included since they do not contain data applicable to this project

The final data set developed for this project will include 68 variables representing the subject (class = integer), the activity (class = factor) and the 66 measurement features (class = numeric) along with 10,299 observations representing 2,947 test records and 7,352 training records.  

The tidy version of this data will include the same 68 variables along with 180 observation representing the mean values of the measurements for each of the 6 activities for each of the 30 subjects. 

### Variable Details

Subjct Labels (subject variable) are numbers 1 throught 30 such that 30% of the subjects (9 of 30 subjects = subjects 2,4,9,10,12,13,18,20,24) were used to develop the test data and 70% of the subjects (21 of 30 subjects = subjects 1,3,5,6,7,8,11,14,15,16,17,19,21,22,23,25,26,27,28,29,30) were used to develop the training data

Activity labels (activity variable) are an activity number and the corresponding activity name:  
1 WALKING  
2 WALKING_UPSTAIRS  
3 WALKING_DOWNSTAIRS  
4 SITTING  
5 STANDING  
6 LAYING

The features (measurement variables) come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 
- tBodyAcc-XYZ
- tGravityAcc-XYZ
- tBodyGyro-XYZ  

The prefix 't' denotes time, 'Acc' denotes Accelerometer and 'Gyro' denotes Gyroscope
XYZ' is used to denote 3-axial signals in the X, Y and Z directions

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals:
- tBodyAccJerk-XYZ
- tBodyGyroJerk-XYZ

The prefix 't' denotes time, 'Acc' denotes Accelerometer and 'Gyro' denotes Gyroscope
XYZ' is used to denote 3-axial signals in the X, Y and Z directions

Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm:
- tBodyAccMag
- tGravityAccMag
- tBodyGyroMag
- tBodyAccJerkMag
- tBodyGyroJerkMag

The prefix 't' denotes time, 'Acc' denotes Accelerometer, 'Gyro' denotes Gyroscope and 'Mag' denotes Magnitude  
XYZ' is used to denote 3-axial signals in the X, Y and Z directions

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing:
- fBodyAcc-XYZ
- fBodyGyro-XYZ
- fBodyAccJerk-XYZ
- fBodyGyroJerk-XYZ
- fBodyAccMag
- fBodyGyroMag
- fBodyAccJerkMag
- fBodyGyroJerkMag

The prefix 'f' denotes frequency domain signals, 'Acc' denotes Accelerometer, 'Gyro' denotes Gyroscope and 'Mag' denotes Magnitude  
XYZ' is used to denote 3-axial signals in the X, Y and Z directions

The entire set of features consists of 561 measurements/calculations (no units were assigned to this data in the data table):  

1 tBodyAcc-mean()-X  
2 tBodyAcc-mean()-Y  
3 tBodyAcc-mean()-Z  
4 tBodyAcc-std()-X  
5 tBodyAcc-std()-Y  
6 tBodyAcc-std()-Z  
7 tBodyAcc-mad()-X  
8 tBodyAcc-mad()-Y  
9 tBodyAcc-mad()-Z  
10 tBodyAcc-max()-X  
11 tBodyAcc-max()-Y  
12 tBodyAcc-max()-Z  
13 tBodyAcc-min()-X  
14 tBodyAcc-min()-Y  
15 tBodyAcc-min()-Z  
16 tBodyAcc-sma()  
17 tBodyAcc-energy()-X  
18 tBodyAcc-energy()-Y  
19 tBodyAcc-energy()-Z  
20 tBodyAcc-iqr()-X  
21 tBodyAcc-iqr()-Y  
22 tBodyAcc-iqr()-Z  
23 tBodyAcc-entropy()-X  
24 tBodyAcc-entropy()-Y  
25 tBodyAcc-entropy()-Z  
26 tBodyAcc-arCoeff()-X,1  
27 tBodyAcc-arCoeff()-X,2  
28 tBodyAcc-arCoeff()-X,3  
29 tBodyAcc-arCoeff()-X,4  
30 tBodyAcc-arCoeff()-Y,1  
31 tBodyAcc-arCoeff()-Y,2  
32 tBodyAcc-arCoeff()-Y,3  
33 tBodyAcc-arCoeff()-Y,4  
34 tBodyAcc-arCoeff()-Z,1  
35 tBodyAcc-arCoeff()-Z,2  
36 tBodyAcc-arCoeff()-Z,3  
37 tBodyAcc-arCoeff()-Z,4  
38 tBodyAcc-correlation()-X,Y  
39 tBodyAcc-correlation()-X,Z  
40 tBodyAcc-correlation()-Y,Z  
41 tGravityAcc-mean()-X  
42 tGravityAcc-mean()-Y  
43 tGravityAcc-mean()-Z  
44 tGravityAcc-std()-X  
45 tGravityAcc-std()-Y  
46 tGravityAcc-std()-Z  
47 tGravityAcc-mad()-X  
48 tGravityAcc-mad()-Y  
49 tGravityAcc-mad()-Z  
50 tGravityAcc-max()-X  
51 tGravityAcc-max()-Y  
52 tGravityAcc-max()-Z  
53 tGravityAcc-min()-X  
54 tGravityAcc-min()-Y  
55 tGravityAcc-min()-Z  
56 tGravityAcc-sma()  
57 tGravityAcc-energy()-X  
58 tGravityAcc-energy()-Y  
59 tGravityAcc-energy()-Z  
60 tGravityAcc-iqr()-X  
61 tGravityAcc-iqr()-Y  
62 tGravityAcc-iqr()-Z  
63 tGravityAcc-entropy()-X  
64 tGravityAcc-entropy()-Y  
65 tGravityAcc-entropy()-Z  
66 tGravityAcc-arCoeff()-X,1  
67 tGravityAcc-arCoeff()-X,2  
68 tGravityAcc-arCoeff()-X,3  
69 tGravityAcc-arCoeff()-X,4  
70 tGravityAcc-arCoeff()-Y,1  
71 tGravityAcc-arCoeff()-Y,2  
72 tGravityAcc-arCoeff()-Y,3  
73 tGravityAcc-arCoeff()-Y,4  
74 tGravityAcc-arCoeff()-Z,1  
75 tGravityAcc-arCoeff()-Z,2  
76 tGravityAcc-arCoeff()-Z,3  
77 tGravityAcc-arCoeff()-Z,4  
78 tGravityAcc-correlation()-X,Y  
79 tGravityAcc-correlation()-X,Z  
80 tGravityAcc-correlation()-Y,Z  
81 tBodyAccJerk-mean()-X  
82 tBodyAccJerk-mean()-Y  
83 tBodyAccJerk-mean()-Z  
84 tBodyAccJerk-std()-X  
85 tBodyAccJerk-std()-Y  
86 tBodyAccJerk-std()-Z  
87 tBodyAccJerk-mad()-X  
88 tBodyAccJerk-mad()-Y  
89 tBodyAccJerk-mad()-Z  
90 tBodyAccJerk-max()-X  
91 tBodyAccJerk-max()-Y  
92 tBodyAccJerk-max()-Z  
93 tBodyAccJerk-min()-X  
94 tBodyAccJerk-min()-Y  
95 tBodyAccJerk-min()-Z  
96 tBodyAccJerk-sma()  
97 tBodyAccJerk-energy()-X  
98 tBodyAccJerk-energy()-Y  
99 tBodyAccJerk-energy()-Z  
100 tBodyAccJerk-iqr()-X  
101 tBodyAccJerk-iqr()-Y  
102 tBodyAccJerk-iqr()-Z  
103 tBodyAccJerk-entropy()-X  
104 tBodyAccJerk-entropy()-Y  
105 tBodyAccJerk-entropy()-Z  
106 tBodyAccJerk-arCoeff()-X,1  
107 tBodyAccJerk-arCoeff()-X,2  
108 tBodyAccJerk-arCoeff()-X,3  
109 tBodyAccJerk-arCoeff()-X,4  
110 tBodyAccJerk-arCoeff()-Y,1  
111 tBodyAccJerk-arCoeff()-Y,2  
112 tBodyAccJerk-arCoeff()-Y,3  
113 tBodyAccJerk-arCoeff()-Y,4  
114 tBodyAccJerk-arCoeff()-Z,1  
115 tBodyAccJerk-arCoeff()-Z,2  
116 tBodyAccJerk-arCoeff()-Z,3  
117 tBodyAccJerk-arCoeff()-Z,4  
118 tBodyAccJerk-correlation()-X,Y  
119 tBodyAccJerk-correlation()-X,Z  
120 tBodyAccJerk-correlation()-Y,Z  
121 tBodyGyro-mean()-X  
122 tBodyGyro-mean()-Y  
123 tBodyGyro-mean()-Z  
124 tBodyGyro-std()-X  
125 tBodyGyro-std()-Y  
126 tBodyGyro-std()-Z  
127 tBodyGyro-mad()-X  
128 tBodyGyro-mad()-Y  
129 tBodyGyro-mad()-Z  
130 tBodyGyro-max()-X  
131 tBodyGyro-max()-Y  
132 tBodyGyro-max()-Z  
133 tBodyGyro-min()-X  
134 tBodyGyro-min()-Y  
135 tBodyGyro-min()-Z  
136 tBodyGyro-sma()  
137 tBodyGyro-energy()-X  
138 tBodyGyro-energy()-Y  
139 tBodyGyro-energy()-Z  
140 tBodyGyro-iqr()-X  
141 tBodyGyro-iqr()-Y  
142 tBodyGyro-iqr()-Z  
143 tBodyGyro-entropy()-X  
144 tBodyGyro-entropy()-Y  
145 tBodyGyro-entropy()-Z  
146 tBodyGyro-arCoeff()-X,1  
147 tBodyGyro-arCoeff()-X,2  
148 tBodyGyro-arCoeff()-X,3  
149 tBodyGyro-arCoeff()-X,4  
150 tBodyGyro-arCoeff()-Y,1  
151 tBodyGyro-arCoeff()-Y,2  
152 tBodyGyro-arCoeff()-Y,3  
153 tBodyGyro-arCoeff()-Y,4  
154 tBodyGyro-arCoeff()-Z,1  
155 tBodyGyro-arCoeff()-Z,2  
156 tBodyGyro-arCoeff()-Z,3  
157 tBodyGyro-arCoeff()-Z,4  
158 tBodyGyro-correlation()-X,Y  
159 tBodyGyro-correlation()-X,Z  
160 tBodyGyro-correlation()-Y,Z  
161 tBodyGyroJerk-mean()-X  
162 tBodyGyroJerk-mean()-Y  
163 tBodyGyroJerk-mean()-Z  
164 tBodyGyroJerk-std()-X  
165 tBodyGyroJerk-std()-Y  
166 tBodyGyroJerk-std()-Z  
167 tBodyGyroJerk-mad()-X  
168 tBodyGyroJerk-mad()-Y  
169 tBodyGyroJerk-mad()-Z  
170 tBodyGyroJerk-max()-X  
171 tBodyGyroJerk-max()-Y  
172 tBodyGyroJerk-max()-Z  
173 tBodyGyroJerk-min()-X  
174 tBodyGyroJerk-min()-Y  
175 tBodyGyroJerk-min()-Z  
176 tBodyGyroJerk-sma()  
177 tBodyGyroJerk-energy()-X  
178 tBodyGyroJerk-energy()-Y  
179 tBodyGyroJerk-energy()-Z  
180 tBodyGyroJerk-iqr()-X  
181 tBodyGyroJerk-iqr()-Y  
182 tBodyGyroJerk-iqr()-Z  
183 tBodyGyroJerk-entropy()-X  
184 tBodyGyroJerk-entropy()-Y  
185 tBodyGyroJerk-entropy()-Z  
186 tBodyGyroJerk-arCoeff()-X,1  
187 tBodyGyroJerk-arCoeff()-X,2  
188 tBodyGyroJerk-arCoeff()-X,3  
189 tBodyGyroJerk-arCoeff()-X,4  
190 tBodyGyroJerk-arCoeff()-Y,1  
191 tBodyGyroJerk-arCoeff()-Y,2  
192 tBodyGyroJerk-arCoeff()-Y,3  
193 tBodyGyroJerk-arCoeff()-Y,4  
194 tBodyGyroJerk-arCoeff()-Z,1  
195 tBodyGyroJerk-arCoeff()-Z,2  
196 tBodyGyroJerk-arCoeff()-Z,3  
197 tBodyGyroJerk-arCoeff()-Z,4  
198 tBodyGyroJerk-correlation()-X,Y  
199 tBodyGyroJerk-correlation()-X,Z  
200 tBodyGyroJerk-correlation()-Y,Z  
201 tBodyAccMag-mean()  
202 tBodyAccMag-std()  
203 tBodyAccMag-mad()  
204 tBodyAccMag-max()  
205 tBodyAccMag-min()  
206 tBodyAccMag-sma()  
207 tBodyAccMag-energy()  
208 tBodyAccMag-iqr()  
209 tBodyAccMag-entropy()  
210 tBodyAccMag-arCoeff()1  
211 tBodyAccMag-arCoeff()2  
212 tBodyAccMag-arCoeff()3  
213 tBodyAccMag-arCoeff()4  
214 tGravityAccMag-mean()  
215 tGravityAccMag-std()  
216 tGravityAccMag-mad()  
217 tGravityAccMag-max()  
218 tGravityAccMag-min()  
219 tGravityAccMag-sma()  
220 tGravityAccMag-energy()  
221 tGravityAccMag-iqr()  
222 tGravityAccMag-entropy()  
223 tGravityAccMag-arCoeff()1  
224 tGravityAccMag-arCoeff()2  
225 tGravityAccMag-arCoeff()3  
226 tGravityAccMag-arCoeff()4  
227 tBodyAccJerkMag-mean()  
228 tBodyAccJerkMag-std()  
229 tBodyAccJerkMag-mad()  
230 tBodyAccJerkMag-max()  
231 tBodyAccJerkMag-min()  
232 tBodyAccJerkMag-sma()  
233 tBodyAccJerkMag-energy()  
234 tBodyAccJerkMag-iqr()  
235 tBodyAccJerkMag-entropy()  
236 tBodyAccJerkMag-arCoeff()1  
237 tBodyAccJerkMag-arCoeff()2  
238 tBodyAccJerkMag-arCoeff()3  
239 tBodyAccJerkMag-arCoeff()4  
240 tBodyGyroMag-mean()  
241 tBodyGyroMag-std()  
242 tBodyGyroMag-mad()  
243 tBodyGyroMag-max()  
244 tBodyGyroMag-min()  
245 tBodyGyroMag-sma()  
246 tBodyGyroMag-energy()  
247 tBodyGyroMag-iqr()  
248 tBodyGyroMag-entropy()  
249 tBodyGyroMag-arCoeff()1  
250 tBodyGyroMag-arCoeff()2  
251 tBodyGyroMag-arCoeff()3  
252 tBodyGyroMag-arCoeff()4  
253 tBodyGyroJerkMag-mean()  
254 tBodyGyroJerkMag-std()  
255 tBodyGyroJerkMag-mad()  
256 tBodyGyroJerkMag-max()  
257 tBodyGyroJerkMag-min()  
258 tBodyGyroJerkMag-sma()  
259 tBodyGyroJerkMag-energy()  
260 tBodyGyroJerkMag-iqr()  
261 tBodyGyroJerkMag-entropy()  
262 tBodyGyroJerkMag-arCoeff()1  
263 tBodyGyroJerkMag-arCoeff()2  
264 tBodyGyroJerkMag-arCoeff()3  
265 tBodyGyroJerkMag-arCoeff()4  
266 fBodyAcc-mean()-X  
267 fBodyAcc-mean()-Y  
268 fBodyAcc-mean()-Z  
269 fBodyAcc-std()-X  
270 fBodyAcc-std()-Y  
271 fBodyAcc-std()-Z  
272 fBodyAcc-mad()-X  
273 fBodyAcc-mad()-Y  
274 fBodyAcc-mad()-Z  
275 fBodyAcc-max()-X  
276 fBodyAcc-max()-Y  
277 fBodyAcc-max()-Z  
278 fBodyAcc-min()-X  
279 fBodyAcc-min()-Y  
280 fBodyAcc-min()-Z  
281 fBodyAcc-sma()  
282 fBodyAcc-energy()-X  
283 fBodyAcc-energy()-Y  
284 fBodyAcc-energy()-Z  
285 fBodyAcc-iqr()-X  
286 fBodyAcc-iqr()-Y  
287 fBodyAcc-iqr()-Z  
288 fBodyAcc-entropy()-X  
289 fBodyAcc-entropy()-Y  
290 fBodyAcc-entropy()-Z  
291 fBodyAcc-maxInds-X  
292 fBodyAcc-maxInds-Y  
293 fBodyAcc-maxInds-Z  
294 fBodyAcc-meanFreq()-X  
295 fBodyAcc-meanFreq()-Y  
296 fBodyAcc-meanFreq()-Z  
297 fBodyAcc-skewness()-X  
298 fBodyAcc-kurtosis()-X  
299 fBodyAcc-skewness()-Y  
300 fBodyAcc-kurtosis()-Y  
301 fBodyAcc-skewness()-Z  
302 fBodyAcc-kurtosis()-Z  
303 fBodyAcc-bandsEnergy()-1,8  
304 fBodyAcc-bandsEnergy()-9,16  
305 fBodyAcc-bandsEnergy()-17,24  
306 fBodyAcc-bandsEnergy()-25,32  
307 fBodyAcc-bandsEnergy()-33,40  
308 fBodyAcc-bandsEnergy()-41,48  
309 fBodyAcc-bandsEnergy()-49,56  
310 fBodyAcc-bandsEnergy()-57,64  
311 fBodyAcc-bandsEnergy()-1,16  
312 fBodyAcc-bandsEnergy()-17,32  
313 fBodyAcc-bandsEnergy()-33,48  
314 fBodyAcc-bandsEnergy()-49,64  
315 fBodyAcc-bandsEnergy()-1,24  
316 fBodyAcc-bandsEnergy()-25,48  
317 fBodyAcc-bandsEnergy()-1,8  
318 fBodyAcc-bandsEnergy()-9,16  
319 fBodyAcc-bandsEnergy()-17,24  
320 fBodyAcc-bandsEnergy()-25,32  
321 fBodyAcc-bandsEnergy()-33,40  
322 fBodyAcc-bandsEnergy()-41,48  
323 fBodyAcc-bandsEnergy()-49,56  
324 fBodyAcc-bandsEnergy()-57,64  
325 fBodyAcc-bandsEnergy()-1,16  
326 fBodyAcc-bandsEnergy()-17,32  
327 fBodyAcc-bandsEnergy()-33,48  
328 fBodyAcc-bandsEnergy()-49,64  
329 fBodyAcc-bandsEnergy()-1,24  
330 fBodyAcc-bandsEnergy()-25,48  
331 fBodyAcc-bandsEnergy()-1,8  
332 fBodyAcc-bandsEnergy()-9,16  
333 fBodyAcc-bandsEnergy()-17,24  
334 fBodyAcc-bandsEnergy()-25,32  
335 fBodyAcc-bandsEnergy()-33,40  
336 fBodyAcc-bandsEnergy()-41,48  
337 fBodyAcc-bandsEnergy()-49,56  
338 fBodyAcc-bandsEnergy()-57,64  
339 fBodyAcc-bandsEnergy()-1,16  
340 fBodyAcc-bandsEnergy()-17,32  
341 fBodyAcc-bandsEnergy()-33,48  
342 fBodyAcc-bandsEnergy()-49,64  
343 fBodyAcc-bandsEnergy()-1,24  
344 fBodyAcc-bandsEnergy()-25,48  
345 fBodyAccJerk-mean()-X  
346 fBodyAccJerk-mean()-Y  
347 fBodyAccJerk-mean()-Z  
348 fBodyAccJerk-std()-X  
349 fBodyAccJerk-std()-Y  
350 fBodyAccJerk-std()-Z  
351 fBodyAccJerk-mad()-X  
352 fBodyAccJerk-mad()-Y  
353 fBodyAccJerk-mad()-Z  
354 fBodyAccJerk-max()-X  
355 fBodyAccJerk-max()-Y  
356 fBodyAccJerk-max()-Z  
357 fBodyAccJerk-min()-X  
358 fBodyAccJerk-min()-Y  
359 fBodyAccJerk-min()-Z  
360 fBodyAccJerk-sma()  
361 fBodyAccJerk-energy()-X  
362 fBodyAccJerk-energy()-Y  
363 fBodyAccJerk-energy()-Z  
364 fBodyAccJerk-iqr()-X  
365 fBodyAccJerk-iqr()-Y  
366 fBodyAccJerk-iqr()-Z  
367 fBodyAccJerk-entropy()-X  
368 fBodyAccJerk-entropy()-Y  
369 fBodyAccJerk-entropy()-Z  
370 fBodyAccJerk-maxInds-X  
371 fBodyAccJerk-maxInds-Y  
372 fBodyAccJerk-maxInds-Z  
373 fBodyAccJerk-meanFreq()-X  
374 fBodyAccJerk-meanFreq()-Y  
375 fBodyAccJerk-meanFreq()-Z  
376 fBodyAccJerk-skewness()-X  
377 fBodyAccJerk-kurtosis()-X  
378 fBodyAccJerk-skewness()-Y  
379 fBodyAccJerk-kurtosis()-Y  
380 fBodyAccJerk-skewness()-Z  
381 fBodyAccJerk-kurtosis()-Z  
382 fBodyAccJerk-bandsEnergy()-1,8  
383 fBodyAccJerk-bandsEnergy()-9,16  
384 fBodyAccJerk-bandsEnergy()-17,24  
385 fBodyAccJerk-bandsEnergy()-25,32  
386 fBodyAccJerk-bandsEnergy()-33,40  
387 fBodyAccJerk-bandsEnergy()-41,48  
388 fBodyAccJerk-bandsEnergy()-49,56  
389 fBodyAccJerk-bandsEnergy()-57,64  
390 fBodyAccJerk-bandsEnergy()-1,16  
391 fBodyAccJerk-bandsEnergy()-17,32  
392 fBodyAccJerk-bandsEnergy()-33,48  
393 fBodyAccJerk-bandsEnergy()-49,64  
394 fBodyAccJerk-bandsEnergy()-1,24  
395 fBodyAccJerk-bandsEnergy()-25,48  
396 fBodyAccJerk-bandsEnergy()-1,8  
397 fBodyAccJerk-bandsEnergy()-9,16  
398 fBodyAccJerk-bandsEnergy()-17,24  
399 fBodyAccJerk-bandsEnergy()-25,32  
400 fBodyAccJerk-bandsEnergy()-33,40  
401 fBodyAccJerk-bandsEnergy()-41,48  
402 fBodyAccJerk-bandsEnergy()-49,56  
403 fBodyAccJerk-bandsEnergy()-57,64  
404 fBodyAccJerk-bandsEnergy()-1,16  
405 fBodyAccJerk-bandsEnergy()-17,32  
406 fBodyAccJerk-bandsEnergy()-33,48  
407 fBodyAccJerk-bandsEnergy()-49,64  
408 fBodyAccJerk-bandsEnergy()-1,24  
409 fBodyAccJerk-bandsEnergy()-25,48  
410 fBodyAccJerk-bandsEnergy()-1,8  
411 fBodyAccJerk-bandsEnergy()-9,16  
412 fBodyAccJerk-bandsEnergy()-17,24  
413 fBodyAccJerk-bandsEnergy()-25,32  
414 fBodyAccJerk-bandsEnergy()-33,40  
415 fBodyAccJerk-bandsEnergy()-41,48  
416 fBodyAccJerk-bandsEnergy()-49,56  
417 fBodyAccJerk-bandsEnergy()-57,64  
418 fBodyAccJerk-bandsEnergy()-1,16  
419 fBodyAccJerk-bandsEnergy()-17,32  
420 fBodyAccJerk-bandsEnergy()-33,48  
421 fBodyAccJerk-bandsEnergy()-49,64  
422 fBodyAccJerk-bandsEnergy()-1,24  
423 fBodyAccJerk-bandsEnergy()-25,48  
424 fBodyGyro-mean()-X  
425 fBodyGyro-mean()-Y  
426 fBodyGyro-mean()-Z  
427 fBodyGyro-std()-X  
428 fBodyGyro-std()-Y  
429 fBodyGyro-std()-Z  
430 fBodyGyro-mad()-X  
431 fBodyGyro-mad()-Y  
432 fBodyGyro-mad()-Z  
433 fBodyGyro-max()-X  
434 fBodyGyro-max()-Y  
435 fBodyGyro-max()-Z  
436 fBodyGyro-min()-X  
437 fBodyGyro-min()-Y  
438 fBodyGyro-min()-Z  
439 fBodyGyro-sma()  
440 fBodyGyro-energy()-X  
441 fBodyGyro-energy()-Y  
442 fBodyGyro-energy()-Z  
443 fBodyGyro-iqr()-X  
444 fBodyGyro-iqr()-Y  
445 fBodyGyro-iqr()-Z  
446 fBodyGyro-entropy()-X  
447 fBodyGyro-entropy()-Y  
448 fBodyGyro-entropy()-Z  
449 fBodyGyro-maxInds-X  
450 fBodyGyro-maxInds-Y  
451 fBodyGyro-maxInds-Z  
452 fBodyGyro-meanFreq()-X  
453 fBodyGyro-meanFreq()-Y  
454 fBodyGyro-meanFreq()-Z  
455 fBodyGyro-skewness()-X  
456 fBodyGyro-kurtosis()-X  
457 fBodyGyro-skewness()-Y  
458 fBodyGyro-kurtosis()-Y  
459 fBodyGyro-skewness()-Z  
460 fBodyGyro-kurtosis()-Z  
461 fBodyGyro-bandsEnergy()-1,8  
462 fBodyGyro-bandsEnergy()-9,16  
463 fBodyGyro-bandsEnergy()-17,24  
464 fBodyGyro-bandsEnergy()-25,32  
465 fBodyGyro-bandsEnergy()-33,40  
466 fBodyGyro-bandsEnergy()-41,48  
467 fBodyGyro-bandsEnergy()-49,56  
468 fBodyGyro-bandsEnergy()-57,64  
469 fBodyGyro-bandsEnergy()-1,16  
470 fBodyGyro-bandsEnergy()-17,32  
471 fBodyGyro-bandsEnergy()-33,48  
472 fBodyGyro-bandsEnergy()-49,64  
473 fBodyGyro-bandsEnergy()-1,24  
474 fBodyGyro-bandsEnergy()-25,48  
475 fBodyGyro-bandsEnergy()-1,8  
476 fBodyGyro-bandsEnergy()-9,16  
477 fBodyGyro-bandsEnergy()-17,24  
478 fBodyGyro-bandsEnergy()-25,32  
479 fBodyGyro-bandsEnergy()-33,40  
480 fBodyGyro-bandsEnergy()-41,48  
481 fBodyGyro-bandsEnergy()-49,56  
482 fBodyGyro-bandsEnergy()-57,64  
483 fBodyGyro-bandsEnergy()-1,16  
484 fBodyGyro-bandsEnergy()-17,32  
485 fBodyGyro-bandsEnergy()-33,48  
486 fBodyGyro-bandsEnergy()-49,64  
487 fBodyGyro-bandsEnergy()-1,24  
488 fBodyGyro-bandsEnergy()-25,48  
489 fBodyGyro-bandsEnergy()-1,8  
490 fBodyGyro-bandsEnergy()-9,16  
491 fBodyGyro-bandsEnergy()-17,24  
492 fBodyGyro-bandsEnergy()-25,32  
493 fBodyGyro-bandsEnergy()-33,40  
494 fBodyGyro-bandsEnergy()-41,48  
495 fBodyGyro-bandsEnergy()-49,56  
496 fBodyGyro-bandsEnergy()-57,64  
497 fBodyGyro-bandsEnergy()-1,16  
498 fBodyGyro-bandsEnergy()-17,32  
499 fBodyGyro-bandsEnergy()-33,48  
500 fBodyGyro-bandsEnergy()-49,64  
501 fBodyGyro-bandsEnergy()-1,24  
502 fBodyGyro-bandsEnergy()-25,48  
503 fBodyAccMag-mean()  
504 fBodyAccMag-std()  
505 fBodyAccMag-mad()  
506 fBodyAccMag-max()  
507 fBodyAccMag-min()  
508 fBodyAccMag-sma()  
509 fBodyAccMag-energy()  
510 fBodyAccMag-iqr()  
511 fBodyAccMag-entropy()  
512 fBodyAccMag-maxInds  
513 fBodyAccMag-meanFreq()  
514 fBodyAccMag-skewness()  
515 fBodyAccMag-kurtosis()  
516 fBodyBodyAccJerkMag-mean()  
517 fBodyBodyAccJerkMag-std()  
518 fBodyBodyAccJerkMag-mad()  
519 fBodyBodyAccJerkMag-max()  
520 fBodyBodyAccJerkMag-min()  
521 fBodyBodyAccJerkMag-sma()  
522 fBodyBodyAccJerkMag-energy()  
523 fBodyBodyAccJerkMag-iqr()  
524 fBodyBodyAccJerkMag-entropy()  
525 fBodyBodyAccJerkMag-maxInds  
526 fBodyBodyAccJerkMag-meanFreq()  
527 fBodyBodyAccJerkMag-skewness()  
528 fBodyBodyAccJerkMag-kurtosis()  
529 fBodyBodyGyroMag-mean()  
530 fBodyBodyGyroMag-std()  
531 fBodyBodyGyroMag-mad()  
532 fBodyBodyGyroMag-max()  
533 fBodyBodyGyroMag-min()  
534 fBodyBodyGyroMag-sma()  
535 fBodyBodyGyroMag-energy()  
536 fBodyBodyGyroMag-iqr()  
537 fBodyBodyGyroMag-entropy()  
538 fBodyBodyGyroMag-maxInds  
539 fBodyBodyGyroMag-meanFreq()  
540 fBodyBodyGyroMag-skewness()  
541 fBodyBodyGyroMag-kurtosis()  
542 fBodyBodyGyroJerkMag-mean()  
543 fBodyBodyGyroJerkMag-std()  
544 fBodyBodyGyroJerkMag-mad()  
545 fBodyBodyGyroJerkMag-max()  
546 fBodyBodyGyroJerkMag-min()  
547 fBodyBodyGyroJerkMag-sma()  
548 fBodyBodyGyroJerkMag-energy()  
549 fBodyBodyGyroJerkMag-iqr()  
550 fBodyBodyGyroJerkMag-entropy()  
551 fBodyBodyGyroJerkMag-maxInds  
552 fBodyBodyGyroJerkMag-meanFreq()  
553 fBodyBodyGyroJerkMag-skewness()  
554 fBodyBodyGyroJerkMag-kurtosis()  
555 angle(tBodyAccMean,gravity)  
556 angle(tBodyAccJerkMean),gravityMean)  
557 angle(tBodyGyroMean,gravityMean)  
558 angle(tBodyGyroJerkMean,gravityMean)  
559 angle(X,gravityMean)  
560 angle(Y,gravityMean)  
561 angle(Z,gravityMean)  

The only features of interest to this project are the 66 that represent the Mean Values and Standard Deviations: 

1 tBodyAcc-mean()-X  
2 tBodyAcc-mean()-Y  
3 tBodyAcc-mean()-Z  
4 tBodyAcc-std()-X  
5 tBodyAcc-std()-Y  
6 tBodyAcc-std()-Z  
41 tGravityAcc-mean()-X  
42 tGravityAcc-mean()-Y  
43 tGravityAcc-mean()-Z  
44 tGravityAcc-std()-X  
45 tGravityAcc-std()-Y  
46 tGravityAcc-std()-Z  
81 tBodyAccJerk-mean()-X  
82 tBodyAccJerk-mean()-Y  
83 tBodyAccJerk-mean()-Z  
84 tBodyAccJerk-std()-X  
85 tBodyAccJerk-std()-Y  
86 tBodyAccJerk-std()-Z  
121 tBodyGyro-mean()-X  
122 tBodyGyro-mean()-Y  
123 tBodyGyro-mean()-Z  
124 tBodyGyro-std()-X  
125 tBodyGyro-std()-Y  
126 tBodyGyro-std()-Z  
161 tBodyGyroJerk-mean()-X  
162 tBodyGyroJerk-mean()-Y  
163 tBodyGyroJerk-mean()-Z  
164 tBodyGyroJerk-std()-X  
165 tBodyGyroJerk-std()-Y  
166 tBodyGyroJerk-std()-Z  
201 tBodyAccMag-mean()  
202 tBodyAccMag-std()  
214 tGravityAccMag-mean()  
215 tGravityAccMag-std()  
227 tBodyAccJerkMag-mean()  
228 tBodyAccJerkMag-std()  
240 tBodyGyroMag-mean()  
241 tBodyGyroMag-std()  
253 tBodyGyroJerkMag-mean()  
254 tBodyGyroJerkMag-std()  
266 fBodyAcc-mean()-X  
267 fBodyAcc-mean()-Y  
268 fBodyAcc-mean()-Z  
269 fBodyAcc-std()-X  
270 fBodyAcc-std()-Y  
271 fBodyAcc-std()-Z  
345 fBodyAccJerk-mean()-X  
346 fBodyAccJerk-mean()-Y  
347 fBodyAccJerk-mean()-Z  
348 fBodyAccJerk-std()-X  
349 fBodyAccJerk-std()-Y  
350 fBodyAccJerk-std()-Z  
424 fBodyGyro-mean()-X  
425 fBodyGyro-mean()-Y  
426 fBodyGyro-mean()-Z  
427 fBodyGyro-std()-X  
428 fBodyGyro-std()-Y  
429 fBodyGyro-std()-Z  
503 fBodyAccMag-mean()  
504 fBodyAccMag-std()  
516 fBodyBodyAccJerkMag-mean()  
517 fBodyBodyAccJerkMag-std()  
529 fBodyBodyGyroMag-mean()  
530 fBodyBodyGyroMag-std()  
542 fBodyBodyGyroJerkMag-mean()  
543 fBodyBodyGyroJerkMag-std()  

mean() represents the calculated Mean Value and std() represents the calculated Standard Deviation


#### The set of 68 variables used to develop the tidy set after modifying the features' names to be more descriptive and their respective class are:

subject                                                    : int  
activity                                                   : Factor  
timeBodyAccelerometer-MeanValue()-X                        : num  
timeBodyAccelerometer-MeanValue()-Y                        : num  
timeBodyAccelerometer-MeanValue()-Z                        : num  
timeBodyAccelerometer-StandardDeviation()-X                : num  
timeBodyAccelerometer-StandardDeviation()-Y                : num  
timeBodyAccelerometer-StandardDeviation()-Z                : num  
timeGravityAccelerometer-MeanValue()-X                     : num  
timeGravityAccelerometer-MeanValue()-Y                     : num  
timeGravityAccelerometer-MeanValue()-Z                     : num  
timeGravityAccelerometer-StandardDeviation()-X             : num  
timeGravityAccelerometer-StandardDeviation()-Y             : num  
timeGravityAccelerometer-StandardDeviation()-Z             : num  
timeBodyAccelerometerJerk-MeanValue()-X                    : num  
timeBodyAccelerometerJerk-MeanValue()-Y                    : num  
timeBodyAccelerometerJerk-MeanValue()-Z                    : num  
timeBodyAccelerometerJerk-StandardDeviation()-X            : num  
timeBodyAccelerometerJerk-StandardDeviation()-Y            : num  
timeBodyAccelerometerJerk-StandardDeviation()-Z            : num  
timeBodyGyroscope-MeanValue()-X                            : num  
timeBodyGyroscope-MeanValue()-Y                            : num  
timeBodyGyroscope-MeanValue()-Z                            : num  
timeBodyGyroscope-StandardDeviation()-X                    : num  
timeBodyGyroscope-StandardDeviation()-Y                    : num  
timeBodyGyroscope-StandardDeviation()-Z                    : num  
timeBodyGyroscopeJerk-MeanValue()-X                        : num  
timeBodyGyroscopeJerk-MeanValue()-Y                        : num  
timeBodyGyroscopeJerk-MeanValue()-Z                        : num  
timeBodyGyroscopeJerk-StandardDeviation()-X                : num  
timeBodyGyroscopeJerk-StandardDeviation()-Y                : num  
timeBodyGyroscopeJerk-StandardDeviation()-Z                : num  
timeBodyAccelerometerMagnitude-MeanValue()                 : num  
timeBodyAccelerometerMagnitude-StandardDeviation()         : num  
timeGravityAccelerometerMagnitude-MeanValue()              : num  
timeGravityAccelerometerMagnitude-StandardDeviation()      : num  
timeBodyAccelerometerJerkMagnitude-MeanValue()             : num  
timeBodyAccelerometerJerkMagnitude-StandardDeviation()     : num  
timeBodyGyroscopeMagnitude-MeanValue()                     : num  
timeBodyGyroscopeMagnitude-StandardDeviation()             : num  
timeBodyGyroscopeJerkMagnitude-MeanValue()                 : num  
timeBodyGyroscopeJerkMagnitude-StandardDeviation()         : num  
frequencyBodyAccelerometer-MeanValue()-X                   : num  
frequencyBodyAccelerometer-MeanValue()-Y                   : num  
frequencyBodyAccelerometer-MeanValue()-Z                   : num  
frequencyBodyAccelerometer-StandardDeviation()-X           : num  
frequencyBodyAccelerometer-StandardDeviation()-Y           : num  
frequencyBodyAccelerometer-StandardDeviation()-Z           : num  
frequencyBodyAccelerometerJerk-MeanValue()-X               : num  
frequencyBodyAccelerometerJerk-MeanValue()-Y               : num  
frequencyBodyAccelerometerJerk-MeanValue()-Z               : num  
frequencyBodyAccelerometerJerk-StandardDeviation()-X       : num  
frequencyBodyAccelerometerJerk-StandardDeviation()-Y       : num  
frequencyBodyAccelerometerJerk-StandardDeviation()-Z       : num  
frequencyBodyGyroscope-MeanValue()-X                       : num  
frequencyBodyGyroscope-MeanValue()-Y                       : num  
frequencyBodyGyroscope-MeanValue()-Z                       : num  
frequencyBodyGyroscope-StandardDeviation()-X               : num  
frequencyBodyGyroscope-StandardDeviation()-Y               : num  
frequencyBodyGyroscope-StandardDeviation()-Z               : num  
frequencyBodyAccelerometerMagnitude-MeanValue()            : num  
frequencyBodyAccelerometerMagnitude-StandardDeviation()    : num  
frequencyBodyAccelerometerJerkMagnitude-MeanValue()        : num  
frequencyBodyAccelerometerJerkMagnitude-StandardDeviation(): num  
frequencyBodyGyroscopeMagnitude-MeanValue()                : num  
frequencyBodyGyroscopeMagnitude-StandardDeviation()        : num  
frequencyBodyGyroscopeJerkMagnitude-MeanValue()            : num  
frequencyBodyGyroscopeJerkMagnitude-StandardDeviation()    : num  



## Sources


Source of data files is http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones  
Data files are located at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Use of this dataset in publications must be acknowledged by referencing the following publication [1]   
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012