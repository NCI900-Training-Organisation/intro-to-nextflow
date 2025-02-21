#!/usr/bin/env nextflow

process sayHello {

    publishDir 'results', mode: 'copy'

    input:
        val message

    output:
        path "${message}-output.txt"

    script:
    """
    echo '$message' > '$message-output.txt'
    """
}

params.message = '¡Buenos días!'

workflow {

    // create a channel for inputs
    message_ch = Channel.of('Hello','Bonjour','Holà')

    // emit a greeting
    sayHello(message_ch)
}

