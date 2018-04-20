#!/bin/bash

for i in */picard_bam; do
    truncate -s 0 ${i%picard_bam}bam_file_list.txt
done

for bam in $(ls -l */picard_bam/*.bam | awk '{print $NF}'); do
    path=$(echo ${bam} | cut -f 1 -d/)
    echo ${bam} >> ${path}/bam_file_list.txt
done
