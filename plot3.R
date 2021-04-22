library(data.table)
library(lubridate)

data <- read.table(paste(getwd(), "household_power_consumption.txt", sep="/"),
                   header=TRUE, na.strings = "?", sep=';', row)

dates <- paste(data$Date, data$Time, sep=" ")
data$datetime <- dmy_hms(dates)

data <- data[(data$Date == "1/2/2007") | (data$Date == "2/2/2007"), ]
row.names(data) <- NULL

# Plot 3
with(data,
     plot(Sub_metering_1 ~ datetime,
                type = 'l',
                ylab = "Energy sub metering",
                xlab = ""
                ))
lines(data$Sub_metering_2 ~ data$datetime, col = 'red', type = 'l')
lines(data$Sub_metering_3 ~ data$datetime, col = 'blue', type = 'l')
legend(x = "topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c('black', 'red', 'blue'),
       lty = c("solid", "solid", "solid"))

dev.copy(png, file='plot3.png')
dev.off()
