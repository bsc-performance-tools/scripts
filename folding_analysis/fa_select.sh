#!/bin/bash

#Copyright (c) 2015 Barcelona Supercomputing Center
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


RSCRIPT=~/Git/github/bsc-performance-tools/scripts/folding_analysis/

SCRIPTNAME=fa_best.R
STATS=stats
TRACES=ptraces
OUTDIR=selected

if [[ -d $RSCRIPT ]]
then
echo "RSCRIPT valid"
elif [[ -d $RSPATH ]]
then
RSCRIPT=$RSPATH
else
echo "Set the environment variable RSPATH to the directory that contains ${SCRIPTNAME} and run this script again. Leaving..."
exit 1
fi


if [[ -d $OUTDIR ]]
then
  rm -fr $OUTDIR
fi
mkdir -p $OUTDIR
cd $STATS
for cluster in Cluster_*
do
  cd $cluster
  R --vanilla < $RSCRIPT/$SCRIPTNAME
  R --vanilla < $RSCRIPT/fa.R
  mkdir -p ../../$OUTDIR/$cluster
  sed '1d' best_params.csv > temp
  while IFS='' read -r line || [[ -n "$line" ]]
  do
    p=`echo $line | awk -F"," '{print $1}'`
    pIC=`echo $line | awk -F"," '{print $2}'`
    CS=`echo $line | awk -F"," '{print $3}'`
    FMD=`echo $line | awk -F"," '{print $4}'`
    DIFF=`echo $line | awk -F"," '{print $5}'`
    COMPLEX=`echo $line | awk -F"," '{print $6}'`
    COMPLEXRED=`echo $line | awk -F"," '{print $7}'`
    selectedtrace=../../$TRACES/${CS}_${FMD}
    if [[ ! -d $selectedtrace ]]
    then
      selectedtrace=${selectedtrace}.0
    fi
    SELECTED=${COMPLEX}_${CS}-${FMD}
    mkdir -p ../../$OUTDIR/$cluster/${SELECTED}
    cp -r $selectedtrace/*$cluster* ../../$OUTDIR/$cluster/${SELECTED}
    cp -r $selectedtrace/*csv ../../$OUTDIR/$cluster/${SELECTED}
    done < temp
  rm temp
  mv best_params.csv ../../$OUTDIR/$cluster/
  mv measures*.pdf ../../$OUTDIR/$cluster/
  cd ..
done
