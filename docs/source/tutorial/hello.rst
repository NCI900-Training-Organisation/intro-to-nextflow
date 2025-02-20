Hello World
------------------

.. admonition:: Overview
   :class: Overview

    * **Tutorial:** 10 min

        **Objectives:**
            #. Learn the how to write a minimal NextFlow workflow.


This Nextflow script defines a simple workflow that writes "Hello World!" to a file.

.. code-block:: nextflow
    :linenos:

    #!/usr/bin/env nextflow


    process sayHello {

        output:
            path 'output.txt'

        script:
        """
        echo 'Hello World!' > output.txt
        """
    }

    workflow {
        sayHello()
    }


Process Block
^^^^^^^^^^^^^^^^^^^^

A `process` in Nextflow is a unit of execution that runs independently. Here the process is 
called **sayHello**.

Output Directive
^^^^^^^^^^^^^^^^^^^^

The `output` directive declares that this process produces an output file named `output.txt`.
This file can be used as an input for other processes in a larger workflow.

Script Directive
^^^^^^^^^^^^^^^^^^^^

The `script` directive defines defines the script that runs inside the process. This script writes 
"Hello World!" into output.txt. 

.. admonition:: Explanation
   :class: attention

    The script directive is enclosed in triple quotes (""" or ''') because it contains a multi-line 
    shell script. This ensures that the script is correctly interpreted and formatted.


Script Block
^^^^^^^^^^^^^^^^^^^^

The workflow block defines the execution order of processes. In this script it calls the `sayHello` 
process, executing it.

.. admonition:: Key Points
   :class: hint

    #. Nextflow enables scalable, reproducible, and parallel workflow execution.
    #. Processes are defined as independent tasks that communicate via data channels.
    #. Nextflow integrates with containers and cloud platforms for seamless execution.
    #. Caching and resuming features optimize workflow efficiency.

