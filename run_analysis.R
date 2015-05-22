## Part 1 ==>> Access, download and unzip data files
## Source of files is http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
## Data files located at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
## Accessed data via http:// rather than https:// to support knitting the script
## 1 - Download the zipped file and put it in the "data" folder using download.file function

    if(!file.exists("./data")){
      dir.create("./data")
    }
    fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

## download.file(fileUrl,destfile="./data/Dataset.zip",method="curl") ===>>> don't need method="curl" on Windows Platform

    download.file(fileUrl, destfile="./data/Dataset.zip", mode = "wb")

## 2 - Unzip the file using unzip function

    unzip("./data/Dataset.zip", exdir="./data")
    list.files("./data")

## Shows unzipped files are in the folder ./data/UCI HAR Dataset
## 3 - Get the list of the data files using list.files function

    files<-list.files("./data/UCI HAR Dataset", recursive=TRUE)
    files

## Shows all of the files available for the project
## The data files that will be used are:
## Inertial Signals folders not included since they do not contain data applicable to this project
## test/subject_test.txt ==>> each row identifies the subject number (30%/9 subjects = 2,4,9,10,12,13,18,20,24)
## test/X_test.txt ==>> Test data set, 2947 observations (data for each feature associated with each activity
  ## performed by each test subject)
## test/y_test.txt ==>> Test labels (activity numbers where==>>1=walking,2=walking upstairs,3=walking downstairs,
  ## 4=sitting,5=standing,6=lying)
## train/subject_train.txt ==>> each row identifies the subject number
  ## (70%/21 subjects = 1,3,5,6,7,8,11,14,15,16,17,19,21,22,23,25,26,27,28,29,30)
## train/X_train.txt ==>> Training data set, 7352 observations (data for each feature associated with each activity
  ## performed by each training subject)
## train/y_train.txt ==>> Training labels (activity numbers where==>>1=walking,2=walking upstairs,3=walking downstairs,
  ## 4=sitting,5=standing,6=lying)
## activity_labels.txt ==>> activity number and name (1=walking,2=walking upstairs,3=walking downstairs,4=sitting,
  ## 5=standing,6=lying)
## features.txt ==>> 561 features names, these are the column names to be used (aka variables)



## Part 2 ==>> Read the data from the files
## Three major variables ==>> SUBJECT performing the activity, ACTIVITY being performed and the associated
  ## FEATURE DATA collected
## SUBJECT data comes from subject_train.txt and subject_test.txt and it is only a subject number 1 - 30
## ACTIVITY data comes from y_train.txt and y_test.txt and it is only an activity number 1 - 6 and
  ## the activity name associated with the activity number comes from activity_labels.txt
## FEATURE DATA comes from X_train.txt and X_text.txt and it is only the raw data and
  ## the names of the features comes from features.txt
## 1 - Read data from the associated files into the corresponding major variable using read.table function
## 1a - Read the SUBJECT files

    SubjectTest  <- read.table(file.path("./data/UCI HAR Dataset", "test" , "subject_test.txt" ),header = FALSE)
    SubjectTrain <- read.table(file.path("./data/UCI HAR Dataset", "train", "subject_train.txt"),header = FALSE)

## 1b - Read the ACTIVITY files

    ActivityTest  <- read.table(file.path("./data/UCI HAR Dataset", "test" , "Y_test.txt" ),header = FALSE)
    ActivityTrain <- read.table(file.path("./data/UCI HAR Dataset", "train", "Y_train.txt"),header = FALSE)

## 1c - Read FEATURE DATA files

    FeatureDataTest  <- read.table(file.path("./data/UCI HAR Dataset", "test" , "X_test.txt" ),header = FALSE)
    FeatureDataTrain <- read.table(file.path("./data/UCI HAR Dataset", "train", "X_train.txt"),header = FALSE)

## 2 - Review the properties of these 6 new objects using str function

    str(SubjectTest)

## shows 2947 observations and 1 variable (subject number from test group)

    str(SubjectTrain)

## shows 7352 observations and 1 variable (subject number from training group)

    str(ActivityTest)

## shows 2947 observations and 1 variable (activity number)

    str(ActivityTrain)

## shows 7352 observations and 1 variable (activity number)

    str(FeatureDataTest)

## shows 2947 observations and 561 variables (561 features)

    str(FeatureDataTrain)

## shows 7352 observations and 561 variables (561 features)



## Part 3 - Merge the training and the test sets to create one data set (AllData)
## ***Satisfies Getting and Cleaning Data Project Step 1***
## 1 - Combine rows of related data sets using rbind function
## 1a - Combine all rows of Subject, Activity and Feature data sets respectively and establish column (aka variable) names

    SubjectCombined <- rbind(SubjectTest, SubjectTrain)
    ActivityCombined <- rbind(ActivityTest, ActivityTrain)
    FeatureDataCombined <- rbind(FeatureDataTest, FeatureDataTrain)

## 1b - Establish the column names (aka variable names) for each combined data set

    names(SubjectCombined) <- c("subject")
    names(ActivityCombined) <- c("activity")

## Must first extract features names from features.txt and then assign those to the combined features data set
  ## columns (aka variables)

    FeaturesNames <- read.table(file.path("./data/UCI HAR Dataset", "features.txt" ),header = FALSE)
    head(FeaturesNames)

## Shows 2 columns (V1 and V2) where V2 is the actual features names

    names(FeatureDataCombined) <- FeaturesNames$V2

## Test success by showing the head of the combined data files
    
    head(SubjectCombined)
    head(ActivityCombined)
    head(FeatureDataCombined)  
    
## 2 - Combine all columns of the combined Subject, Activity and Feature data sets using cbind function
  ## to create one composite data set (AllData)

    AllData <- cbind(SubjectCombined, ActivityCombined, FeatureDataCombined)

## Review the properties of the new object representing all data from all files using str function

    str(AllData)

## Shows individual combined data files have been successfully combined into a singular object with correct variable names
  ## and shows 10299 observation (2947 from test + 7352 from train) and 563 variables (subject+Activity+561 features)



## Part 4 - Extract only the measurements on the mean and standard deviation for each measurement (FinalData)
## ***Satisfies Getting and Cleaning Data Project Step 2***
## 1 - Extract desired column/variable names from list of features names (FeaturesNames column 2) created in Part 3 above
  ## using grep function to match desired variables - mean() and std()

    Desired <- FeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", FeaturesNames$V2)]
    class(Desired)

## 2 - Create object consisting of subject, activity and desired features and change "Desired" from factor to character

    SubsetAllData <- c("subject", "activity", as.character(Desired))

## 3 - Subset AllData to create data set (FinalData) of desired data variables by selecting only those variables defined
  ## in SubsetAlldata

    FinalData <- subset(AllData, select = SubsetAllData)

## Review properties of FinalData

    str(FinalData)

## shows 10299 observation (2947 from test + 7352), 68 variables (subject+Activity+(8 featuresx6+9 featuresx2) representing
  ## mean and std variables only


    
## Part 5 - Use descriptive activity names to name the activities in the data set
## ***Satisfies Getting and Cleaning Data Project Step 3***
## The activity names come from activity_labels.txt
## 1 - Extract activity names from activity_labels.txt and then assign those to the activity column values in FinalData
  ## using the factor function
      
    ActivityNames <- read.table(file.path("./data/UCI HAR Dataset", "activity_labels.txt" ),header = FALSE)
    head(ActivityNames, 6)

## Shows two columns (V1 and V2) containing the activity number (V1) and activity name (V2)
    
    colnames(ActivityNames) <- c("activitynumber", "activityname")
    FinalData$activity <- factor(FinalData$activity, levels = ActivityNames$activitynumber, labels = ActivityNames$activityname)
    head(FinalData$activity, 60)

## Shows the activity numbers have been successfully changed to the corresponding activity names
## Review properties of FinalData

    str(FinalData)

## shows that the activity column is now a factor with 6 levels matching the actual names of the activities


    
## Part 6 - Appropriately label the data set with descriptive variable names
## ***Satisfies Getting and Cleaning Data Project Step 4***
## The variable names in the data set (FinalData) come from features.txt and are abbreviations of the actual features
  ## (aka variables)

    names(FinalData)

## Shows abbreviated variable names
## Replace abbreviations with descriptive names using gsub function
## For all variables starting with "t", change this to "time"
## For all variables with "Acc", change this to "Accelerometer"
## For all variables with "mean()", change this to "MeanValue"
## For all variables with "std()", change this to "StandardDeviation"
## For all variables with "Gyro", change this to "Gyroscope"
## For all variables with "Mag", change this to "Magnitude"
## For all variables starting with "f", change this to "frequency"
## For all variables with "BodyBody", change this to "Body"

    names(FinalData) <- gsub("^t", "time", names(FinalData))
    names(FinalData) <- gsub("Acc", "Accelerometer", names(FinalData))
    names(FinalData) <- gsub("mean()", "MeanValue", names(FinalData))
    names(FinalData) <- gsub("std()", "StandardDeviation", names(FinalData))
    names(FinalData) <- gsub("Gyro", "Gyroscope", names(FinalData))
    names(FinalData) <- gsub("Mag", "Magnitude", names(FinalData))
    names(FinalData) <- gsub("^f", "frequency", names(FinalData))
    names(FinalData) <- gsub("BodyBody", "Body", names(FinalData))

## Check results

    names(FinalData)

## Shows descriptive variable names applied

    str(FinalData)

## Shows descriptive variable names have been applied   



## Part 7 - From the data set in step 4 (Part 6 above), create a second, independently tidy data set with the average
  ## of each variable for each activity and each subject and create a txt file using write.table function for uploading
## ***Satisfies Getting and Cleaning Data Project Step 5***
## The tidy data set (FDtidy) will be established using the aggregate function in the plyr package thus creating a wide set
## From str(FinalData) we can see that only the measurement variables are numeric and therefore these are the only
  ## variables that are aggregated (columns 3 thru 68 of FinalData) and then averaged to estabish their respective mean values
  ## but they are aggregated by the first two columns (subject and activity) before the the mean function is applied

    library(plyr);
    FDtidy<-aggregate(. ~subject + activity,FinalData, mean)
    head(FDtidy)

## Shows the column names are proper and the data has been successfully aggregated and the data variables are now summarized
  ## and the mean function has been applied

    FDtidy<-FDtidy[order(FDtidy$subject,FDtidy$activity),]
    head(FDtidy, 13)

## Shows data is now arranged by subject number first in sequence and each subject has 6 activities listed

    str(FDtidy)

## Shows data is now tidy with 180 observations (30 subjects x 6 activities each)
  ## and 68 variables (subject + activity + 66 measurement variables associated with each combination of subject & activity)

    write.table(FDtidy, file = "./data/tidydata.txt", row.name = FALSE)
    list.files("./data")

## Shows tidydata.txt file has been created and is stored in the "data" folder along with the other files 
  ## applicable to this project