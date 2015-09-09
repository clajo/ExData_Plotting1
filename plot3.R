library(dplyr)

#Read data from file
d<-read.table("../Data/household_power_consumption.txt",header=TRUE,sep=";",
              colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"),
              na.string="?")

#Transform date column into dataformat
d<-transform(d,Date=as.Date(strptime(Date,"%d/%m/%Y")))
#Filter data
d<-filter(d,Date=="2007-02-01" | Date=="2007-02-02")
#Add new column with Date and time as POSIXct
d<-transform(d,DateTime=as.POSIXct(paste(d$Date, d$Time), format="%Y-%m-%d %H:%M:%S"))

#Change system time setting, to get english names
curr_locale <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "C")

#Open graphic device png
png(file="plot3.png",width=480,height=480,units="px")

#Plot line chart
par(mfcol=c(1,1))
with(d,plot(d$DateTime,d$Sub_metering_1,type="n",ylab="Energy sub metering",xlab=""))
lines(d$DateTime,d$Sub_metering_1)
lines(d$DateTime,d$Sub_metering_2, col="red")
lines(d$DateTime,d$Sub_metering_3, col="blue")
#Margins
par(mar=c(5, 4, 2, 1))
#Legend
legend('topright',legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1, col=c("black","red","blue"))

#Close graphic device
dev.off()

#Set the system time back to original setting
Sys.setlocale("LC_TIME",curr_locale)