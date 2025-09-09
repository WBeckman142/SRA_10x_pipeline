#!/usr/bin/env nextflow

process run_kb_count {

    publishDir 'data/counts', mode: 'copy'
    container 'community.wave.seqera.io/library/kb-python:0.29.5--7c5fc7f840a2774f'

    input:
       tuple val(srr), path(read1), path(read2)
       tuple (path(index), path(t2g))

    output:
       path "${srr}/"

    script:
    """
    mkdir ${srr}
    kb count -i ${index} -g ${t2g} -x 10xv3 -o ${srr} ${read1} ${read2} --h5ad
    """
}
