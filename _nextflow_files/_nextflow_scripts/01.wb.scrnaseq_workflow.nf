#!/usr/bin/env nextflow

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
* Import srr_codes.txt containing SRR codes of files for download
* Import raw fastq files
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

input_sra_codes = 'txt_inputs/srr_codes.txt'

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
* Define params
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

// Default: no limit (download all reads)
params.max_reads = params.max_reads ?: null

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
* Create channels
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

srr_ch          = Channel.fromPath(input_sra_codes)
                         .splitText()
                         .map { it.trim() }

index_ch        = Channel.value("${launchDir}/reference_genome")

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
* Import modules from nextflow_files/nextflow_modules folder
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

include { sradownloader          } from "${launchDir}/_nextflow_files/_nextflow_modules/SRADownloader.nf"
include { run_fastqc             } from "${launchDir}/_nextflow_files/_nextflow_modules/FASTQC_module.nf"
include { download_transcriptome } from "${launchDir}/_nextflow_files/_nextflow_modules/Download_transcriptome.nf"
include { run_kb_count           } from "${launchDir}/_nextflow_files/_nextflow_modules/Kb_count.nf"


/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
* Run workflow using imported modules
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

workflow{

    // download fastq files from SRA using fastq-dump
    fastq_ch = sradownloader(srr_ch)

    // run fastqc
    run_fastqc(fastq_ch)

    // download and unzip the GRCh38 transcriptome fasta file from ENSEMBL
    intermediate_ref = download_transcriptome()

    // create tuple for bowtie2
    read_pairs_ch = fastq_ch.map { srr_id, read1, read2 ->
        tuple(srr_id.trim(), read1, read2)}

    index_ch = Channel.of(
    [ file("${launchDir}/reference_transcriptome/index.idx"), 
      file("${launchDir}/reference_transcriptome/t2g.txt") ]) 

    run_kb_count(read_pairs_ch, index_ch)

}
