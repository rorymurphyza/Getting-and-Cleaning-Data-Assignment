#This function will receive the location of the data and will merge all data files in to a single dataset for use
mergedata <- function(datalocation = "data/UCI HAR Dataset/", savetofile = FALSE)
{
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
  
  #mergeddata <- sapply(unique(names(mergeddata)), function (x)
    #                    unname(unlist(mergeddata[, names(mergeddata) == x])))
  temp <- mergeddata
  names(temp) <- names(mergeddata)
  temp <- t(temp)
  mergeddata <- by(temp, INDICES = row.names(temp), FUN = colSums)
  mergeddata <- as.data.frame(do.call(cbind, mergeddata))
  
  if (savetofile)
  {
    write.csv(mergeddata, file = "mergeddata.csv")
  }
  else
  {
    return (mergeddata)
  }
}