library(ggplot2)
library(gtools)
library(scales)
Sys.setlocale("LC_MESSAGES", 'french')

input<-"data.csv"
output<-"best_params.csv"

cheader<-c("CS", "FMD", "LOSS", "LOSSPER", "COMPLEX", "COMPLEXPER")

readData<-function(file) {
  df<-read.csv(file, header=TRUE, sep=",", strip.white=TRUE)
  names(df)<-cheader
  df
}

ComputeBestRepresentations<-function(data, string){
parameters<-seq (0,1,0.0001)
ini<-rep(0,length(parameters))
dres<-data.frame(p=parameters,pIC=ini,CS=ini,FMD=ini,LOSS=ini,COMPLEX=ini)
for(i in 1:length(parameters)){
 dw<-data
 p<-parameters[i]
 dw$pIC<-((-p)*dw$LOSSPER)-((1-p)*dw$COMPLEXPER)
 index<-which.max(dw$pIC)
 dres[i,"p"]<-p
 dres[i,"pIC"]<-dw[index,"pIC"]
 dres[i,"CS"]<-dw[index,"CS"]
 dres[i,"FMD"]<-dw[index,"FMD"]
 dres[i,"LOSS"]<-dw[index,"LOSSPER"]
 dres[i,"COMPLEX"]<-dw[index,"COMPLEX"]
}
dres<-dres[(! duplicated(dres[, "CS"])) | (! duplicated(dres[, "FMD"])), ]
dres
}


data<-readData(input)
br<-ComputeBestRepresentations(data)
br
write.table(br, file=output, row.names=FALSE, col.names=TRUE, sep=",") 


