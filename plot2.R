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

with( hhpwr, plot(tstamp, Global_active_power
                  , type='l' 
                  ,ylab='Global Active Power (kilowatts)'
                  ,xlab='') 
)

dev.copy(png, 'plot2.png')
dev.off()