#!/bin/bash

#Copyright (c) 2015 Barcelona Supercomputing Center
#Script to launch the tools of the BSC Performance Tools Team
#and perform a complete analysis process.
#
#This is free software: you can redistribute it and/or modify
#it under the terms of the GNU General Public License as published by
#the Free Software Foundation, either version 3 of the License, or
#(at your option) any later version.
#
#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.
#
#You should have received a copy of the GNU General Public License
#along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#Author: Damien Dosimont <damien[dot]dosimont[at]bsc.es


PREFIX=
SUFFIX=chop1
CLUSTER=cluster.xml

clustering_fct(){
  BurstClustering -a -d $CLUSTER -i ${APP}.prv -o ${APP}.clustered.prv
  #sed -i '/pause/d' ${APP}.clustered.IPC.PAPI_TOT_INS.gnuplot
  gnuplot -p ${APP}.clustered.IPC.PAPI_TOT_INS.gnuplot
}

extract_fct(){
  ClusteringDataExtractor -d $CLUSTER -i ${APP}.prv
  #sed -i '/pause/d' ${APP}.IPC.PAPI_TOT_INS.gnuplot
  gnuplot -p ${APP}.IPC.PAPI_TOT_INS.gnuplot
}

stat_fct (){
  stats ${APP}.prv -bursts_histo
  #sed -i '/pause/d' ${APP}.bursts.gnuplot
  gnuplot -p ${APP}.bursts.gnuplot
}

APP=`ls $PREFIX*$SUFFIX.prv`
APP=${APP%.prv}

PARAM=$1

if [ "$PARAM" -eq 1 ]
then
  stat_fct  
fi

if [ "$PARAM" -eq 2 ]
then
  extract_fct  
fi

if [ "$PARAM" -eq 3 ]
then
  clustering_fct  
fi
  
