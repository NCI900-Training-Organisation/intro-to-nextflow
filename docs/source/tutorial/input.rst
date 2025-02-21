Variable Inputs
-------------------------

.. admonition:: Overview
   :class: Overview

    * **Tutorial:** 15 min

        **Objectives:**
            - Learn how to use command line inputs.



`input` directive defines the data or parameters that a process requires to execute.

.. code-block:: nextflow
    :linenos:

    #!/usr/bin/env nextflow

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

    workflow {
        sayHello(params.message)
    }

.. admonition:: Explanation
   :class: attention

   The `val` prefix indicates that `message` is a single value. Instead of hardcoding it 
   `(sayHello('Hello World!'))`, we can `params`, Nextflow's built-in system for command-line 
   inputs. Declaring `params.<parameter_name>` allows passing `--<parameter_name>` when running the 
   workflow.


To pass a value from the commandline and run the workflow we use the command:

.. code-block:: bash
    :linenos:

    nextflow run 3_input.nf --message 'Good Morning!'


Exercise
^^^^^^^^^

- What happens when you dont pass a message?

.. code-block:: bash
    :linenos:

    nextflow run 3_input.nf 


.. admonition:: Key Points
   :class: hint

    #. The `input` directive specifies the required data or parameters for a process. 
    #. The `val` prefix defines `message` as a single value, which can be passed dynamically instead of hardcoding it.  
    #. Nextflow's `params` system allows command-line input. 