#!/bin/bash

#$ -V
#$ -cwd
#$ -q all.q
#$ -pe smp 1

module load mcl/14-137

/usr/bin/time -v clxdo granularity ../results/seq.base ../results/out.ecoli60.mci.I{14,20,60}

# minimum cluster size 
#/usr/bin/time -v clxdo granularity_gq 5 ../results/seq.base ../results/out.ecoli60.mci.I{14,20,60}
