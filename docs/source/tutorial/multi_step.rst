Multi-step Workflows
-------------------------

.. admonition:: Overview
   :class: Overview

    * **Tutorial:** 15 min

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



.. admonition:: Explanation
   :class: attention

   The `map()` operator is a versatile tool for transforming channel contents. Here, it is used to extract a specific element from each line of the 
   input file.
   

Run the following workflow:

.. code-block:: bash
    :linenos:

    nextflow run 9_csv.nf -ansi-log false



Exercise
^^^^^^^^^

- What happens when you use `flatten()` instead of `splitCsv`?
- What happens when you dont use `map`?


.. admonition:: Key Points  
   :class: hint  

   #. Input values can be stored in a file and processed using `Channel.fromPath()`.  
   #. The `splitCsv()` operator splits CSV-formatted text into an array of values per line.  
   #. The `map()` operator extracts specific elements from each row for further processing.  
   
