#!/bin/bash

#$ -V
#$ -cwd
#$ -q all.q
#$ -pe smp 1

module load mcl/14-137

in=`ls -1 ../results/ecoli20.mci`

/usr/bin/time -v mcx query -imx $in --vary-correlation
