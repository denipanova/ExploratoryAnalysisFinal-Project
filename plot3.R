################################################################################
#### Exploratory Analysis 
#### Project 2
#### plot 3
################################################################################

## Library
library(data.table)
library(ggplot2)

## working directory
setwd('C:/Users/dpanova/Documents/Resources/DataScienceSpecialization/ExplaratoryAnalysis')


## read in the data
NEI = readRDS('summarySCC_PM25.rds') 
SCC = readRDS('Source_Classification_Code.rds')


## Question
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
# variable, which of these four sources have seen decreases in emissions 
# from 1999-2008 for Baltimore City? Which have seen increases in emissions 
# from 1999-2008? Use the ggplot2 plotting system to make a plot answer this question.

baltimore = as.data.table(NEI[NEI$fips == '24510',])
baltimore = baltimore[,all_emissions := sum(Emissions,na.rm = TRUE),by = .(year,type)]
baltimore = unique(baltimore[,.(year,all_emissions,type)]) 



## plot it 
png("plot3.png", width=4, height=4, units="in", res=300)
ggplot(data=baltimore,
       aes(x=year, y=all_emissions, colour=type)) +
  geom_line(size = 1) + 
  labs(title = 'Baltimore Emissons by Type',
       y = 'Emissions')

dev.off()
