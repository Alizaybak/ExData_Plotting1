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
png("plot2.png", width=480, height=480, units="px")

par(bg = "transparent")
with(df,
     plot(datetime, as.numeric(Global_active_power),
          type="l",
          main="Global Active Power",
          ylab="Global Active Power (kilowatts)",
          xlab=NA))

dev.off()