#!/bin/bash

for i in */picard_bam; do
    exp=$(echo ${i} | cut -f 1 -d/)
    echo -e "cell\tfrac_open" > ${exp}/qc_metrics/frac_open.txt
    for j in ${i}/*.bam; do
        total=$(wc -l ${exp}/aggregate/aggregated_scATAC_peaks.narrowPeak | awk '{print $1}')
        cov=$(intersectBed -a ${exp}/aggregate/aggregated_scATAC_peaks.narrowPeak -b ${j} -wa -u | wc -l)
        frac=$(calc $cov/$total | awk '{print $3}')
        cell=$(echo ${j} | rev | cut -f 1 -d/ | rev)
        echo -e "${cell%_f2q30_pmd.bam}\t${frac}" >> ${exp}/qc_metrics/frac_open.txt
    done
done

