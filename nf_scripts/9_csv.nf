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

params.message = '../data/data_message.csv'

workflow {
    // create a channel for inputs
    message_ch = Channel.fromPath(params.message)
                     .view { "Before splitCsv: $it" }
                     .splitCsv()
                     .view { "After splitCsv: $it" }
                     .map { item -> item[0] }
                     .view { "After map: $it" }

    // emit a greeting
    sayHello(message_ch)
}

