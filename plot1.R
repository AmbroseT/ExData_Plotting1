exdata1 <- function(){
  ## Read data from text file.
  ## this assumes that the working directory is set so that the subfolder
  ## from the working directory is:
  ##
  ## /exdata-data-household_power_consumption
  ##
  ## Extraction of the file was done with default settings using WinRAR.
  ## The function read.table will read the text file with columns set to 
  ## character and numeric as apprpriate, and set the character "?" as
  ## NA wherever they are located.
  
  x <- read.table("./exdata-data-household_power_consumption/household_power_consumption.txt", 
                  sep=";", header=TRUE, stringsAsFactors=FALSE, na.strings ="?")
   
  ## The Date column will be converted to POSIX date format, so that the data
  ## can be subsetted to extract only data from Feb 1, 2007 and Feb 2, 2007
  
  x$Date <- as.Date(x$Date, format='%d/%m/%Y')
  y <- subset(x, (x$Date=="2007-02-01" | x$Date=="2007-02-02"))
  
  ## the following is a function to create the histogram plot of 
  ## Global_active_power column over time, as required from the assignment for 
  ## plot 1.  The following functions after will save the plot as a PNG file 
  ## as required, and then turn off the file graphics device.
  
  hist(y$Global_active_power,xlab = "Global Active Power (kilowatts)", 
       main = "Global Active Power", col = "red")
  dev.copy(png, file = "plot1.png", width = 480, height = 480)
  dev.off()
    
}