rename <- function(m, savetofile = FALSE)
{
  #This function will make the variable names more descriptive
  #Please note that the variable names are already unique, as done earlier in the process
  
  #Drop the "angle" notation
  names(m) <- gsub("angle", "", names(m))
  
  #Remove brackets
  names(m) <- gsub("\\(", "", names(m))
  names(m) <- gsub("\\)", "", names(m))
  
  #Add td notation to show time domain
  names(m) <- gsub("^t", "td", names(m))
  #Add fd notation to show frequency domain
  names(m) <- gsub("^f", "fd", names(m))
  
  #Convert all variable names to lower case
  names(m) <- tolower(names(m))
  
  #Remove all punctuation from variable names
  names(m) <- gsub("[[:punct:]]", "", names(m))
  
  if (savetofile)
  {
    write.csv(m, file = "prettyset.csv")
  }
  else
  {
    return (m)
  }
}