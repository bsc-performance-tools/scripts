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

export RSPATH=~/Git/github/bsc-performance-tools/scripts/folding_analysis

fa_experiment.sh
fa_extract.sh
fa_process.sh
fa_select.sh
