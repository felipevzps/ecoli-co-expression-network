#!/bin/bash

#$ -V
#$ -cwd
#$ -q all.q
#$ -pe smp 1

module load mcl/14-137

/usr/bin/time -v clm order -o ../results/seq.mcltree ../results/out.ecoli60.mci.I{14,20,60}

mcxdump -imx-tree ../results/seq.mcltree -tab ../results/ecoli.dict --newick -o ../results/tree.nwk
