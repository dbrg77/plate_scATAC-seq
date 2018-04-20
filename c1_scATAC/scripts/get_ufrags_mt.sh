#!/bin/bash

echo -e "cell\tuniq_frags" > qc_metrics/uniq_frags.txt
echo -e "cell\tmt_content" > qc_metrics/mt_content.txt

for i in */*/picard_bam/*.bam; do
    cell=$(echo ${i} | rev | cut -f 1 -d/ | rev)
    tread=$(samtools idxstats ${i} | addCols stdin | awk '{print $3}')
    mt=$(samtools idxstats ${i} | grep chrM | awk '{print $3}')
    nread=$(calc ${tread}-${mt} | awk '{print $3}')
    nfrag=$(calc ${nread}/2 | awk '{print $3}')
    p=$(calc ${mt}/${tread} | awk '{print $3}')
    echo -e "${cell%_f2q30_pmd.bam}\t${nfrag}" >> qc_metrics/uniq_frags.txt
    echo -e "${cell%_f2q30_pmd.bam}\t${p}" >> qc_metrics/mt_content.txt
done
