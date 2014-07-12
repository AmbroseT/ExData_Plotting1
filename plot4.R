exdata4 <- function(){
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
  
  ## The following lines of code will combine the Date and Time columns,
  ## convert them to POSIX date and time (as opposed to just date), then
  ## column bind them to the data set.  This will allow easier plotting
  ## of the many many points from the time, instead of just the date.
  
  date <- y$Date
  time <- y$Time
  datetime <- paste(date,time)
  datetime <- strptime(datetime, "%Y-%m-%d %H:%M:%S")
  y <- cbind(y, dateTime=datetime)
  
  ## the following line of code sets the graphics device for 4 
  ## simultaneous plots, drawn columnwise.
  par(mfcol = c(2, 2))
  
  ## The following lines of code draws each of the 4 plots, as required
  ## from the assignment for plot 4. The following functions after will 
  ## save the plot as a PNG file as required, and then turn off the file 
  ## graphics device.
  
  ## First Plot
  with(y, plot(dateTime, Global_active_power, xlab="",
               ylab="Global Active Power", cex.lab=0.7, 
               cex.axis=0.7, type = "n"))
  with(y, lines(dateTime, Global_active_power))
    
  ## Second Plot
  with(y, plot(dateTime, Sub_metering_1, xlab="", 
               ylab="Energy sub metering", cex.lab=0.7, 
               cex.axis=0.7, type = "n"))
  with(y, lines(dateTime, Sub_metering_1))
  with(y, lines(dateTime, Sub_metering_2, col = "red"))
  with(y, lines(dateTime, Sub_metering_3, col = "blue"))
  
  legend("topright", lty=1, legend = 
           c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
         col = c("black","red","blue"), cex = 0.65, bty = "n", 
         y.intersp = 0.2)
  
  ## Third Plot
  with(y, plot(dateTime, Voltage, xlab="datetime",
                 ylab="Voltage", cex.lab=0.7, cex.axis=0.7, type = "n"))
  with(y, lines(dateTime, Voltage))
  
  ## Fourth Plot
  with(y, plot(dateTime, Global_reactive_power, xlab="datetime", 
               cex.lab=0.7, cex.axis=0.7, type = "n"))
  with(y, lines(dateTime, Global_reactive_power))
  
  dev.copy(png, file = "plot4.png", width = 480, height = 480)
  dev.off()
  
}