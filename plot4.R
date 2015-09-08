library(dplyr)
library(lubridate)
d<-read.table("../Data/household_power_consumption.txt",header=TRUE,sep=";",
              colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"),
              na.string="?")

d<-transform(d,Date=as.Date(strptime(Date,"%d/%m/%Y")))
d<-filter(d,Date=="2007-02-01" | Date=="2007-02-02")
d<-transform(d,DateTime=as.POSIXct(paste(d$Date, d$Time), format="%Y-%m-%d %H:%M:%S"))

curr_locale <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "C")
par(mfcol=c(2,2))
par(mar=c(5, 4, 1, 1))
with(d,plot(d$DateTime,d$Global_active_power,type="n",ylab="Global Active Power (kilowatts)",xlab=""))
lines(d$DateTime,d$Global_active_power)

with(d,plot(d$DateTime,d$Sub_metering_1,type="n",ylab="Energy sub metering",xlab=""))
lines(d$DateTime,d$Sub_metering_1)
lines(d$DateTime,d$Sub_metering_2, col="red")
lines(d$DateTime,d$Sub_metering_3, col="blue")
legend('topright',legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,cex=.5,col=c("black","red","blue"),bty="n",text.width=60000 )

with(d,plot(d$DateTime,d$Voltage,type="n",ylab="Voltage",xlab="datetime"))
lines(d$DateTime,d$Voltage)

with(d,plot(d$DateTime,d$Global_reactive_power,type="n",ylab="Global_reactive_power",xlab="datetime"))
lines(d$DateTime,d$Global_reactive_power)



#legend('topright',legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1, ,col=c("black","red","blue"))

dev.copy(png,"plot4.png",width=480,height=480,units="px",type = "cairo")
dev.off()

Sys.setlocale("LC_TIME",curr_locale)