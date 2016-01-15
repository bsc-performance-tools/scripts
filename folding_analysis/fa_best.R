library(ggplot2)
library(gtools)
library(scales)
Sys.setlocale("LC_MESSAGES", 'french')

input<-"data.csv"
output<-"best_params.csv"

cheader<-c("CS", "FMD", "DIFF", "DIFFPER", "COMPLEX", "COMPLEXRED", "COMPLEXREDPER")

readData<-function(file) {
  df<-read.csv(file, header=TRUE, sep=",", strip.white=TRUE)
  names(df)<-cheader
  df
}

ComputeBestRepresentations<-function(data, string){
parameters<-seq (0,1,0.00005)
ini<-rep(0,length(parameters))
dres<-data.frame(p=parameters,pIC=ini,CS=ini,FMD=ini,DIFFPER=ini,COMPLEX=ini,COMPLEXRED=ini)
for(i in 1:length(parameters)){
 dw<-data
 p<-parameters[i]
 dw$pIC<-((-p)*dw$DIFFPER)+((1-p)*dw$COMPLEXREDPER)
 index<-which.max(dw$pIC)
 dres[i,"p"]<-p
 dres[i,"pIC"]<-dw[index,"pIC"]
 dres[i,"CS"]<-dw[index,"CS"]
 dres[i,"FMD"]<-dw[index,"FMD"]
 dres[i,"DIFFPER"]<-dw[index,"DIFFPER"]
 dres[i,"COMPLEX"]<-dw[index,"COMPLEX"]
 dres[i,"COMPLEXRED"]<-dw[index,"COMPLEXRED"]
}
dres<-dres[ ! (duplicated(dres[, "CS"]) & duplicated(dres[, "FMD"])), ]
dres
}


data<-readData(input)
br<-ComputeBestRepresentations(data)
br
write.table(br, file=output, row.names=FALSE, col.names=TRUE, sep=",") 


