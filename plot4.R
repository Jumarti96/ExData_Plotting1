library(data.table)
library(lubridate)

data <- read.table(paste(getwd(), "household_power_consumption.txt", sep="/"),
                   header=TRUE, na.strings = "?", sep=';', row)

dates <- paste(data$Date, data$Time, sep=" ")
data$datetime <- dmy_hms(dates)

data <- data[(data$Date == "1/2/2007") | (data$Date == "2/2/2007"), ]
row.names(data) <- NULL

# Plot 4
## Set parameters
par(mfrow = c(2, 2))

## Mini plot 1
with(data, plot(Global_active_power ~ datetime,
                type = 'l',
                ylab = "Global Active Power",
                xlab = ""
))

## Mini plot 2
with(data, plot(Voltage ~ datetime,
                type = 'l',
                ylab = 'Voltage',
                xlab = 'datetime'))

## Mini plot 3
with(data,
     plot(Sub_metering_1 ~ datetime,
          type = 'l',
          ylab = "Energy sub metering",
          xlab = "",
     ))
lines(data$Sub_metering_2 ~ data$datetime, col = 'red', type = 'l')
lines(data$Sub_metering_3 ~ data$datetime, col = 'blue', type = 'l')
legend(x = "topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c('black', 'red', 'blue'),
       lty = c("solid", "solid", "solid"),
       cex = 0.75,
       bty = 'n')
## Mini plot 4
with(data, plot(Global_reactive_power ~ datetime,
                type = 'l',
                lwd = 1))


dev.copy(png, file='plot4.png')
dev.off()
