#!/bin/bash

#$ -V
#$ -cwd
#$ -q all.q
#$ -pe smp 1

module load mcl/14-137

/usr/bin/time -v clm dist P1 out.ecoli60.mci.I14
/usr/bin/time -v clm dist P2 out.ecoli60.mci.I20
/usr/bin/time -v clm dist P3 out.ecoli60.mci.I60
