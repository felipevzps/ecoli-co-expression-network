#!/bin/bash

#$ -V
#$ -cwd
#$ -q all.q
#$ -pe smp 1

module load mcl/14-137

in=`ls -1 ../data/E_coli_v4_Build_6/avg_E_coli_v4_Build_6_exps466probes4297.tab`

/usr/bin/time -v mcxarray -data $in -co 0.2 -skipr 1 -skipc 1 -tf 'abs()' -o ../results/ecoli20.mci -write-tab ../results/ecoli.dict
