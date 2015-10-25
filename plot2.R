# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

# clear R environment
rm(list=ls())

# load required libraries
library(plyr)

# load datasets NEI and SCC
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")

# transform year to factor
NEI <- transform(NEI, year = factor(year))

# filter NEI dataset 
NEI <- NEI[NEI$fips == "24510",]

# aggregate and prepare plot data 
s <- ddply(NEI, .(year), summarize, sum = sum(Emissions))

# create a plot and save it to png file
png("plot2.png")
with(s, plot(year, sum, type = "n", xlab = "Year", ylab = "Total PM2.5 emission", boxwex = 0, main = "Emissions in Baltimore City"))
with(s, points(year, sum, pch = 20))
with(s, lines(year, sum))
dev.off()
