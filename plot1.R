library(data.table)
library(lubridate)

data <- read.table(paste(getwd(), "household_power_consumption.txt", sep="/"),
                   header=TRUE, na.strings = "?", sep=';', row)

dates <- paste(data$Date, data$Time, sep=" ")
data$datetime <- dmy_hms(dates)

data <- data[(data$Date == "1/2/2007") | (data$Date == "2/2/2007"), ]
row.names(data) <- NULL

# Plot 1
with(data, hist(Global_active_power,
                col='red',
                xlab="Global Active Power (kilowatts)",
                main="Global Active Power"))
dev.copy(png, file='plot1.png')
dev.off()
