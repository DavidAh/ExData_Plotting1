
plot3 <- function(){
  
  if (file.exists("household_power_consumption.txt")){

      ## Read in the data.
      colClasses <- c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")
      
      Febdata <- read.table("household_power_consumption.txt", 
                             header = TRUE,
                             sep = ";", 
                             na.strings = "?", 
                             colClasses = colClasses,
                             comment.char = "",
                             skip = 66637,
                             nrows = 2880,
                             stringsAsFactors=FALSE)

      names(Febdata) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
      
      ## Convert the date to a POSIXlt format.
      Febdata$Date <- strptime(paste(Febdata$Date,Febdata$Time), "%d/%m/%Y %H:%M:%S")
      
      ## Open the PNG file (Graphics Device) for saving the plot.
      png("plot3.png", width=480, height=480)
      
      ##Create the Plot.
      plot(x=Febdata$Date, 
           y = Febdata$Sub_metering_1, 
           type = "n",
           xlab = "",
           ylab = "Energy sub metering")  
      
      lines(x=Febdata$Date, y=Febdata$Sub_metering_1, col="black")
      lines(x=Febdata$Date, y=Febdata$Sub_metering_2, col="red")
      lines(x=Febdata$Date, y=Febdata$Sub_metering_3, col="blue")
      
      legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), ncol=1, xjust=1, lty=1, lwd=2, col = c("black", "red", "blue"), text.font = 2, cex = .75)
          
      ## Close the PNG file (Graphics Device).
      dev.off()
  }
  else{
      ## print error message.
      print("Can't find the household_power_consumption.txt file! Exiting") 
  }
} ## end plot1