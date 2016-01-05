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

FILOSSDIR=filoss
rm -fr $FILOSSDIR
mkdir -p $FILOSSDIR
for i in 1 2
  do
  clusterdir=$FILOSSDIR/Cluster_$i
  mkdir -p $clusterdir
  for dir in *clustered*
    do
    if [ -d "$dir" ]
      then
      cp $dir/*codeblocks.fused.any.any.any.dump.csv $clusterdir/${dir}.csv
    fi
    done
  cd $clusterdir
  for csv in *.csv
  do
    filtered=${csv%.csv}.filtered.csv
    choped=${csv%.csv}.choped.csv
    grep "cl;Cluster_$i;0;" $csv > $filtered
    rm $csv
    cat $filtered | awk -F";" '{print $4 ";" $5 ";" $6}' > $choped
    rm $filtered
  done
  cd ../..
done
  
