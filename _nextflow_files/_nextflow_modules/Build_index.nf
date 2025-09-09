#!/usr/bin/env nextflow

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
* Build the index using kallisto
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

 process build_index {


    publishDir 'reference_transcriptome', mode: 'copy'
    container 'community.wave.seqera.io/library/kb-python:0.29.5--7c5fc7f840a2774f'

    input:
       tuple (path('Homo_sapiens.GRCh38.cdna.all.fa'),
       path('Homo_sapiens.GRCh38.110.gtf'))

    output:
       path('*.idx')
       path('*.txt')
       path('*.fa')

    script:
    
    """
    kb ref -i GRCh38_index.idx -g t2g.txt -f1 transcripts.fa Homo_sapiens.GRCh38.cdna.all.fa Homo_sapiens.GRCh38.110.gtf
    """
   }


