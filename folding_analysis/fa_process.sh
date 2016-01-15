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

REF_CS=2
REF_FMD=0.0
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
  outdir=$currentpath/$OUTDIR/$clusterdir
  mkdir -p $outdir
  reference=`ls ${REF_CS}_${REF_FMD}.csv`
  reflinenumber=`wc -l $reference | cut -f1 -d' '`
  functnumber_fct $reference
  reffunctnumber=$?
  echo "The model used as reference is: CS=$REF_CS MINPER=$REF_FMD" > $outdir/reference
  echo "#CS, FMD, DIFF, DIFFPER, COMPLEX, COMPLEXRED, COMPLEXREDPER" > $outdir/data.csv
  for file in *.csv
  do
    temp=`basename $file .csv`
    cs=`echo $temp | awk -F_ '{print $1}'`
    minper=`echo $temp | awk -F_ '{print $2}'`
    diffnumber=`diff $reference $file | grep "<" | wc -l | cut -f1 -d' '`
    diffper=`bc<<<"scale=2;100.0*$diffnumber/$reflinenumber"`
    functnumber_fct $file
    functnumber=$?
    complexityred=$((reffunctnumber-functnumber))
    complexityredper=`bc<<<"scale=2;100.0*$complexityred/($reffunctnumber-1)"`
    echo "$cs,$minper,$diffnumber,$diffper,$functnumber,$complexityred,$complexityredper" >> $outdir/data.csv
    filei=$((filei + 1))
    doneper=$((100 * filei / filenumber))
    echo -en "Processing: $doneper %\r"
  done
  cd ..
done
cd ..
