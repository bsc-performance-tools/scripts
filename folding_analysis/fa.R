library(ggplot2)
library(gtools)
Sys.setlocale("LC_MESSAGES", 'french')

input <- "data.csv"
output1_1 <- "difference_xcsamples.pdf"
output1_2 <- "difference_xcsamples_filered.pdf"
output2 <- "difference_xminper.pdf"
output3_1 <- "complexity_xcsamples.pdf"
output3_2 <- "complexity_xcsamples_filered.pdf"
output4 <- "complexity_xminper.pdf"
output5 <- "score_xcsamples.pdf"

cheader <- c("CSAMPLES", "MINPER", "DIFFNUMBER", "DIFFPER", "FUNCTNUMBER", "FUNCTPER")

legendcs <- "Consecutive samples"
legendmp <- "Function minimal duration"
legendy1 <- "Difference with the reference model (%)"
legendy2 <- "Function number"
legendy3 <- "Score"
legendxy1 <- "Difference with the reference model as a function of consecutive sample and function minimal duration percentage"
legendxy2 <- "Function number relative to the reference model as a function of consecutive sample and function minimal duration percentage"
legendxy3 <- "Score as a function of consecutive sample and function minimal duration percentage"



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
ylabel<- legendy1
legend<- legendxy1
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
ylabel<- legendy1
legend<- legendxy1
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
ylabel<- legendy1
legend<- legendxy1
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

printPlot3_1 <- function(data, string){
dtemp<-data
dtemp<-dtemp[(dtemp$CSAMPLES > 1),]
dtemp$CHARMINPER<-as.character(dtemp$MINPER)
dtemp$CHARCSAMPLES<-as.character(dtemp$CSAMPLES)
charcsamples <- dtemp$CHARCSAMPLES
charcsamples <- mixedsort(charcsamples)
charminper <- dtemp$CHARMINPER
charminper <- mixedsort(charminper)
xlabel<- legendcs
ylabel<- legendy2
legend<- legendxy2
plot<-ggplot(dtemp, aes(x=CSAMPLES, y=FUNCTNUMBER, color=CHARMINPER, 
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

printPlot3_2 <- function(data, string){
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
ylabel<- legendy2
legend<- legendxy2
plot<-ggplot(dtemp, aes(x=CSAMPLES, y=FUNCTNUMBER, color=CHARMINPER, 
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

printPlot4 <- function(data, string){
dtemp<-data
dtemp<-dtemp[(dtemp$CSAMPLES > 1),]
dtemp$CHARMINPER<-as.character(dtemp$MINPER)
dtemp$CHARCSAMPLES<-as.character(dtemp$CSAMPLES)
charcsamples <- dtemp$CHARCSAMPLES
charcsamples <- mixedsort(charcsamples)
charminper <- dtemp$CHARMINPER
charminper <- mixedsort(charminper)
xlabel<- legendmp
ylabel<- legendy2
legend<- legendxy2
plot<-ggplot(dtemp, aes(x=MINPER, y=FUNCTNUMBER, color=CHARCSAMPLES, 
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

printPlot5 <- function(data, string){
dtemp<-data
dtemp<-dtemp[(dtemp$CSAMPLES > 1),]
dtemp$CHARMINPER<-as.character(dtemp$MINPER)
dtemp$CHARCSAMPLES<-as.character(dtemp$CSAMPLES)
dtemp$SCORE<-dtemp$DIFFPER/dtemp$FUNCTPER
charcsamples <- dtemp$CHARCSAMPLES
charcsamples <- mixedsort(charcsamples)
charminper <- dtemp$CHARMINPER
charminper <- mixedsort(charminper)
xlabel<- legendcs
ylabel<- legendy3
legend<- legendxy3
plot<-ggplot(dtemp, aes(x=CSAMPLES, y=SCORE, color=CHARMINPER, 
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





data <- readData(input)
plot1_1<- printPlot1_1(data)
plot1_2<- printPlot1_2(data)
plot2<- printPlot2(data)
plot3_1<- printPlot3_1(data)
plot3_2<- printPlot3_2(data)
plot4<- printPlot4(data)
plot5<- printPlot5(data)

ggsave(output1_1, plot = plot1_1, width = w, height = h)
ggsave(output1_2, plot = plot1_2, width = w, height = h)
ggsave(output2, plot = plot2, width = w, height = h)
ggsave(output3_1, plot = plot3_1, width = w, height = h)
ggsave(output3_2, plot = plot3_2, width = w, height = h)
ggsave(output4, plot = plot4, width = w, height = h)
ggsave(output5, plot = plot5, width = w, height = h)
