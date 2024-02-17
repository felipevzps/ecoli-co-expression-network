#!/bin/bash

#$ -V
#$ -cwd
#$ -q all.q
#$ -pe smp 1

module load mcl/14-137

#/usr/bin/time -v clxdo granularity seq.base out.seq.mci.I{14,20,60}

/usr/bin/time -v clxdo granularity_gq 5 seq.base out.ecoli60.mci.I{14,20,60}
