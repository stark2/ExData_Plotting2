# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

# clear R environment
rm(list=ls())

# load required libraries
library(plyr)
library(ggplot2)
require(data.table)

# load datasets NEI and SCC
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")

# transform year and type to factor
NEI <- transform(NEI, type = factor(type), year = factor(year))

# filter SCC dataset 
SCC <- SCC[grepl("Fuel Comb.*Coal", SCC$EI.Sector),]

# filter NEI dataset
NEI <- NEI[(NEI$SCC %in% SCC$SCC), ]

# aggregate and prepare plot data 
s <- ddply(NEI, .(year), summarize, sum = sum(Emissions)) # alternative: aggregate(data = NEI, Emissions ~ year, FUN = sum)

# create a plot and save it to png file
png("plot4.png")
ggplot(s, aes(year, sum)) + geom_point(size = 5, col = "steelblue") + labs(title = "PM2.5 emission from coal combustion-related sources", y = "Total PM2.5 emission each year", x = "Year")
dev.off()

