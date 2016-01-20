library(ggplot2)
library(gtools)
library(scales)
Sys.setlocale("LC_MESSAGES", 'french')

input<-"data.csv"
output<-"best_params.csv"

h <- 6
w <- 12


cheader<-c("CS", "FMD", "DIFF", "DIFFPER", "COMPLEX", "COMPLEXPER", "COMPLEXRED", "COMPLEXREDPER")

readData<-function(file) {
  df<-read.csv(file, header=TRUE, sep=",", strip.white=TRUE)
  names(df)<-cheader
  df
}

computeBestRepresentations<-function(data){
parameters<-seq (0,1,0.0001)
ini<-rep(0,length(parameters))
dres<-data.frame(p=parameters,pIC=ini,CS=ini,FMD=ini,DIFFPER=ini,COMPLEX=ini,COMPLEXRED=ini)
for(i in 1:length(parameters)){
 dw<-data
 p<-parameters[i]
 dw$pIC<-((-p)*dw$DIFFPER)-((1-p)*dw$COMPLEXPER)
 index<-which.max(dw$pIC)
 dres[i,"p"]<-p
 dres[i,"pIC"]<-dw[index,"pIC"]
 dres[i,"CS"]<-dw[index,"CS"]
 dres[i,"FMD"]<-dw[index,"FMD"]
 dres[i,"DIFFPER"]<-dw[index,"DIFFPER"]
 dres[i,"COMPLEX"]<-dw[index,"COMPLEX"]
 dres[i,"COMPLEXRED"]<-dw[index,"COMPLEXRED"]
 dres[i,"COMPLEXREDPER"]<-dw[index,"COMPLEXREDPER"]
}
dres<-dres[ ! (duplicated(dres[, "CS"]) & duplicated(dres[, "FMD"])), ]
dres
}

measures1<-function(data){
dtemp<-data
xlabel<- "Parameter p"
ylabel<- "Amplitude (normalized)"
dtemp$LABELX=paste(dtemp$CS,dtemp$FMD,sep=":")
dtemp$LABELY<- with(dtemp, pmax(DIFFPER, COMPLEXREDPER))
plot<-ggplot(dtemp, aes(p))
plot<-plot+geom_line(aes(y=DIFFPER), color="red")
plot<-plot+geom_line(aes(y=COMPLEXREDPER), color="green")
plot<-plot+geom_point(aes(y=DIFFPER), color="red")
plot<-plot+geom_point(aes(y=COMPLEXREDPER), color="green")
plot<-plot + geom_text(aes(label=LABELX,y=LABELY),hjust=0, vjust=-1)
plot<-plot + theme_bw()
plot<-plot + labs(x=xlabel,y=ylabel,legend=legend)
plot
}

measures2<-function(data){
dtemp<-data
dtemp$LABEL=paste(dtemp$CS,dtemp$FMD,sep=":")
xlabel<- "Complexity"
ylabel<- "Difference"
plot<-ggplot(dtemp, aes(x=COMPLEX, y=DIFFPER))
plot<-plot + geom_point()
plot<-plot + geom_line()
plot<-plot + geom_text(aes(label=LABEL),hjust=0, vjust=-1)
plot<-plot + theme_bw()
plot<-plot + labs(x=xlabel,y=ylabel,legend=legend)
plot
}


data<-readData(input)
br<-computeBestRepresentations(data)
br
write.table(br, file=output, row.names=FALSE, col.names=TRUE, sep=",")

ggsave("measures1.pdf", plot = measures1(br), width = w, height = h)
ggsave("measures2.pdf", plot = measures2(br), width = w, height = h)


