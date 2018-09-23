#!/bin/bash

for i in */picard_log; do
    exp=$(echo ${i} | cut -f 1 -d/)
    echo -e "cell\tlibrary_size" > ${exp}/qc_metrics/library_size.txt
    for j in ${i}/*.out; do
        size=$(grep Unknown ${j} | cut -f 10)
        cell=$(echo ${j} | rev | cut -f 1 -d/ | rev)
        echo -e "${cell%_f2q30_pmd.out}\t${size}" >> ${exp}/qc_metrics/library_size.txt
    done
done
