#This is the Code Book for the Getting and Cleaning Data Course Project

A code book is a technical description of the data and the data structure.
The code book must reference the existing code books
The code book must show all variables and transformations that the data has gone through
Describe the structure of the data and what each variable means, what format the variables are in

==============
#run_analysis.R
This is the main workhorse function that will read the data, process it and then tidy it according to tidy data rules.

===============
#Data and Data Structure
##Raw Data
Raw data is taken from the UCI HAR Dataset found at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and downloaded 20/02/2016.

##Data Processing

1. The data from the training and test folders are read in to temporary files that are labelled according to their source
2. The training data set is combined with the relevant subject number set and activity set to create the train_X_train set. The relevant features file is used as the naming structure for this data frame.
3. The test data set is similarly combined with the relevant files to create the test_X_test data frame.
4. The train_X_train set is row binded to the test_X_test set in order to create the full data frame named mergeddata. At this point, all other data frames are discarded.
5. The mergeddata frame is then subsetted by selecting only columns with mean or standard deviation values in them.
6. The activities description file is read from the dataset and the mergeddata activity column is updated to show the activity description rather than simply the number.
7. At this point, the data set already has descriptive names and no new additions are required.
8. The data set is now tidied using the ddply function which is designed for this and saved in to the data frame tidydata.

The output dataset, currently named tidydata, shows a tidy data set that meets the requirements of the Assignment to this point. This data set is written to a text file called "TidiedData.txt", which can be used for further analysis.