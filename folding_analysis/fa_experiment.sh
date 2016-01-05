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

TRACE=`ls *.prv`
if [[ -d logs ]]
then
  rm -fr logs
fi
mkdir -p logs
tests=$((8*27))
it=0
for i in 2 3 4 5 10 20 50 100
do
  for j in 0.0 0.1 0.2 0.3 0.4 0.5 0.7 0.8 0.9 1.0 2.0 3.0 4.0 5.0 7.0 8.0 9.0 10.0 20.0 30.0 40.0 50.0 60.0 70.0 80.0 90.0 100.0
  do
  folding -region Cluster_1 -region Cluster_2 -pct $i $j $TRACE "Cluster ID" > logs/log_${i}_${j} 2>&1
  it=$((it + 1))
  progress=$((100*it/tests))
  echo -en "Processing: $progress %    \r"
  done
done
