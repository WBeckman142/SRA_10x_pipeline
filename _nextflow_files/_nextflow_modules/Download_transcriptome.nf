#!/usr/bin/env nextflow

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
* Download and unzip the GRCh38 transcriptome fasta file from ENSEMBL
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

 process download_transcriptome {

   

    publishDir 'reference_transcriptome', mode: 'copy'
    container ''

    input:
       

    output:
       tuple(path('index.idx'),
       path('t2g.txt'))

    script:
    
    """
    wget -O human_index_standard.tar.xz https://github.com/pachterlab/kallisto-transcriptome-indices/releases/download/v1/human_index_standard.tar.xz \
    && tar -xvf human_index_standard.tar.xz

    """
   }

