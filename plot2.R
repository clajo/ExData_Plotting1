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
with(d,plot(d$DateTime,d$Global_active_power,type="n",ylab="Global Active Power (kilowatts)",xlab=""))
lines(d$DateTime,d$Global_active_power)


# hist(d$Global_active_power,col="red",main="Global Active Power", xlab="Global Active Power (kilowatts)")
 dev.copy(png,"plot2.png",width=480,height=480,units="px",type = "cairo")
dev.off()

Sys.setlocale("LC_TIME",curr_locale)