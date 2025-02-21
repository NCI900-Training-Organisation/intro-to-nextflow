#!/usr/bin/env nextflow

process sayHello {

    publishDir 'results', mode: 'copy'

    input:
        val message

    output:
        path 'output.txt'

    script:
    """
    echo '$message' > output.txt
    """
}

params.message = '¡Buenos días!'

workflow {
    sayHello(params.message)
}

