#!/bin/bash

#$ -V
#$ -cwd
#$ -q all.q
#$ -pe smp 1

module load mcl/14-137

/usr/bin/time -v clm order -o seq.mcltree out.ecoli60.mci.I{14,20,60}

mcxdump -imx-tree seq.mcltree -tab ../results/ecoli.dict --newick -o tree.nwk
