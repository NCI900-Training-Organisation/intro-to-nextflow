Multi-inputs to a Process
-------------------------

.. admonition:: Overview
   :class: Overview

    * **Tutorial:** 20 min

        **Objectives:**
            - Learn how to manage multiple inputs to a process.



Most processes require multiple inputs. This section demonstrates how to handle them.


.. code-block:: nextflow
    :linenos:

    process collectGreetings {

        publishDir 'results', mode: 'copy'

        input:
            path input_files
            val batch_name

        output:
            path "COLLECTED-${batch_name}-output.txt"

        script:
            """
            cat ${input_files} > 'COLLECTED-${batch_name}-output.txt'
            """
    }


    workflow {
  
        .....

        // collect all the greetings into one file
        collectGreetings(convertToUpper.out.collect(), params.batch)

        .....
    }


.. admonition:: Explanation
   :class: attention

   Inputs **must** be provided in the exact order they appear in the process's input definition block.


Run the following workflow:

.. code-block:: bash
    :linenos:

    nextflow run 13_multi_input.nf


 
.. admonition:: Key Points  
   :class: hint  

   #. A process in Nextflow can have multiple inputs.  
   #. Inputs must be given in the same order as defined in the process's input block.