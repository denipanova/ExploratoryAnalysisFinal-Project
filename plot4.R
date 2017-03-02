################################################################################
#### Exploratory Analysis 
#### Project 2
#### plot 4
################################################################################

## Library
library(data.table)


## working directory
setwd('C:/Users/dpanova/Documents/Resources/DataScienceSpecialization/ExplaratoryAnalysis')


## read in the data
NEI = readRDS('summarySCC_PM25.rds') 
SCC = readRDS('Source_Classification_Code.rds')



## Question
# Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999-2008?

#Merge the two files 
SCC$SCC = as.factor(SCC$SCC)
NEI$SCC = as.factor(NEI$SCC)
data = merge(NEI,SCC,by.x = 'SCC', by.y = 'SCC', all.x = TRUE)
#isolate the coal emissions
data = as.data.table(data[data$EI.Sector == 'Fuel Comb - Electric Generation - Coal',])
coal_emissions = data[,all_emissions := sum(Emissions,na.rm = TRUE),by = year]
coal_emissions = unique(coal_emissions[,.(year,all_emissions)]) 



## plot it 
png("plot4.png", width=4, height=4, units="in", res=300)
plot(coal_emissions,main = 'Coal Emissions by Year',
     ylab = 'Total Emissions',type = 'b')

dev.off()
