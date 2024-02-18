#!/bin/bash

#$ -V
#$ -cwd
#$ -q all.q
#$ -pe smp 1

module load mcl/14-137

/usr/bin/time -v clm close -imx ../results/ecoli60.mci --write-cc -o ../results/seq.base
