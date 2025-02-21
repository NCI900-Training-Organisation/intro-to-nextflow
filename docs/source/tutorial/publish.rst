Publish Outputs
-------------------------

.. admonition:: Overview
   :class: Overview

    * **Tutorial:** 10 min

        **Objectives:**
            - Learn how to use a user specified output directory.



By default, pipeline output is stored deep within the `work` directory. To simplify access, Nextflow
provides the `publishDir` directive, which operates at the process level. This directive ensures 
that process outputs are copied or linked to a specified directory, making them easier to manage and 
retrieve.

.. code-block:: nextflow
    :linenos:

    #!/usr/bin/env nextflow

    process sayHello {

        publishDir 'results', mode: 'copy'

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

.. admonition:: Explanation
   :class: attention

   In Nextflow, the `publishDir` directive supports several modes for handling output files. Aside from `'copy'`, the available modes include:  

    1. `copy`: Copies the output files into the publish directory.
    2. `copyNoFollow`: Copies the output files into the publish directory without following symlinks ie. copies the links themselves.
    3. `link`: Creates a hard link in the publish directory for each output file.
    4. `move`: Moves the output files into the publish directory. Note: this is only supposed to be used for a terminal process i.e. a process whose output is not consumed by any other downstream process.
    5. `rellink`: Creates a relative symbolic link in the publish directory for each output file.
    6. `symlink`: Creates an absolute symbolic link in the publish directory for each output file (default).  

    These modes allow you to control how process outputs are handled and stored in the specified directory.


Exercise
^^^^^^^^^

#. What happens when you change the mode to `link`.
#. What happens when you change the mode to `move`.


.. admonition:: Key Points
   :class: hint

    #. `publishDir` to customize the output directory.
    #. There are different modes available for `publishDir`.
