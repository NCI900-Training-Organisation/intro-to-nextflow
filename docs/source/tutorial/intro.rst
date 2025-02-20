What is Nextflow?
------------------

.. admonition:: Overview
   :class: Overview

    * **Tutorial:** 10 min

        **Objectives:**
            #. Learn how Nextflow works.

Nextflow is a powerful workflow automation tool designed for scalable and reproducible data analysis. It simplifies the writing and deployment of complex computational workflows by integrating with multiple execution platforms, including local machines, high-performance computing (HPC) clusters, and cloud environments. Nextflow is widely used in **bioinformatics**, **machine learning**, and **data science** applications where workflow automation is essential.


Process-Oriented Workflow Execution
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Nextflow enables a process-oriented approach to workflow execution, where tasks are defined as 
independent **processes** that communicate through data channels. Each process runs in an isolated 
environment, ensuring reproducibility and scalability.


Here's a breakdown of how Nextflow functions:

1. **Processes and Scripts**: Workflows in Nextflow are composed of multiple **processes**, each defining a computational step. These processes can execute **bash scripts**, **Python scripts**, or any other command-line tool.

2. **Input and Output Channels**: Nextflow uses **channels** to manage data dependencies between processes. Channels define how data flows between tasks, enabling dynamic execution and parallelism.

3. **Execution on Multiple Platforms**: Nextflow can execute workflows on local machines, clusters, and cloud environments such as AWS Batch, Google Cloud, and Kubernetes without modifying the workflow definition.

4. **Container Support**: Nextflow seamlessly integrates with **Docker**, **Singularity**, and **Conda**, allowing processes to run in reproducible environments.

5. **Caching and Resume Feature**: Nextflow caches previously executed steps, making it possible to **resume workflows** without re-running completed processes, which saves time and computing resources.

6. **Scalability and Parallelism**: Nextflow automatically schedules tasks in parallel where possible, optimizing workflow execution for large-scale datasets.


A Simple Nextflow Script
^^^^^^^^^^^^^^^^^^^^^^^^^^

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

This example (`nf_scripts/1_hello_world.nf`) defines a simple **Nextflow workflow** where a process (`sayHello`) generates an 
`output.txt` file containing the text "Hello World!".


Running the Workflow
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To run the script:

.. code-block:: bash
    :linenos:

    nextflow run 1_hello_world.nf

This command triggers Nextflow to execute the process and generate the `output.txt` file.


.. admonition:: Key Points
   :class: hint

    #. Nextflow enables scalable, reproducible, and parallel workflow execution.
    #. Processes are defined as independent tasks that communicate via data channels.
    #. Nextflow integrates with containers and cloud platforms for seamless execution.
    #. Caching and resuming features optimize workflow efficiency.

