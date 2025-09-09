# SRA_10x_pipeline

A custom Nextflow pipeline for processing 10x Genomics single-cell RNA-seq data retrieved from the NCBI SRA database.

---

## 📌 Overview

This pipeline automates the download, preprocessing, and analysis of single-cell RNA sequencing (scRNA-seq) data from the NCBI SRA. It processes 10x Genomics scRNA-seq data where the cell barcodes and UMIs are in R1.fastq and transcript sequences are in R2.fastq. Nextflow to ensure reproducibility and scalability across different computing environments.

---

## ⚙️ Features

- **Data Download**: Automatically fetches raw sequencing data from NCBI SRA.
- **Preprocessing**: Converts SRA files to FASTQ format.
- **Quality Control**: Performs initial quality checks on the data using FastQC.
- **Analysis**: Processes data using kallisto | bustools.
- **Output**: Generates processed gene expression matrices ready for downstream analysis.

---

## 📂 Directory Structure

```plaintext
SRA_10x_pipeline/
├── _nextflow_files/               # Nextflow modules and scripts
├── txt_inputs/                    # Input files (e.g., SRA accession numbers)
├── nextflow.config                # Nextflow configuration file
├── LICENSE                        # Project license
├── README.md                      # Project documentation
├── Data/                          # Deposits raw fastq files and unfiltered counts
├── reference_transcriptome/       # Deposits GRCh38 reference transcriptome
└── .gitignore                     # Git ignore rules
