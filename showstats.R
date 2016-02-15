showstats <- function(m, savetofile = FALSE)
{
  library(dplyr)
  #This function will essentially create a data frame that shows only mean or standard deviation data
  #This returned data file will also show the subject number and activity as reference
  statsdata <- NULL
  
  #select the subjectnum and activity as these are our primary key references at the moment
  statsdata <- select(m, subjectnum, activity)
  #Add only columns that show mean or std measurements
  statsdata <- m %>% select(contains("mean")) %>% bind_cols(statsdata)
  statsdata <- m %>% select(contains("std")) %>% bind_cols(statsdata)
  
  
  if (savetofile)
  {
    write.csv(statsdata, file = "statsdata.csv")
  }
  else
  {
    return (statsdata)
  }
}