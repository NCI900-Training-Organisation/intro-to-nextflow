Multi-step Workflows
-------------------------

.. admonition:: Overview
   :class: Overview

    * **Tutorial:** 30 min

        **Objectives:**
            - Learn how to implement multi-step workflows.



Connecting multiple processes is essential for building real-world workflows. Here we look into how to
link them in a multi-step pipeline.


.. code-block:: nextflow
    :linenos:

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

    params.message = '../data/data_message.csv'

    workflow {
    
        message_ch = Channel.fromPath(params.message)
                         .view { "Before splitCsv: $it" }
                         .splitCsv()
                         .view { "After splitCsv: $it" }
                         .map { item -> item[0] }
                         .view { "After map: $it" }
    
        sayHello(message_ch)
    
        convertToUpper(sayHello.out)
    }

`convertToUpper` is the second `process` in the workflow. It uses the `tr` command within UNIX to convert
a string to uppercase.

.. code-block:: bash
    :linenos:

   echo 'Hello World' | tr '[a-z]' '[A-Z]' 

Nextflow follows a dataflow model, allowing process outputs to seamlessly feed into other processes.
By default, a process's output is stored in `<process>.out`, so `sayHello.out` can be directly used 
as input for `convertToUpper()`.


Run the following workflow:

.. code-block:: bash
    :linenos:

    nextflow run 10_upper_case.nf


How can we process multiple output files from one process into a single file? Or combine different 
files from a process into a single summary file?


To illustrate this, we add another process to the workflow that executes the following command:

.. code-block:: bash
    :linenos:

    echo 'Hello' | tr '[a-z]' '[A-Z]' > UPPER-Hello-output.txt
    echo 'Bonjour' | tr '[a-z]' '[A-Z]' > UPPER-Bonjour-output.txt
    echo 'Holà' | tr '[a-z]' '[A-Z]' > UPPER-Holà-output.txt
    cat UPPER-Hello-output.txt UPPER-Bonjour-output.txt UPPER-Holà-output.txt > COLLECTED-output.txt



.. code-block:: nextflow
    :linenos:

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

    .....
    .....
    
    workflow {
    
        message_ch = Channel.fromPath(params.message)
                         .view { "Before splitCsv: $it" }
                         .splitCsv()
                         .view { "After splitCsv: $it" }
                         .map { item -> item[0] }
                         .view { "After map: $it" }
    
        sayHello(message_ch)
    
        convertToUpper(sayHello.out)

        collectGreetings(convertToUpper.out)
    }

.. admonition:: Explanation
   :class: attention

    #. The `path` prefix works for multiple files, so no special handling is needed.  
    #. The process must handle any number of input files dynamically.  
    #. If the input channel contains `[file1.txt, file2.txt, file3.txt]`, Nextflow should generate `cat file1.txt file2.txt file3.txt`.  
    #. Simply using `cat ${input_files}` in the script allows Nextflow to handle this automatically.


Run the following workflow and test if you are getting the expected output:

.. code-block:: bash
    :linenos:

    nextflow run 11_collect.nf


The collection step ran separately for each greeting, which is not the intended behavior. To ensure 
the third step processes all items from `convertToUpper()` together, we need to explicitly instruct 
Nextflow.

Collect() Operator
^^^^^^^^^^^^^^^^^^^^^^

The collect operator collects all items from a source channel into a list and emits it as a single 
item.


.. code-block:: nextflow
    :linenos:

    sayHello(message_ch)

    convertToUpper(sayHello.out)

    collectGreetings(convertToUpper.out.collect())

Run the following workflow:

.. code-block:: bash
    :linenos:

    nextflow run 12_collect_corrected.nf



.. admonition:: Key Points  
   :class: hint  

   #. In Nextflow, multiple computational steps can be combined into a single workflow. 
   #. The `collect` operator gathers all channel items into a list and emits them as a single item.
   
