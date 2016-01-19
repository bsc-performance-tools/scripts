library(ggplot2)
library(gtools)
library(scales)
Sys.setlocale("LC_MESSAGES", 'french')

input<-"data.csv"
output<-"best_params.csv"
threshold<-0.4

cheader<-c("CS", "FMD", "DIFF", "DIFFPER", "COMPLEX", "COMPLEXRED", "COMPLEXREDPER")

readData<-function(file) {
  df<-read.csv(file, header=TRUE, sep=",", strip.white=TRUE)
  names(df)<-cheader
  df
}


recursion<-function(p1,p2,data){
  ini<-rep(0,2)
  p<-p1
  data$pIC<-((-p)*data$DIFFPER)+((1-p)*data$COMPLEXREDPER)
  index1<-which.max(data$pIC)
  p<-p2
  data$pIC<-((-p)*data$DIFFPER)+((1-p)*data$COMPLEXREDPER)
  index2<-which.max(data$pIC)
  if (((p2-p1)<threshold)| (index1==index2)){
    return(p1)
  }
  else{
    p1<-recursion(p1,(p2-p1)/2,data)
    p2<-recursion((p2-p1)/2,p2,data)
    return(c(p1,p2))
    }
}


computeBestRepresentations<-function(data){
parameters<-recursion(0,1,data)
ini<-rep(0,length(parameters))
dres<-data.frame(p=double(),pIC=double(),CS=integer(),FMD=double(),DIFFPER=double(),COMPLEX=integer(),COMPLEXRED=double())
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

options(expressions = 10000)
data<-readData(input)
br<-computeBestRepresentations(data)
br
write.table(br, file=output, row.names=FALSE, col.names=TRUE, sep=",") 


