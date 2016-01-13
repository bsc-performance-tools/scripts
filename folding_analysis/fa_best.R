library(ggplot2)
library(gtools)
library(scales)
Sys.setlocale("LC_MESSAGES", 'french')

input <- "data.csv"

cheader <- c("CS", "FMD", "DIFFNUMBER", "DIFFPER", "FUNCTNUMBER", "FUNCTPER")

readData <- function(file) {
  df <- read.csv(file, header=TRUE, sep = ",", strip.white=TRUE)
  names(df) <- cheader
  df
}

printPlot1_1 <- function(data, string){
dtemp<-data
dtemp<-dtemp[(dtemp$CS > 1),]
dtemp$CHARFMD<-as.character(dtemp$FMD)
dtemp$CHARCS<-as.character(dtemp$CS)
charCS <- dtemp$CHARCS
charCS <- mixedsort(charCS)
charFMD <- dtemp$CHARFMD
charFMD <- mixedsort(charFMD)
xlabel<- legendcs
ylabel<- legendy1
legend<- legendxy1
plot<-ggplot(dtemp, aes(x=CS, y=DIFFPER, color=CHARFMD, 
shape=CHARFMD))
plot<-plot + geom_point()
plot<-plot + geom_line()
plot<-plot + theme_bw()
legendscale<-legendmp
plot<-plot + labs(x=xlabel,y=ylabel,legend=legend)
plot<-plot + scale_color_discrete(name=legendscale,
breaks=charFMD,
labels=charFMD)
vtemp<-1:length(charFMD)
plot<-plot+ scale_shape_manual(name=legendscale,
values=vtemp,
breaks=charFMD,
labels=charFMD)
plot
}

printPlot1_2 <- function(data, string){
dtemp<-data
dtemp<-dtemp[(dtemp$CS > 1),]
dtemp<-dtemp[(dtemp$FMD < 1),]
dtemp$CHARFMD<-as.character(dtemp$FMD)
dtemp$CHARCS<-as.character(dtemp$CS)
charCS <- dtemp$CHARCS
charCS <- mixedsort(charCS)
charFMD <- dtemp$CHARFMD
charFMD <- mixedsort(charFMD)
xlabel<- legendcs
ylabel<- legendy1
legend<- legendxy1
plot<-ggplot(dtemp, aes(x=CS, y=DIFFPER, color=CHARFMD, 
shape=CHARFMD))
plot<-plot + geom_point()
plot<-plot + geom_line()
plot<-plot + theme_bw()
legendscale<-legendmp
plot<-plot + labs(x=xlabel,y=ylabel,legend=legend)
plot<-plot + scale_color_discrete(name=legendscale,
breaks=charFMD,
labels=charFMD)
vtemp<-1:length(charFMD)
plot<-plot+ scale_shape_manual(name=legendscale,
values=vtemp,
breaks=charFMD,
labels=charFMD)
plot
}

printPlot2 <- function(data, string){
dtemp<-data
dtemp<-dtemp[(dtemp$CS > 1),]
dtemp$CHARFMD<-as.character(dtemp$FMD)
dtemp$CHARCS<-as.character(dtemp$CS)
charCS <- dtemp$CHARCS
charCS <- mixedsort(charCS)
charFMD <- dtemp$CHARFMD
charFMD <- mixedsort(charFMD)
xlabel<- legendmp
ylabel<- legendy1
legend<- legendxy1
plot<-ggplot(dtemp, aes(x=FMD, y=DIFFPER, color=CHARCS, 
shape=CHARCS))
plot<-plot + geom_point()
plot<-plot + geom_line()
plot<-plot + theme_bw()
legendscale<-legendcs
plot<-plot + labs(x=xlabel,y=ylabel,legend=legend)
plot<-plot + scale_color_discrete(name=legendscale,
breaks=charCS,
labels=charCS)
vtemp=1:length(charCS)
plot<-plot+ scale_shape_manual(name=legendscale,
values=vtemp,
breaks=charCS,
labels=charCS)
plot
}

printPlot2_log <- function(data, string){
dtemp<-data
dtemp<-dtemp[(dtemp$CS > 1),]
dtemp$CHARFMD<-as.character(dtemp$FMD)
dtemp$CHARCS<-as.character(dtemp$CS)
charCS <- dtemp$CHARCS
charCS <- mixedsort(charCS)
charFMD <- dtemp$CHARFMD
charFMD <- mixedsort(charFMD)
xlabel<- legendmp
ylabel<- legendy1
legend<- legendxy1
plot<-ggplot(dtemp, aes(x=FMD, y=DIFFPER, color=CHARCS, 
shape=CHARCS))
plot<-plot + geom_point()
plot<-plot + geom_line()
plot<-plot + theme_bw()
legendscale<-legendcs
plot<-plot + labs(x=xlabel,y=ylabel,legend=legend)
plot<-plot + scale_color_discrete(name=legendscale,
breaks=charCS,
labels=charCS)
plot<-plot+scale_x_log10()
vtemp=1:length(charCS)
plot<-plot+ scale_shape_manual(name=legendscale,
values=vtemp,
breaks=charCS,
labels=charCS)
plot
}


printPlot3_1 <- function(data, string){
dtemp<-data
dtemp<-dtemp[(dtemp$CS > 1),]
dtemp$CHARFMD<-as.character(dtemp$FMD)
dtemp$CHARCS<-as.character(dtemp$CS)
charCS <- dtemp$CHARCS
charCS <- mixedsort(charCS)
charFMD <- dtemp$CHARFMD
charFMD <- mixedsort(charFMD)
xlabel<- legendcs
ylabel<- legendy2
legend<- legendxy2
plot<-ggplot(dtemp, aes(x=CS, y=FUNCTNUMBER, color=CHARFMD, 
shape=CHARFMD))
plot<-plot + geom_point()
plot<-plot + geom_line()
plot<-plot + theme_bw()
legendscale<-legendmp
plot<-plot + labs(x=xlabel,y=ylabel,legend=legend)
plot<-plot + scale_color_discrete(name=legendscale,
breaks=charFMD,
labels=charFMD)
vtemp<-1:length(charFMD)
plot<-plot+ scale_shape_manual(name=legendscale,
values=vtemp,
breaks=charFMD,
labels=charFMD)
plot
}

printPlot3_2 <- function(data, string){
dtemp<-data
dtemp<-dtemp[(dtemp$CS > 1),]
dtemp<-dtemp[(dtemp$FMD < 1),]
dtemp$CHARFMD<-as.character(dtemp$FMD)
dtemp$CHARCS<-as.character(dtemp$CS)
charCS <- dtemp$CHARCS
charCS <- mixedsort(charCS)
charFMD <- dtemp$CHARFMD
charFMD <- mixedsort(charFMD)
xlabel<- legendcs
ylabel<- legendy2
legend<- legendxy2
plot<-ggplot(dtemp, aes(x=CS, y=FUNCTNUMBER, color=CHARFMD, 
shape=CHARFMD))
plot<-plot + geom_point()
plot<-plot + geom_line()
plot<-plot + theme_bw()
legendscale<-legendmp
plot<-plot + labs(x=xlabel,y=ylabel,legend=legend)
plot<-plot + scale_color_discrete(name=legendscale,
breaks=charFMD,
labels=charFMD)
vtemp<-1:length(charFMD)
plot<-plot+ scale_shape_manual(name=legendscale,
values=vtemp,
breaks=charFMD,
labels=charFMD)
plot
}

printPlot4 <- function(data, string){
dtemp<-data
dtemp<-dtemp[(dtemp$CS > 1),]
dtemp$CHARFMD<-as.character(dtemp$FMD)
dtemp$CHARCS<-as.character(dtemp$CS)
charCS <- dtemp$CHARCS
charCS <- mixedsort(charCS)
charFMD <- dtemp$CHARFMD
charFMD <- mixedsort(charFMD)
xlabel<- legendmp
ylabel<- legendy2
legend<- legendxy2
plot<-ggplot(dtemp, aes(x=FMD, y=FUNCTNUMBER, color=CHARCS, 
shape=CHARCS))
plot<-plot + geom_point()
plot<-plot + geom_line()
plot<-plot + theme_bw()
legendscale<-legendcs
plot<-plot + labs(x=xlabel,y=ylabel,legend=legend)
plot<-plot + scale_color_discrete(name=legendscale,
breaks=charCS,
labels=charCS)
vtemp=1:length(charCS)
plot<-plot+ scale_shape_manual(name=legendscale,
values=vtemp,
breaks=charCS,
labels=charCS)
plot
}

printPlot5_1 <- function(data, string){
dtemp<-data
dtemp<-dtemp[(dtemp$CS > 1),]
dtemp$CHARFMD<-as.character(dtemp$FMD)
dtemp$CHARCS<-as.character(dtemp$CS)
charCS <- dtemp$CHARCS
charCS <- mixedsort(charCS)
charFMD <- dtemp$CHARFMD
charFMD <- mixedsort(charFMD)
xlabel<- legendmp
ylabel<- legendcs
legend<- legendxy3
plot<-ggplot(dtemp, aes(x=FMD, y=CS, size=DIFFPER, color=DIFFPER))
plot<-plot + geom_point()
plot<-plot + theme_bw()
legendscale<-legendmp
plot<-plot + labs(x=xlabel,y=ylabel,legend=getwd())
plot<-plot+scale_color_gradientn(name="Difference (%)",colours=rainbow(10))
plot<-plot+scale_size(name="Difference (%)",range = c(0.5,5))
plot<-plot+scale_x_log10()
plot<-plot+scale_y_log10()
plot
}

printPlot5_2 <- function(data, string){
dtemp<-data
dtemp<-dtemp[(dtemp$CS > 1),]
dtemp$CHARFMD<-as.character(dtemp$FMD)
dtemp$CHARCS<-as.character(dtemp$CS)
charCS <- dtemp$CHARCS
charCS <- mixedsort(charCS)
charFMD <- dtemp$CHARFMD
charFMD <- mixedsort(charFMD)
xlabel<- legendmp
ylabel<- legendcs
legend<- legendxy3
plot<-ggplot(dtemp, aes(x=FMD, y=CS, size= FUNCTNUMBER, color=FUNCTNUMBER))
plot<-plot + geom_point()
plot<-plot + theme_bw()
legendscale<-legendmp
plot<-plot + labs(x=xlabel,y=ylabel,legend=getwd())
plot<-plot+scale_color_gradientn(name="Functions",colours=rainbow(10))
plot<-plot+scale_size(name="Functions",range = c(0.5,5))
plot<-plot+scale_x_log10()
plot<-plot+scale_y_log10()
plot
}

printPlot6 <- function(data, string){
dtemp<-data
dtemp<-dtemp[(dtemp$CS > 1),]
dtemp<-dtemp[(dtemp$FUNCTPER > 0),]
dtemp$CHARFMD<-as.character(dtemp$FMD)
dtemp$CHARCS<-as.character(dtemp$CS)
p<-0.5
dtemp$SCORE<- ((-p)*dtemp$DIFFPER)-((1-p)*dtemp$FUNCTPER)
charCS <- dtemp$CHARCS
charCS <- mixedsort(charCS)
charFMD <- dtemp$CHARFMD
charFMD <- mixedsort(charFMD)
xlabel<- legendmp
ylabel<- legendcs
legend<- legendxy3
plot<-ggplot(dtemp, aes(x=FMD, y=CS, size= SCORE, color=SCORE))
plot<-plot + geom_point()
plot<-plot + theme_bw()
legendscale<-legendmp
plot<-plot + labs(x=xlabel,y=ylabel,legend=getwd())
plot<-plot + scale_color_gradientn(name="Score",colours=rainbow(10))
plot<-plot + scale_size(name="Score",range = c(0.5,5))
plot<-plot + scale_x_log10()
plot<-plot + scale_y_log10()
plot
}

ComputeBestRepresentations <- function(data, string){
parameters<- seq (0,1,0.0001)
ini<-rep(0,length(parameters))
dres <- data.frame(p=parameters,pIC=ini,CS=ini,FMD=ini,LOSS=ini,COMPLEX=ini)
for(i in 1:length(parameters)){
 dw<-data
 p<-parameters[i]
 dw$pIC<-((-p)*dw$DIFFPER)-((1-p)*dw$FUNCTPER)
 index<-which.max(dw$pIC)
 dres[i,"p"]<-p
 dres[i,"pIC"]<-dw[index,"pIC"]
 dres[i,"CS"]<-dw[index,"CS"]
 dres[i,"FMD"]<-dw[index,"FMD"]
 dres[i,"LOSS"]<-dw[index,"DIFFPER"]
 dres[i,"COMPLEX"]<-dw[index,"FUNCTNUMBER"]
}
dres<-dres[(! duplicated(dres[, "CS"])) | (! duplicated(dres[, "FMD"])), ]
dres
}


ComputeBestRepresentations(data)


