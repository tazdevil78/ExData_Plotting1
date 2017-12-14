filenm <- 'household_power_consumption.txt'
rt <- file(filenm, "r")
txt <- readLines(rt, n=1)
close(rt)
colnm <- unlist(strsplit(txt, ';'))
rm(txt, rt)

hhpwr <- read.delim(filenm, col.names=colnm
                    ,skip=66637, nrows=2880
                    ,na.strings='?', sep=';'
                    ,header=F, stringsAsFactors=F )
rm(colnm, filenm)

hhpwr <- within( hhpwr, {
  date <- as.Date(Date, "%d/%m/%Y")
  tstamp <- paste(Date, Time)
  tstamp <- strptime(tstamp, '%d/%m/%Y %H:%M:%S')
})

par(mfcol=c(2,2))

with( hhpwr, plot(tstamp, Global_active_power
                  , type='l' 
                  ,ylab='Global Active Power (kilowatts)'
                  ,xlab='') 
)

with( hhpwr, {
  plot(tstamp, Sub_metering_1
       ,type='l'
       ,ylab='Energy sub metering'
       ,xlab='')
  lines(tstamp, Sub_metering_2, col='red')
  lines(tstamp, Sub_metering_3, col='blue')
  legend('topright'
         ,legend=colnames(hhpwr)[7:9] 
         ,col=c('black','red','blue')
         ,lty=c(1,1)
         ,lwd=c(2.5,2.5))
})

with( hhpwr, plot(tstamp, Voltage, type='l', xlab='datetime') )

with( hhpwr, plot(tstamp, Global_reactive_power, type='l', xlab='datetime') )

dev.copy(png, 'plot4.png')
dev.off()