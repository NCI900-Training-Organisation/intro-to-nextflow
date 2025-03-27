#!/usr/bin/env nextflow

include { sayHello } from './modules/sayHello.nf'
include { cowpy } from './modules/cowpy.nf'

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
        val batch_name

    output:
        path "COLLECTED-${batch_name}-output.txt", emit: outfile
        val count_greetings , emit: count

    script:
        count_greetings = input_files.size()

        """
        cat ${input_files} > 'COLLECTED-${batch_name}-output.txt'
        """
}

params.message = '../data/data_message.csv'
params.batch = 'test-batch'
params.character = 'turkey'

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
    collectGreetings(convertToUpper.out.collect(), params.batch)

    // emit a message about the size of the batch
    collectGreetings.out.count.view { "There were $it greetings in this batch" }

    // optional view statements
    convertToUpper.out.view { "Before collect: $it" }
    convertToUpper.out.collect().view { "After collect: $it" }

    // generate ASCII art of the greetings with cowpy
    cowpy(collectGreetings.out.outfile, params.character)
}

