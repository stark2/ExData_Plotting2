# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

# clear R environment
rm(list=ls())

# load required libraries
library(plyr)

# load datasets NEI and SCC
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")

# transform year to factor
NEI <- transform(NEI, year = factor(year))

# aggregate and prepare plot data 
s <- ddply(NEI, .(year), summarize, sum = sum(Emissions))

# create a plot and save it to png file
png("plot1.png")
with(s, plot(year, sum, type = "n", xlab = "Year", ylab = "Total PM2.5 emission", boxwex = 0, main = "Emissions decreased from 1999 to 2008"))
with(s, points(year, sum, pch = 20))
with(s, lines(year, sum))
dev.off()
