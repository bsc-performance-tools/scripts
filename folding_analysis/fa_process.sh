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

REF_CSAMPLES=2
REF_MINPER=0.0
DIR=pdata
OUTDIR=stats

functnumber_fct(){
  num=0
  old=0
  cat $1 | awk -F";" '{print $3}' > temp
  while IFS='' read -r line || [[ -n "$line" ]]
  do
    if [ $old -ne $line ]
    then
      num=$((num + 1))
    fi
    old=$line
  done < temp
  rm temp
  return $num
}

currentpath=`pwd`
if [[ -d $OUTDIR ]]
  then
    rm -fr $OUTDIR
  fi
mkdir -p $OUTDIR
cd $DIR
filenumber=`ls -Al */*.csv | wc -l`
filei=0
for clusterdir in *
do
  cd $clusterdir
  outdir=$currentpath/$OUDIR/$clusterdir
  mkdir -p $outdir
  reference=`ls *_${REF_CSAMPLES}_${REF_MINPER}.csv`
  reflinenumber=`wc -l $reference | cut -f1 -d' '`
  functnumber_fct $reference
  reffunctnumber=$?
  echo "The model used as reference is: CSAMPLES=$REF_CSAMPLES MINPER=$REF_MINPER" > $outdir/reference
  echo "#CS, FMD, LOSS, LOSSPER, COMPLEX, COMPLEXPER" > $outdir/data.csv
  for file in *.csv
  do
    temp=`basename $file .choped.csv`
    csamples=`echo $temp | awk -F_ '{print $2}'`
    minper=`echo $temp | awk -F_ '{print $3}'`
    diffnumber=`diff $reference $file | grep "<" | wc -l | cut -f1 -d' '`
    diffper=`bc<<<"scale=2;100.0*$diffnumber/$reflinenumber"`
    functnumber_fct $file
    functnumber=$?
    funcper=`bc<<<"scale=2;100.0*$functnumber/$reffunctnumber"`
    echo "$csamples,$minper,$diffnumber,$diffper,$functnumber,$funcper" >> $outdir/data.csv
    filei=$((filei + 1))
    doneper=$((100 * filei / filenumber))
    echo -en "Processing: $doneper %\r"
  done
  cd ..
done
cd ..
