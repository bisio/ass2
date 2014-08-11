SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

nei.baltimore <-  subset(NEI, fips=="24510")
library(ggplot2)

nei.baltimore.road <- subset(nei.baltimore,type=="ON-ROAD")
title = expression(paste( PM[25]," emissions from motor vehicle sources in Baltimore City from 1999 to 2008"))

ggplot(nei.baltimore.road, aes(x=factor(year),y=log10(Emissions))) + geom_boxplot() + xlab("year") + 
  ggtitle(title) +
  ylab(expression(log[10](Emissions)))
ggsave("plot5.png")
