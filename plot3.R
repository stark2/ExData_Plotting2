# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

# clear R environment
rm(list=ls())

# load required libraries
library(plyr)
library(ggplot2)

# load datasets NEI and SCC
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")

# transform year to factor
NEI <- transform(NEI, year = factor(year))

# filter NEI dataset 
NEI <- NEI[NEI$fips == "24510",]

# aggregate and prepare plot data 
s <- ddply(NEI, .(year, type), summarize, sum = sum(Emissions))

# create a plot and save it to png file
png("plot3.png")
ggplot(s, aes(year, sum)) + geom_point() + facet_grid(.~type) + labs(title = "Emissions in Baltimore city", y = "Total PM2.5 emission", x = "Year") + stat_smooth(method = "lm", col = "red", aes(group = 1))
dev.off()
