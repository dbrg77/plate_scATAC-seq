#!/bin/bash

for i in */picard_log; do
    exp=$(echo ${i} | cut -f 1 -d/)
    echo -e "cell\tdup_level" > ${exp}/qc_metrics/dup_level.txt
    for j in ${i}/*.out; do
        dup=$(grep Unknown ${j} | cut -f 9)
        cell=$(echo ${j} | rev | cut -f 1 -d/ | rev)
        echo -e "${cell%_f2q30_pmd.out}\t${dup}" >> ${exp}/qc_metrics/dup_level.txt
    done
done
