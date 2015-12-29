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

reference=`ls *_${REF_CSAMPLES}_${REF_MINPER}.choped.csv`
reflinenumber=`wc -l $reference | cut -f1 -d' '`
mkdir -p stats
rm stats/*
echo "The model used as reference is: CSAMPLES=$REF_CSAMPLES MINPER=$REF_MINPER" > stats/reference
echo "#CSAMPLES, MINPER, DIFFNUMBER, DIFFPER" > stats/data.csv
for file in *.csv
do
  temp=`basename $file .choped.csv`
  csamples=`echo $temp | awk -F_ '{print $2}'`
  minper=`echo $temp | awk -F_ '{print $3}'`
  diffnumber=`diff $reference $file | grep "<" | wc -l | cut -f1 -d' '`
  diffper=`bc<<<"scale=2;100.0*$diffnumber/$reflinenumber"`
  echo "$csamples,$minper,$diffnumber,$diffper" >> stats/data.csv
done
  
