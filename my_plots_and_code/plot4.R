# load the data

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
df <- read.csv(unz(temp, "household_power_consumption.txt"), sep=";")
unlink(temp)

# format the data
library(dplyr)
df <- tbl_df(df)
df$Date<-as.character(df$Date)
df$Date <- as.Date(df$Date, "%d/%m/%Y")
df <- filter(df, Date >= "2007-02-01" & Date <= "2007-02-02")
time <- paste(df$Date, df$Time)
time <- strptime(time, "%Y-%m-%d %H:%M:%S")
df <- select(df, 3:9)
df$datetime <- time

# create and save the plot
png("plot4.png", width=480, height=480, units="px")

par(mfrow=c(2,2), bg = "transparent")

## Plot 1
with(df,
     plot(datetime, as.numeric(Global_active_power),
          type="l",
          ylab="Global Active Power",
          xlab=NA))

## Plot 2
plot(df$datetime, df$Voltage, type="l", xlab=NA, ylab="Voltage")

## Plot 3
plot(df$datetime, as.numeric(df$Sub_metering_1),
     type="l",
     ylab="Energy sub metering",
     xlab=NA)
lines(df$datetime, as.numeric(df$Sub_metering_2), col="red")
lines(df$datetime, as.numeric(df$Sub_metering_3), col="blue")
legend("topright",
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=c(1,1,1),
       col=c("black", "red", "blue"),
       cex=0.7)

## Plot 4
plot(df$datetime, df$Global_reactive_power, type="l", xlab=NA, ylab="Global_reactive_power")

dev.off()