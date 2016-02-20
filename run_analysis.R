#The main script for the assignment. This will call other scripts as required
run_analysis <- function()
{
  #Read the data from the data source
  #The path of the .zip file used for this analysis
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  #Check if folder workspace/data exists, create it if not
  if (!file.exists("data"))
  {
    dir.create("data")
  }
  #Check if .zip has already been downloaded, only dowload if necessary
  if (!file.exists(paste0("data/", "rawvalues.zip")))
  {
    download.file(url, paste0("data/", "rawvalues.zip"))
  }
  #Unzip the archive
  unzip(paste0("data/", "rawvalues.zip"), exdir = "data")
  datalocation <- "data/UCI HAR Dataset/"
  
  #Merge the training and test data in to a single frame
  #This will satisfy Task 1 of the assignment
  library(dplyr)
  #Read in the training data (X_train), the activity data (y_train), the column heads (features) and the subject numbers (subject_train)
  train_X_train <- read.table(paste0(datalocation, "train/X_train.txt"), sep = "")
  train_y_train <- read.table(paste0(datalocation, "train/y_train.txt"), sep = "")
  subject_train <- read.table(paste0(datalocation, "train/subject_train.txt"), sep = "")
  features <- read.table(paste0(datalocation, "features.txt"), sep = "")
  #Set features as the column headers for train_X_train
  names(train_X_train) <- features$V2
  #Add row header for subject_train and train_y_train
  names(subject_train) <- "subjectnum"
  names(train_y_train) <- "activity"
  #Merge the activity references in to the training set, updating the training set
  train_X_train <- bind_cols(train_y_train, train_X_train)
  #Merge the subject numbering in to the training set, updating the training set
  train_X_train <- bind_cols(subject_train, train_X_train) 
  #Read in the test data (X_test), the activity data and the subject numbers (subject_test)
  test_X_test <- read.table(paste0(datalocation, "test/X_test.txt"), sep = "")
  test_y_test <- read.table(paste0(datalocation, "test/y_test.txt"), sep = "")
  subject_test <- read.table(paste0(datalocation, "test/subject_test.txt"), sep = "")
  #Set features as the column headers for test_X_test
  names(test_X_test) <- features$V2
  #Add row header for subject_test and test_y_test
  names(subject_test) <- "subjectnum"
  names(test_y_test) <- "activity"
  #Merge the activity reference in to the testing set, updating the testing set
  test_X_test <- bind_cols(test_y_test, test_X_test)
  #Merge the subject numbering in to the testing set, updating the testing set
  test_X_test <- bind_cols(subject_test, test_X_test)
  #Merge the test data and the training data in to the same data frame
  mergeddata <- rbind(test_X_test, train_X_train)
  #temp <- mergeddata
  #names(temp) <- names(mergeddata)
  #temp <- t(temp)
  #mergeddata <- by(temp, INDICES = row.names(temp), FUN = colSums)
  #mergeddata <- as.data.frame(do.call(cbind, mergeddata))
  rm(features, subject_test, subject_train,
     test_X_test, test_y_test, train_X_train,
     train_y_train)
  
  
  #Find all columns with mean and std. dev.s in the data frame and return it.
  #This will satisfy Task 2 of the assignment and is detailed by CodeBook step 5
  temp <- mergeddata[, c("subjectnum", "activity")]
  mergeddata <- bind_cols(temp, mergeddata[, grep("-(std|mean)\\(\\)", names(mergeddata), value=TRUE)])
  rm(temp)
  
  
  #Add the descriptive activities name to the dataset provided.
  activities <- read.table(paste0(datalocation, "activity_labels.txt"), sep = "")
  #Create a new column activitydesc and fill it with the key:value pair values from the activities set
  mergeddata$activity <- activities[mergeddata$activity, 2]
  rm(activities)
  
  #Give the data variables more descriptive names
  #This has already been done in previous steps
  
  
  #Tidy the data set according to tidy data rules.
  tidydata <- ddply(mergeddata, .(subjectnum, activity), function(x) colMeans(x[,3:68]))
  
  #Write the tidy data set to an output file
  write.table(tidydata, file="TidiedData.txt", row.name = FALSE)
}