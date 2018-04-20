#!/bin/bash

echo -e "cell\tfrac_open" > qc_metrics/frac_open.txt

for i in */picard_bam/*.bam; do
    total=$(wc -l aggregate/aggregated_scATAC_peaks.narrowPeak | awk '{print $1}')
    cov=$(intersectBed -a aggregate/aggregated_scATAC_peaks.narrowPeak -b ${i} -wa -u | wc -l)
    frac=$(calc $cov/$total | awk '{print $3}')
    cell=$(echo ${i} | rev | cut -f 1 -d/ | rev)
    echo -e "${cell%_f2q30_pmd.bam}\t${frac}" >> qc_metrics/frac_open.txt
done
