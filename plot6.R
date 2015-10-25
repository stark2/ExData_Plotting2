# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

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
NEI <- NEI[(NEI$fips == "24510" | NEI$fips == "06037") & NEI$type == "ON-ROAD",]

# set city names for better visualisation
NEI$city[NEI$fips == "24510"] <- "Baltimore"
NEI$city[NEI$fips == "06037"] <- "LA"

# aggregate and prepare plot data 
s <- ddply(NEI, .(year, city), summarize, sum = sum(Emissions))

# create a plot and save it to png file
png("plot6.png")
ggplot(s, aes(year, sum)) + geom_point(aes(color = city), size = 5) + labs(title = "PM2.5 emissions from motor vehicle sources", y = "Total PM2.5 emission each year", x = "Year") + scale_fill_manual(values=c("red", "blue"))
dev.off()
