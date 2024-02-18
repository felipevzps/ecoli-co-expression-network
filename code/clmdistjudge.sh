#!/bin/bash

#$ -V
#$ -cwd
#$ -q all.q
#$ -pe smp 1

module load mcl/14-137

/usr/bin/time -v clm dist ../results/P1 ../results/out.ecoli60.mci.I14
/usr/bin/time -v clm dist ../results/P2 ../results/out.ecoli60.mci.I20
/usr/bin/time -v clm dist ../results/P3 ../results/out.ecoli60.mci.I60
