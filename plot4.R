# first read in file and address problem of missing values
hpc <- read.table("household_power_consumption.txt", na.strings = "?", header = TRUE, sep = ";")
# convert Date to dateformat
hpc$Date <- as.Date(hpc$Date, format = "%d/%m/%Y")
# fix timeproblem
hpc$timetemp <- paste(hpc$Date, hpc$Time)
hpc$Time <- strptime(hpc$timetemp, format = "%Y-%m-%d %H:%M:%S")
# select only specific dates
hpc <- hpc[hpc$Date >= "2007-02-01" & hpc$Date <= "2007-02-02",]

# the days of the week are shown Dutch, so to solve that
Sys.setlocale("LC_TIME", "C")

# make plot4
png(file = "plot4.png")
par(mfrow = c(2,2))
plot(hpc$Time, hpc$Global_active_power, type = "l",
     xlab = "", ylab = "Global Active Power")
plot(hpc$Time, hpc$Voltage, type = "l",
     xlab = "datetime", ylab = "Voltage")
plot(hpc$Time, hpc$Sub_metering_1, type = "n",
     xlab = "", ylab = "Energy sub metering")
lines(hpc$Time, hpc$Sub_metering_1)
lines(hpc$Time, hpc$Sub_metering_2, col = "red")
lines(hpc$Time, hpc$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1, bty = "n", col = c("black", "red", "blue"))
plot(hpc$Time, hpc$Global_reactive_power, type = "l",
     xlab = "datetime", ylab = "Global_reactive_power")
dev.off()
