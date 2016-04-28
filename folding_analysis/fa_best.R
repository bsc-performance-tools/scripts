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
dw<-data
for(i in 1:length(parameters)){
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

square<-function(data){
dres<-data
drestemp<-data.frame(p=data[2:(nrow(data)),"p"]-0.000000001,pIC=data[1:(nrow(data)-1),"pIC"],CS=data[1:(nrow(data)-1),"CS"],FMD=data[1:(nrow(data)-1),"FMD"],DIFFPER=data[1:(nrow(data)-1),"DIFFPER"],COMPLEX=data[1:(nrow(data)-1),"COMPLEX"],COMPLEXRED=data[1:(nrow(data)-1),"COMPLEXRED"],COMPLEXREDPER=data[1:(nrow(data)-1),"COMPLEXREDPER"])
drestemp[nrow(drestemp)+1,]<-c(1,data[nrow(data),"pIC"],data[nrow(data),"CS"],data[nrow(data),"FMD"],data[nrow(data),"DIFFPER"],data[nrow(data),"COMPLEX"],data[nrow(data),"COMPLEXRED"],data[nrow(data),"COMPLEXREDPER"])
dres<-rbind(dres, drestemp)
dres<- dres[order(dres$p),] 
dres
}

measures1<-function(data){
dtemp<-data
xlabel<- "Parameter p"
ylabel<- "Amplitude (normalized)"
dtempsq<-square(data)
dtempsq
dtempsq$LABELX<-paste(dtempsq$CS,dtempsq$FMD,sep=":")
dtempsq$LABELX[seq(2,nrow(dtempsq),2)]<-""
dtempsq$LABELY<- with(dtempsq, pmax(DIFFPER, COMPLEXREDPER))
plot<-ggplot(dtempsq, aes(p))
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
xlabel<- "Complexity"
ylabel<- "Difference"
dtemp$LABEL=paste(dtemp$CS,dtemp$FMD,sep=":")
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


