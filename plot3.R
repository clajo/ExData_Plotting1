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

with(d,plot(d$DateTime,d$Sub_metering_1,type="n",ylab="Energy sub metering",xlab=""))
lines(d$DateTime,d$Sub_metering_1)
lines(d$DateTime,d$Sub_metering_2, col="red")
lines(d$DateTime,d$Sub_metering_3, col="blue")
par(mar=c(5, 4, 2, 1))
legend('topright',legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1, cex=.75,col=c("black","red","blue"),text.width=43000)

dev.copy(png,"plot3.png",width=480,height=480,units="px",type = "cairo")
dev.off()

Sys.setlocale("LC_TIME",curr_locale)