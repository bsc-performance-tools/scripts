library(ggplot2)
library(gtools)
Sys.setlocale("LC_MESSAGES", 'french')

input <- "data.csv"
output1 <- "difference_xcsamples.pdf"
output2 <- "difference_xminper.pdf"
cheader <- c("CSAMPLES", "MINPER", "DIFFNUMBER", "DIFFPER")



h <- 4
w <- 8

readData <- function(file) {
  df <- read.csv(file, header=TRUE, sep = ",", strip.white=TRUE)
  names(df) <- cheader
  df
}

printPlot1 <- function(data, string){
dtemp<-data
dtemp<-dtemp[(dtemp$CSAMPLES > 1),]
dtemp$CHARMINPER<-as.character(dtemp$MINPER)
dtemp$CHARCSAMPLES<-as.character(dtemp$CSAMPLES)
charcsamples <- dtemp$CHARCSAMPLES
charcsamples <- mixedsort(charcsamples)
charminper <- dtemp$CHARMINPER
charminper <- mixedsort(charminper)
xlabel<- "Consecutive samples"
ylabel<- "Difference with the reference model (%)"
legend<- "Difference with the reference model as a function of consecutive sample and function minimal duration percentage"
plot<-ggplot(dtemp, aes(x=CSAMPLES, y=DIFFPER, color=CHARMINPER, 
shape=CHARMINPER))
plot<-plot + geom_point()
plot<-plot + geom_line()
plot<-plot + theme_bw()
plot<-plot + labs(x=xlabel,y=ylabel,legend=legend)
plot<-plot + scale_color_discrete(name="Function minimal duration (%)",
breaks=charminper,
labels=charminper)
plot<-plot+ scale_shape_manual(name="Function minimal duration (%)",
values=c(0,1,2,3,4,5,6,7,8),
breaks=charminper,
labels=charminper)
plot
}

printPlot2 <- function(data, string){
dtemp<-data
dtemp<-dtemp[(dtemp$CSAMPLES > 1),]
dtemp$CHARMINPER<-as.character(dtemp$MINPER)
dtemp$CHARCSAMPLES<-as.character(dtemp$CSAMPLES)
charcsamples <- dtemp$CHARCSAMPLES
charcsamples <- mixedsort(charcsamples)
charminper <- dtemp$CHARMINPER
charminper <- mixedsort(charminper)
xlabel<- "Function minimal duration (%)"
ylabel<- "Difference with the reference model (%)"
legend<- "Difference with the reference model as a function of consecutive sample and function minimal duration percentage"
plot<-ggplot(dtemp, aes(x=MINPER, y=DIFFPER, color=CHARCSAMPLES, 
shape=CHARCSAMPLES))
plot<-plot + geom_point()
plot<-plot + geom_line()
plot<-plot + theme_bw()
plot<-plot + labs(x=xlabel,y=ylabel,legend=legend)
plot<-plot + scale_color_discrete(name="Consecutive samples",
breaks=charcsamples,
labels=charcsamples)
plot<-plot+ scale_shape_manual(name="Consecutive samples",
values=c(0,1,2,3,4,5,6,7,8),
breaks=charcsamples,
labels=charcsamples)
plot
}

data <- readData(input)
ggsave(output1, plot = printPlot1(data), width = w, height = h)
ggsave(output2, plot = printPlot2(data), width = w, height = h)

