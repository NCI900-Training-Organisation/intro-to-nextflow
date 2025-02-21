Channels
-------------------------

.. admonition:: Overview
   :class: Overview

    * **Tutorial:** 15 min

        **Objectives:**
            - Learn how to use channels in NextFlow.



A `channel` in Nextflow is a mechanism for passing data between processes. It acts as a queue that allows processes to communicate asynchronously and 
facilitates parallel execution.

.. code-block:: nextflow
    :linenos:

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

    params.message = '¡Buenos días!'

    workflow {
    
        // create a channel for inputs
        message_ch = Channel.of('Hello Channels!')
    
        // emit a greeting
        sayHello(message_ch)
    }

.. admonition:: Explanation
   :class: attention

   There are a variety of channel factories in NextFlow. The most basic channel factory, called Channel.of, creates a channel containing a single value.


Run the following workflow:

.. code-block:: bash
    :linenos:

    nextflow run 4_input.nf


We can upgrade the workflow to accept multiple input values.

.. code-block:: nextflow
    :linenos:

    workflow {
        message_ch = Channel.of('Hello','Bonjour','Holà')
        sayHello(message_ch)
    }



.. code-block:: bash
    :linenos:
    nextflow run 5_multiple_inputs.nf -ansi-log false

.. admonition:: Explanation
   :class: attention

    By default, the ANSI logging system overwrites logs from multiple executions of the same process on a single line. As a result, only one process 
    appears in the log, even if multiple are running. To display all process logs separately, use `-ansi-log false`.


.. admonition:: Explanation
   :class: attention

    Inside the `work/` directory, separate `output.txt` files are created for different inputs, ensuring each execution has its own result. However, 
    in the `results/` directory, only one `output.txt` file is present because the filename is hardcoded. When using `publishDir`, subsequent 
    outputs overwrite the previous ones unless unique filenames or alternative modes are used.

Unique Output Files
^^^^^^^^^^^^^^^^^^^^^

Instead of hardcoding the output filename, we can generate unique filenames for different inputs when using `publishDir`.

.. code-block:: bash
    :linenos:

    nextflow run 6_multiple_outputs.nf -ansi-log false


.. admonition:: Key Points
   :class: hint

    #. A `channel` enables asynchronous data transfer between processes, supporting parallel execution.  
    #. `Channel.of` allows workflows to accept multiple inputs dynamically.  
    #. Using `-ansi-log false` prevents log overwriting and displays all process logs separately.  
    #. Unique filenames in `publishDir` prevent output overwrites in the `results/` directory.  
