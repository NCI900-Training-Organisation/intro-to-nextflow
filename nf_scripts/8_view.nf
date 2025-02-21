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

params.message = ['Hello','Bonjour','Holà']

workflow {

    // declare an array of input greetings
    message_array = ['Hello','Bonjour','Holà']

        // create a channel for inputs
    message_ch = Channel.of(message_array)
                         .view { "Before flatten: $it" }
                         .flatten()
                         .view { "After flatten: $it" }

    // emit a greeting
    sayHello(message_ch)
}

