# A rapid and robust plate-based single cell ATAC-seq (scATAC-seq) method
This repository contains codes for processing and analysing scATAC-seq data for our manuscript. Click [here]() to read the preprint on bioarxiv.

## Usage

Follow the notebook for the data analysis:

`1.exploratory_analysis_all.ipynb` contains information about the quality control and other basic information about all experiments.

`2.cell_type_identification.ipynb` is the analysis for the identification of different cell types in the mouse spleen based on the scATAC-seq profiles.

`3.motif_enrichment_analysis.ipynb` is used to generate the heatmap representation of known motifs enrichment by HOMER.

This repository only contains necessary files used to reproduce the analyses and figures. Raw data and any intermediate file are not included. To reproduce the full analysis, download the fastq files from ArrayExpress (E-MTAB-6714), and put them in the fastq directories under `mSp_scATAC-seq/rep{1..11}/fastq/`. Then run the pipeline using snakemake using the Snakefile provided. Currently, the ArrayExpress submission is under curation, fastq files can be downloaded from this address: `ftp://ngs.sanger.ac.uk/production/teichmann/xi/plate_scATAC-seq/`

For the analysis of the ImmGen bulk ATAC-seq and the Fluidigm C1 scATAC-seq experiments, download the raw data (url and study accession number provided in the correponding directories) into the fastq directory and run snakemake in the same way. Or, you can use [stream_ena](http://www.nxn.se/valent/streaming-rna-seq-data-from-ena) to avoid downloading fastq files to save space.

Large files are handled by `git fls`. However, I have used all my git lfs bandwidth this month. The count matrix `mSp_scATAC_count_matrix_over_all.mtx` is not in this repository. For now, download the count file from here: `ftp://ngs.sanger.ac.uk/production/teichmann/xi/plate_scATAC-seq`, and put it under `cmp_to_immgen/`, and the notebook should run without any problem.

## Softwares/Packages

```
macs2 (v2.1.1.20160309) (this needs python2)

# packages installed via conda:
#
# Name                    Version                   Build  Channel
bedtools                  2.27.1                        1    bioconda
cutadapt                  1.16                     py36_1    bioconda
hisat2                    2.1.0            py36pl5.22.0_0    bioconda
homer                     4.9.1                pl5.22.0_5    bioconda
matplotlib                2.2.2                     <pip>
MulticoreTSNE             0.1                       <pip>
numpy                     1.14.2          py36_blas_openblas_200  [blas_openblas]  conda-forge
pandas                    0.22.0           py36hf484d3e_0
salmon                    0.9.1                         1    bioconda
samtools                  1.7                           2    bioconda
scikit-learn              0.19.1          py36_blas_openblas_201  [blas_openblas]  conda-forge
scipy                     1.0.1           py36_blas_openblas_200  [blas_openblas]  conda-forge
seaborn                   0.8.1                    py36_0    conda-forge
seqtk                     1.2                           1    bioconda
snakemake                 4.7.0                    py36_0    bioconda
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
