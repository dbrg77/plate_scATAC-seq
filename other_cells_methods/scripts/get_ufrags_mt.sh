#!/bin/bash

for i in */picard_bam; do
    exp=$(echo ${i} | cut -f 1 -d/)
    echo -e "cell\tuniq_frags" > ${exp}/qc_metrics/uniq_nuc_frags.txt
    echo -e "cell\tmt_content" > ${exp}/qc_metrics/mt_content.txt
    for j in ${i}/*.bam; do
        cell=$(echo ${j} | rev | cut -f 1 -d/ | rev)
        tread=$(samtools idxstats ${j} | addCols stdin | awk '{print $3}')
        mt=$(samtools idxstats ${j} | grep chrM | awk '{print $3}')
        nread=$(calc ${tread}-${mt} | awk '{print $3}')
        nfrag=$(calc ${nread}/2 | awk '{print $3}')
        p=$(calc ${mt}/${tread} | awk '{print $3}')
        echo -e "${cell%_f2q30_pmd.bam}\t${nfrag}" >> ${exp}/qc_metrics/uniq_nuc_frags.txt
        echo -e "${cell%_f2q30_pmd.bam}\t${p}" >> ${exp}/qc_metrics/mt_content.txt
    done
done

