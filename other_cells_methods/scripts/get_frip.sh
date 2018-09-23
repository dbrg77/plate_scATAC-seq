#!/bin/bash

for i in */picard_bam; do
    exp=$(echo ${i} | cut -f 1 -d/)
    echo -e "cell\tfrip" > ${exp}/qc_metrics/frip.txt
    for j in ${i}/*.bam; do
        cell=$(echo ${j} | rev | cut -f 1 -d/ | rev)
        total=$(samtools idxstats ${j} | addCols stdin | awk '{print $3}')
        peaks=$(intersectBed -a ${j} -b ${exp}/aggregate/aggregated_scATAC_peaks.narrowPeak -bed -wa -u | wc -l)
        frip=$(calc $peaks/$total | awk '{print $3}')
        echo -e "${cell%_f2q30_pmd.bam}\t${frip}" >> ${exp}/qc_metrics/frip.txt
    done
done

