#!/bin/bash

#$ -q all.q
#$ -cwd
#$ -V
#$ -pe smp 1

dir=../results/dump.out.ecoli60.mci.I*

# Reformat modules output

cd ../results/

for file in $(ls $dir | grep -v number | grep -v formated)
do
	echo $file	
	count=1
	for line in $(cat $file)
	do
        	sed -n "${count}p" $file | awk -F" " -v c="$count" '{for(i=1; i<=NF; i++) {print $i,c}}' >> ${file}.formated.csv
        	let count++
	done
done

cd -
