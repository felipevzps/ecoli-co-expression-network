#!/bin/bash

#$ -q all.q
#$ -cwd
#$ -V
#$ -pe smp 1

IN_FILE=../results/dump.out.ecoli60.mci.I
OUT_FILE=../results/dump.out.ecoli60.mci.I
num=(14 20 60)

## GET COUNTS IN EACH CLUSTER
for i in "${num[@]}"
do
	echo $i
	awk -F' ' '{print NF}' ${IN_FILE}${i} > ${OUT_FILE}${i}.number
done


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
