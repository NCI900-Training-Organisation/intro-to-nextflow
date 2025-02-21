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

params.message = ['Hello','Bonjour','Holà']

workflow {

    // create a channel for inputs
    message_ch = Channel.of('Hello','Bonjour','Holà')

    // emit a greeting
    sayHello(message_ch)
}

