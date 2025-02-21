Hello World
------------------

.. admonition:: Overview
   :class: Overview

    * **Tutorial:** 10 min

        **Objectives:**
            - Learn the how to write a minimal NextFlow workflow.


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


Workflow Block
^^^^^^^^^^^^^^^^^^^^

The workflow block defines the execution order of processes. In this script it calls the `sayHello` 
process, executing it.


When you run Nextflow in a directory for the first time, it automatically creates a **`work/`** directory to store all generated files and symlinks during execution.  

Inside the `work/` directory, Nextflow organizes outputs and logs for each process call. For every execution of a process, it creates a uniquely named subdirectory (using a hash) where it:  
- Stages input files (linked via symlinks by default).  
- Stores helper files and execution logs.  
- Writes process output files.  

The path to each process-specific subdirectory is displayed in **truncated form** within square brackets in the console output.

.. admonition:: Key Points
   :class: hint

    #. Process Block defines an independent execution unit (`sayHello`), which runs a script to generate an output file.  
    #. Directives - The `output` directive specifies that `output.txt` is produced, while the `script` directive contains a shell script to write "Hello World!" into the file.  
    #. Workflow Block determines execution order by calling `sayHello()`, triggering the process to run.  
    #. Work Directory - Nextflow creates a `work/` directory, organizing process outputs in uniquely named subdirectories, storing logs, inputs, and outputs.

