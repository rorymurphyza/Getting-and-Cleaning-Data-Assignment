#This function takes the file name for the zip
#as a parameter
#It will return the location of the uncompressed folder
readdata <- function(fn = "rawvalues.zip")
{
  #The path of the .zip file used for this analysis
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  #Check if folder workspace/data exists, create it if not
  if (!file.exists("data"))
  {
    dir.create("data")
  }
  #Check if .zip has already been downloaded, only dowload if necessary
  if (!file.exists(paste0("data/", fn)))
  {
    download.file(url, paste0("data/", fn))
  }
  #Unzip the archive
  unzip(paste0("data/", fn), exdir = "data")
  return (paste0("data/", "UCI HAR Dataset/"))
}