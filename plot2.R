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

# Create "Global Active Power" by date/time line chart.
# Sample usage: createPlot2(loadData("2007-02-01", "2007-02-02"))
createPlot2 <- function(dat) {
    png(file = "plot2.png", bg = "transparent")
    plot(dat[,c(2,3)], type = "l", xlab = "", 
         ylab = "Global Active Power (kilowatts)")
    dev.off()
}