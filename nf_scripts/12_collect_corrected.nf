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

/*
 * Use a text replacement tool to convert the greeting to uppercase
 */
process convertToUpper {

    publishDir 'results', mode: 'copy'

    input:
        path input_file

    output:
        path "UPPER-${input_file}"

    script:
    """
    cat '$input_file' | tr '[a-z]' '[A-Z]' > 'UPPER-${input_file}'
    """
}

process collectGreetings {

    publishDir 'results', mode: 'copy'

    input:
        path input_files

    output:
        path "COLLECTED-output.txt"

    script:
    """
    cat ${input_files} > 'COLLECTED-output.txt'
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

    // convert the greeting to uppercase
    convertToUpper(sayHello.out)

    // collect all the greetings into one file
    collectGreetings(convertToUpper.out.collect())

    // optional view statements
    convertToUpper.out.view { "Before collect: $it" }
    convertToUpper.out.collect().view { "After collect: $it" }
}

