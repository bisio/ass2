SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

nei.baltimore <-  subset(NEI, fips=="24510")
nei.baltimore.list <- split(nei.baltimore,nei.baltimore$year)
nei.baltimore.data <- lapply(nei.baltimore.list,function(x)x$Emissions)
logged.nei.baltimore.data <- lapply(nei.baltimore.data,log10)


library(ggplot2)
title = expression(paste("Global emissions of ",PM[2.5]," in Baltimore City from 1999 to 2008 by type"))

ggplot(nei.baltimore,aes(x=factor(year),y=log10(Emissions)))  + geom_boxplot(notch=T) + 
   ylab(expression(log[10](Emissions))) +
   facet_grid(. ~ type) +
   xlab("year") + ggtitle(title)
ggsave("plot3.png")
