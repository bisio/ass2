SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")



coal.comb.short.names  <- grep("[Cc]omb.*[Cc]oal",unique(as.character(SCC$Short.Name)),value=T,perl=T)
coal.comb.scc <-  as.character(subset(SCC,Short.Name %in% coal.comb.short.names)$SCC)

nei.coal.comb <- subset(NEI, SCC %in% coal.comb.scc)
title = expression(paste("Coal Combustion related emissions of ",PM[2.5],"  from 1999 to 2008 by type"))

ggplot(nei.coal.comb, aes(x=factor(year),y=log10(Emissions))) + geom_boxplot() + xlab("year") +
      ylab(expression(log[10](Emissions))) +
      ggtitle(title)

ggsave("plot4.png")
