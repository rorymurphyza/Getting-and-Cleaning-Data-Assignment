tidydata <- function(m, savetofile = FALSE)
{
  #This function takes in the renamed mergeddata set and finds the average of each variable for each subject and each activity
  #This will then be tidied according to the tidy data rules and returned
  #Sort the data, first by subject number, then by activity
  m <- m[order(m$subjectnum, m$activity), ]
  
  #Drop the activitydesc column as it is not required here
  m <- select(m, -activitydesc)
  
  #Create the return data set
  avedata <- as.data.frame(setNames(replicate(length(names(m)), numeric(0), simplify = F), 
                                    names(m)))
  
  #Subset the data on subjectnum
  for (j in 1:30)
  {  
    temp <- m %>% filter(subjectnum == j) 
    for (i in 1:6)
    {
      temp2 <- temp %>% filter(activity == i)
      temp2 <- colMeans(temp2[, sapply(temp2, is.numeric)])
      avedata[((j - 1) * 6) + i, ] <- temp2
    }
  }
  
  library(tidyr)
  #Now we want to tidy the avedata set
  #Gather all gravitymean variables together to simplify the data set
  avedata <- avedata %>% gather(key = gravitymean, value = gravitymeanvalue, grep("gravitymean", names(avedata)))
  #Remove gravitymean notation from values
  avedata$gravitymean <- gsub(",gravitymean", "", avedata$gravitymean)
  
  #Gather all gravity variables together to simplify the data set
  avedata <- avedata %>% gather(key = gravity, value = gravityvalue, grep("gravity", names(avedata)))
  avedata$gravity <- gsub(",gravity", "", avedata$gravity)
  
  if(savetofile)
    write.table(m, file="tidydata.csv", row.name = FALSE)
  else
    return(m)
}