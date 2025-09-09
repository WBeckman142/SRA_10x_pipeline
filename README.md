# SRA_10x_pipeline

A custom Nextflow pipeline for processing 10x Genomics single-cell RNA-seq data retrieved from the NCBI SRA database.

---

## 📌 Overview

This pipeline automates the download, preprocessing, and analysis of single-cell RNA sequencing (scRNA-seq) data from the NCBI SRA. It leverages Nextflow to ensure reproducibility and scalability across different computing environments.

---

## ⚙️ Features

- **Data Download**: Automatically fetches raw sequencing data from NCBI SRA.
- **Preprocessing**: Converts SRA files to FASTQ format.
- **Quality Control**: Performs initial quality checks on the data.
- **Analysis**: Processes data using 10x Genomics Cell Ranger or other compatible tools.
- **Output**: Generates processed gene expression matrices ready for downstream analysis.

---

## 📂 Directory Structure

```plaintext
SRA_10x_pipeline/
├── _nextflow_files/               # Nextflow modules and scripts
├── txt_inputs/                    # Input files (e.g., SRA accession numbers)
├── nextflow.config                 # Nextflow configuration file
├── LICENSE                        # Project license
├── README.md                      # Project documentation
└── .gitignore                     # Git ignore rules
