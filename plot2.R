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

# make plot2
png(file = "plot2.png")
plot(hpc$Time, hpc$Global_active_power, type = "l",
     xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()
