addactivities <- function(data, datalocation = "data/UCI HAR Dataset/", savetofile = FALSE)
{
  #Read the activites file to show the key:value pairs
  activities <- read.table(paste0(datalocation, "activity_labels.txt"), sep = "")
  
  #create a new column activitydesc and fill it with the key:value pair values from the activities set
  data$activitydesc <- activities[data$activity, 2]
  
  if (savetofile)
  {
    write.csv(data, file = "datawithactivities.csv")
  }
  else
  {
    return (data)
  }
}