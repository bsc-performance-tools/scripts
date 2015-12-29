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

P1=2
P2=0.0

reference=`ls *_${P1}_${P2}.choped.csv`
mkdir -p stats
rm stats/*
echo "The model used as reference is: CSAMPLES=$P1 MINPER=$P2" > stats/reference
echo "#CSAMPLES, MINPER, DIFFNUMBER" > stats/data.csv
for file in *.csv
do
  temp=`basename $file .choped.csv`
  x=`echo $temp | awk -F_ '{print $2}'`
  y=`echo $temp | awk -F_ '{print $3}'`
  diff $reference $file > stats/${x}_${y}
  z=`wc -l stats/${x}_${y} | cut -f1 -d' '`
  echo "$x, $y, $z" >> stats/data.csv
done
  
