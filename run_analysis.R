#The main script for the assignment. This will call other scripts as required
run_analysis <- function()
{
  #Read the data from the data source
  source("readData.R")
  datalocation <- readdata("rawvalues.zip")
  
  #Merge the training and test data in to a single frame
  #This will satisfy Task 1 of the assignment
  source("mergedata.R")
  mergeddata <- mergedata(datalocation)
  
  #Find all columns with mean and std. dev.s in the data frame and return it.
  #This will satisfy Task 2 of the assignment
  source("showstats.R")
  statsdata <- showstats(mergeddata)
  
  #Add the descriptive activities name to the dataset provided.
  #The dataset could be either the full dataset or the subsetted dataset from "showstats"
  #In this case, we will use the statsdata dataset
  source("addactivities.R")
  mergeddata <- addactivities(statsdata, datalocation)
  
  #Give the data variables more descriptive names
  source("rename.R")
  mergeddata <- rename(mergeddata)
  
  #Tidy the data set according to tidy data rules.
  #The average of every variable for each activity is returned by the function
  source("tidydata.R")
  tidy <- tidydata(mergeddata, savetofile = TRUE)
}