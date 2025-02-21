Multi-outputs from a Process
-------------------------

.. admonition:: Overview
   :class: Overview

    * **Tutorial:** 15 min

        **Objectives:**
            - Learn how to manage multiple outputs from a process.



Most processes will have multiple inputs. This section demonstrates how to handle them.


.. code-block:: nextflow
    :linenos:

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


    workflow {
  
        .....

        collectGreetings(convertToUpper.out.collect(), params.batch)

        collectGreetings.out.count.view { "There were $it greetings in this batch" }

        .....
    }

.. admonition:: Explanation
   :class: attention

    In Nextflow, the emit keyword is used inside a process to explicitly define and name output channels.

Run the following workflow:

.. code-block:: bash
    :linenos:

    nextflow run 14_multi_output.nf


 
.. admonition:: Key Points  
   :class: hint  

   #. Processes can have have multiple inputs.  
   #. The `emit` keyword allows naming specific output channels, making it easier to reference them in the workflow.