#!/usr/bin/env nextflow

process sayHello {

    publishDir 'results', mode: 'copy'

    output:
        path 'output.txt'

    script:
    """
    echo 'Hello World!' > output.txt
    """
}

workflow {
    sayHello()
}