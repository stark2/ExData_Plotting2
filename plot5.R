# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City? 

# clear R environment
rm(list=ls())

# load required libraries
library(plyr)
library(ggplot2)

# load datasets NEI and SCC
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")

# transform year and type to factor
NEI <- transform(NEI, type = factor(type), year = factor(year))

# filter NEI dataset 
NEI <- NEI[NEI$fips == "24510" & NEI$type == "ON-ROAD",]

# aggregate and prepare plot data 
s <- ddply(NEI, .(year), summarize, sum = sum(Emissions))

# create a plot and save it to png file
png("plot5.png")
ggplot(s, aes(year,sum)) + geom_point(size = 5, col = "steelblue") + labs(title = "PM2.5 emission from motor vehicle sources in Baltimore City", y = "Total PM2.5 emission each year", x = "Year")
dev.off()
