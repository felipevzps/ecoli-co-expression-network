#!/bin/bash

#$ -V
#$ -cwd
#$ -q all.q
#$ -pe smp 1

module load mcl/14-137

in=`ls -1 ../results/ecoli60.mci`

/usr/bin/time -v mcl $in -I 1.4
/usr/bin/time -v mcl $in -I 2
/usr/bin/time -v mcl $in -I 6
