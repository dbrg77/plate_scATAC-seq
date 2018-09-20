#!/bin/bash

echo -e "cell\tlibrary_size" > qc_metrics/library_size.txt

for i in */picard_log/*.out; do
    size=$(grep Unknown ${i} | cut -f 10)
    cell=$(echo ${i} | rev | cut -f 1 -d/ | rev)
    echo -e "${cell%_f2q30_pmd.out}\t${size}" >> qc_metrics/library_size.txt
done
