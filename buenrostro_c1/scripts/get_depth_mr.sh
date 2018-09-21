#!/bin/bash

echo -e "cell\tsequencing_depth" > qc_metrics/sequencing_depth.txt
echo -e "cell\tmapping_rate" > qc_metrics/mapping_rate.txt

for i in */*/hisat2_log/*_aln_sum.txt; do
    depth=$(grep 'reads; of these:' $i | awk '{print $1}')
    mr=$(grep overall ${i} | awk '{print $1}' | cut -f 1 -d%)
    cell=$(echo ${i} | rev | cut -f 1 -d/ | rev)
    echo -e "${cell%_aln_sum.txt}\t${depth}" >> qc_metrics/sequencing_depth.txt
    echo -e "${cell%_aln_sum.txt}\t${mr}" >> qc_metrics/mapping_rate.txt
done
