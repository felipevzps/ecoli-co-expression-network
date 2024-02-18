#!/bin/bash

#$ -V
#$ -cwd
#$ -q all.q
#$ -pe smp 1

module load mcl/14-137

/usr/bin/time -v clm dist --chain ../results/out.ecoli60.mci.I{14,20,60}
