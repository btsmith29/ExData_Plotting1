# Load consumption data, assumed to be available locally in 
# 'household_power_consumption.txt', between given start and end dates (inc.)
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# 
# Fuller treatment would include downloading the file from the above location,
# unzipping and then generating the plots, but this is out of scope.
#
# Sample usage: d <- loadData("2007-02-01", "2007-02-02")
loadData <- function(sd, ed) {
    # For faster reading, could have used 'fread' to create a data table but
    # haven't used here in case others haven't taken 'Obtaining & Cleaning Data'
    dat <- read.table("household_power_consumption.txt", header = TRUE,
                      sep = ";", na.strings = c("?"), stringsAsFactors = FALSE)
    
    # Parse & filter dates
    dat$Date <- as.Date(dat$Date, "%d/%m/%Y")
    dat <- dat[dat$Date >= as.Date(sd) & dat$Date <= as.Date(ed),]
    
    # Convert time to date/time
    dat$Time <- strptime(paste(dat$Date, dat$Time), "%Y-%m-%d %H:%M:%S")
    
    dat
}

# Create 2x2 chart compilation.
# Sample usage: createPlot4(loadData("2007-02-01", "2007-02-02"))
createPlot4 <- function(dat) {
    png(file = "plot4.png", bg = "transparent")
    par(mfrow = c(2, 2))
    with(dat, {
        plot(Time, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
        plot(Time, Voltage, type = "l", xlab = "datetime")
        plot(Time, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
        lines(Time, Sub_metering_1, col = "black")
        lines(Time, Sub_metering_2, col = "red")
        lines(Time, Sub_metering_3, col = "blue")
        legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), box.lty = 0)
        plot(Time, Global_reactive_power, type = "l", xlab = "datetime")
    })
    dev.off()
}