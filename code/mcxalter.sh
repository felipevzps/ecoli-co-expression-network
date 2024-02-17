#!/bin/bash

#$ -V
#$ -cwd
#$ -q all.q
#$ -pe smp 1

module load mcl/14-137

in=`ls -1 ../results/ecoli20.mci`

/usr/bin/time -v mcx alter -imx $in -tf 'gq(0.6), add(-0.6)' -o ../results/ecoli60.mci
