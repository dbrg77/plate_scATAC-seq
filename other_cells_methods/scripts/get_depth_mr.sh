#!/bin/bash

for i in */hisat2_log; do
    exp=$(echo ${i} | cut -f 1 -d/)
    echo -e "cell\tsequencing_depth" > ${exp}/qc_metrics/sequencing_depth.txt
    echo -e "cell\tmapping_rate" > ${exp}/qc_metrics/mapping_rate.txt
    for j in ${i}/*_aln_sum.txt; do
        depth=$(grep 'reads; of these:' ${j} | awk '{print $1}')
        mr=$(grep overall ${j} | cut -f 1 -d%)
        cell=$(echo ${j} | rev | cut -f 1 -d/ | rev)
        echo -e "${cell%_aln_sum.txt}\t${depth}" >> ${exp}/qc_metrics/sequencing_depth.txt
        echo -e "${cell%_aln_sum.txt}\t${mr}" >> ${exp}/qc_metrics/mapping_rate.txt
    done
done
