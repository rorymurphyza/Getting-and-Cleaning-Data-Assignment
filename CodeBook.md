#This is the Code Book for the Getting and Cleaning Data Course Project

A code book is a technical description of the data and the data structure.
The code book must reference the existing code books
The code book must show all variables and transformations that the data has gone through
Describe the structure of the data and what each variable means, what format the variables are in

##Scripts
###mergedata.R
The "mergedata()" R function will created the merged data set as read from the input file. The following steps are taken in order to create the merged data file:
1.  The training data is read from the file and saved in to the R environment. 
2.  The "y_train"" data is read in and combined with the training data file using the "bind_cols"" function as this data shows the activities that pertain to each row of training data.
3.  The "subject_test" file is read in and also combined with the training data using the "bind_cols" function as this data shows which subject generated the data shown in each row.
4.  The "features" data is read from the file and used to name the columns of the full data set to allow for an understanding of what each column of data means.
5. The above process is completed for the "test" data in order to create a similar, if different length, data frame.
6. The training data frame and the test data frame are combined using the "rbind" function is order to merge the two data sets.
7. Finally the data is the run through a transposition and cbind function that takes values in duplicate columns and sums them. This is the first part of tidying the data for analysis

The above merging operations give a final dataset for Task 1 of the assignment where we have the training and test datasets merged with the activity and subject lists as well as eachother. This results in a data frame of 10299 obervations of 563 variables which can be used for further analysis.

===============

###showstats.R
The "showstats" R script will take the output from the mergedata function and perform the following operations:
1.  A new data frame is created, showing the subject number and the activity for each row in the merged data set.
2.  The merged data set is then subsetted for any columns containing "mean" measurements and these columns are added to the data frame created in the previous step
3.  The merged data set is then subsetted for any columns contains "std" deviation measurements and these columns are added to the data frame from the previous step.
4.  The completed data frame showing the mean and standard deviation data is then returned by this function.

These operations give a new, subsetted data set that satisfies the requirements for Task 2 of the assignment. We now have a data set of 10299 observations of 86 variables.

===============

###addactivities.R
The "addactivities" R script will add the descriptive activities from the dataset to each required row in the given dataset. This will work for either the full dataset, mergeddata, or the statistical dataset, statsdata.
1.  The activities data file is read in to the environment in order to show the key:value pairs applicable.
2.  The given dataset is appended with the value of the activity description as applicable.

This operation gives a slightly extended data set to what was given as an input, showing clearly the activity description for each row of data in the set. This will satisfy the requirements of Task 3 of the assignment.

=================

###relabel.R
This function will relabel the columns in the full data set to give them more descriptive names for each variable.
Please note that the variable names for the dataset are already unique, as done in the mergedata.R script.
1.  Variable names containing time domain data, indicated by the "t" character, are changed to include the "td" notation to show that they are in the time domain
2.  Variable names containing the frequency domain data, indicated by the "f" character, are changed to include the "fd" notation to show that they are in the frequency domain
3.  All variable names are changed to lower case.
4.  All punctuation is removed from variable names

This operation will return the given data with more relevant data variable names which should satisfy the requirements of Assignment Task 4.

==========

###tidydata.R
This script will find the mean of each variable per subject number and activity and will create a new data set showing only this data. This new data set will then be tidied according to tidy data rules
1.  The merged data frame is subset by subject number and activity type and a new set is created with the averaged values of all the measurements
2.  The new data frame is tidied up by combining columns to ensure that only a single variable is included in each row.
This operation will complete the requirements for Assignment Task 5 and the assignment in itself.
