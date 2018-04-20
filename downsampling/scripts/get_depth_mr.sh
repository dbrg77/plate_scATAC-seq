#!/bin/bash

for i in */hisat2_mm10_log; do
    frac=$(echo ${i} | cut -f 1 -d/)
    echo -e "cell\tsequencing_depth" > ${frac}/qc_metrics/sequencing_depth.txt
    echo -e "cell\tmapping_rate" > ${frac}/qc_metrics/mapping_rate.txt

    for j in ${i}/*_aln_sum.txt; do
        depth=$(grep 'reads; of these:' ${j} | awk '{print $1}')
        mr=$(grep overall ${j} | awk '{print $1}' | cut -f 1 -d%)
        cell=$(echo ${j} | rev | cut -f 1 -d/ | rev)
        echo -e "${cell%_aln_sum.txt}\t${depth}" >> ${frac}/qc_metrics/sequencing_depth.txt
        echo -e "${cell%_aln_sum.txt}\t${mr}" >> ${frac}/qc_metrics/mapping_rate.txt
    done
done
