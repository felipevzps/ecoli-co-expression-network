#!/bin/bash

#$ -V
#$ -cwd
#$ -q all.q
#$ -pe smp 1

module load mcl/14-137

/usr/bin/time -v mcxdump -icl out.ecoli60.mci.I14 -o dump.out.ecoli60.mci.I14 -tabr ../results/ecoli.dict
/usr/bin/time -v mcxdump -icl out.ecoli60.mci.I20 -o dump.out.ecoli60.mci.I20 -tabr ../results/ecoli.dict
/usr/bin/time -v mcxdump -icl out.ecoli60.mci.I60 -o dump.out.ecoli60.mci.I60 -tabr ../results/ecoli.dict
