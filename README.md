# A simple and robust plate-based single cell ATAC-seq (scATAC-seq) method
This repository contains codes for processing and anlaysing scATAC-seq data.

## Usage

Follow the notebook for the data analysis:

`1.exploratory_analysis_all.ipynb` contains information about the quality control and other basic information about all experiments.

`2.cell_type_identification.ipynb` is the analysis for the identification of different cell types in the mouse spleen based on the scATAC-seq profiles.

`3.motif_enrichment_analysis.ipynb` is used to generate the heatmap representation of known motifs enrichment by HOMER.

This repository only contains necessary files used to reproduce the analyses and figures. Raw data and any intermediate file are not included. To reproduce the full analysis, download the fastq files from ArrayExpress (NUMBER), and put them in the fastq directories under `mSp_scATAC-seq/rep{1..11}/fastq/`. Then run the pipeline using snakemake using the Snakefile provided.

For the analysis of the ImmGen bulk ATAC-seq and the Fluidigm C1 scATAC-seq data, download the fastq files (url and study accession number provided in the correponding directories) into the fastq directory and run snakemake in the same way. Or, you can use [stream_ena](http://www.nxn.se/valent/streaming-rna-seq-data-from-ena) to avoid downloading fastq files to save space.

Large files are handled by `git fls`. However, I have used all my git lfs bandwidth this month. The count matrix `mSp_scATAC_count_matrix_over_all.mtx` is not in this repository. For now, download the count file from here: `ftp://ngs.sanger.ac.uk/production/teichmann/xi/plate_scATAC-seq`, and put it under `cmp_to_immgen/`, and the notebook should run without any problem.

## Requirements

```
bedtools (v2.27.1)
hisat2 (v2.1.0)
macs2 (v2.1.1.20160309)
samtools (v1.7)
snakemake (v4.7.0)
```

You also need `calc`, `addCols`, `bedClip` and `bedGraphToBigWig` from [UCSC utilities](http://hgdownload.soe.ucsc.edu/admin/exe/).

Finally, you need [bdg2bw](https://gist.github.com/taoliu/2469050) to convert the macs2 generated begraph to bigwig for visualisation.

## Some descriptive plots

![](figures/ucsc_example_cxcr5_locus.jpg)

<img src="figures/fragment_size_distribution.jpg" width="500">

<img src="figures/tss_plot.jpg" width="500">

# Contact
Xi Chen  
xc1@sanger.ac.uk
