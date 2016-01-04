library(ggplot2)
library(gtools)
Sys.setlocale("LC_MESSAGES", 'french')

input <- "data.csv"
output1_1 <- "difference_xcsamples.pdf"
output1_2 <- "difference_xcsamples_filered.pdf"
output2 <- "difference_xminper.pdf"
cheader <- c("CSAMPLES", "MINPER", "DIFFNUMBER", "DIFFPER")

legendcs <- "Consecutive samples"
legendmp <- "Function minimal duration"
legendy <- "Difference with the reference model (%)"
legendxy<- "Difference with the reference model as a function of consecutive sample and function minimal duration percentage"



h <- 9
w <- 16

readData <- function(file) {
  df <- read.csv(file, header=TRUE, sep = ",", strip.white=TRUE)
  names(df) <- cheader
  df
}

printPlot1_1 <- function(data, string){
dtemp<-data
dtemp<-dtemp[(dtemp$CSAMPLES > 1),]
dtemp$CHARMINPER<-as.character(dtemp$MINPER)
dtemp$CHARCSAMPLES<-as.character(dtemp$CSAMPLES)
charcsamples <- dtemp$CHARCSAMPLES
charcsamples <- mixedsort(charcsamples)
charminper <- dtemp$CHARMINPER
charminper <- mixedsort(charminper)
xlabel<- legendcs
ylabel<- legendy
legend<- legendxy
plot<-ggplot(dtemp, aes(x=CSAMPLES, y=DIFFPER, color=CHARMINPER, 
shape=CHARMINPER))
plot<-plot + geom_point()
plot<-plot + geom_line()
plot<-plot + theme_bw()
legendscale<-legendmp
plot<-plot + labs(x=xlabel,y=ylabel,legend=legend)
plot<-plot + scale_color_discrete(name=legendscale,
breaks=charminper,
labels=charminper)
vtemp<-1:length(charminper)
plot<-plot+ scale_shape_manual(name=legendscale,
values=vtemp,
breaks=charminper,
labels=charminper)
plot
}

printPlot1_2 <- function(data, string){
dtemp<-data
dtemp<-dtemp[(dtemp$CSAMPLES > 1),]
dtemp<-dtemp[(dtemp$MINPER < 1),]
dtemp$CHARMINPER<-as.character(dtemp$MINPER)
dtemp$CHARCSAMPLES<-as.character(dtemp$CSAMPLES)
charcsamples <- dtemp$CHARCSAMPLES
charcsamples <- mixedsort(charcsamples)
charminper <- dtemp$CHARMINPER
charminper <- mixedsort(charminper)
xlabel<- legendcs
ylabel<- legendy
legend<- legendxy
plot<-ggplot(dtemp, aes(x=CSAMPLES, y=DIFFPER, color=CHARMINPER, 
shape=CHARMINPER))
plot<-plot + geom_point()
plot<-plot + geom_line()
plot<-plot + theme_bw()
legendscale<-legendmp
plot<-plot + labs(x=xlabel,y=ylabel,legend=legend)
plot<-plot + scale_color_discrete(name=legendscale,
breaks=charminper,
labels=charminper)
vtemp<-1:length(charminper)
plot<-plot+ scale_shape_manual(name=legendscale,
values=vtemp,
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
xlabel<- legendmp
ylabel<- legendy
legend<- legendxy
plot<-ggplot(dtemp, aes(x=MINPER, y=DIFFPER, color=CHARCSAMPLES, 
shape=CHARCSAMPLES))
plot<-plot + geom_point()
plot<-plot + geom_line()
plot<-plot + theme_bw()
legendscale<-legendcs
plot<-plot + labs(x=xlabel,y=ylabel,legend=legend)
plot<-plot + scale_color_discrete(name=legendscale,
breaks=charcsamples,
labels=charcsamples)
vtemp=1:length(charcsamples)
plot<-plot+ scale_shape_manual(name=legendscale,
values=vtemp,
breaks=charcsamples,
labels=charcsamples)
plot
}

data <- readData(input)
ggsave(output1_1, plot = printPlot1_1(data), width = w, height = h)
ggsave(output1_2, plot = printPlot1_2(data), width = w, height = h)
ggsave(output2, plot = printPlot2(data), width = w, height = h)

