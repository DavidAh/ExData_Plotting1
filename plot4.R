
plot4 <- function(){
  
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
      png("plot4.png", width=480, height=480)
      
      par (mfrow = c(2,2))
      par (mar = c(4,4,1,1))
      
      ## Create Global Active Power in the upper left hand corner.
      plot(x=Febdata$Date, 
           y = Febdata$Global_active_power, 
           type = "l",
           xlab = "",
           ylab = "Global Active Power (Kilowatts)")  
      
      ## Create the Voltage plot in the upper righthand corner.
      plot( x = Febdata$Date,
            y = Febdata$Voltage, 
            type = "l", 
            xlab = "datetime", 
            ylab = "Voltage")
      
      ##Create lower lefthand corner Energy submetering vs. Date/Time.
      plot(x=Febdata$Date, 
           y = Febdata$Sub_metering_1, 
           type = "n",
           xlab = "",
           ylab = "Energy sub metering")  
      
      lines(x=Febdata$Date, y=Febdata$Sub_metering_1, col="black")
      lines(x=Febdata$Date, y=Febdata$Sub_metering_2, col="red")
      lines(x=Febdata$Date, y=Febdata$Sub_metering_3, col="blue")
      
      legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
             ncol=1, xjust=1, yjust = 1, lty=1, lwd=2, 
             bty = "n",
             col = c("black", "red", "blue"), 
             text.font = 2, cex = .75)
      
      plot(x=Febdata$Date, 
           y = Febdata$Global_reactive_power, 
           type = "l",
           xlab = "datetime",
           ylab = "Global_reactive_power")  
      
      ## Close the PNG file (Graphics Device).
      dev.off()
  }
  else{
      ## print error message.
      print("Can't find the household_power_consumption.txt file! Exiting") 
  }
} ## end plot1