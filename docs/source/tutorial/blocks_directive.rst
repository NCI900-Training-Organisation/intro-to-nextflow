Blocks and Directives
-------------------------

.. admonition:: Overview
   :class: Overview

    * **Tutorial:** 10 min

        **Objectives:**
            #. Learn the difference between blocks and directives in NextFlow.



In Nextflow, **blocks** and **directives** serve different purposes in defining and controlling 
workflow execution.

What are Blocks?
^^^^^^^^^^^^^^^^^^^^^^

Blocks define **logical sections** of a Nextflow script, such as `process`, `workflow`, and `channel`. 
They contain execution logic and define how tasks are structured.

**Common Blocks:**

- `process`: Defines a computational task.
- `workflow`: Manages the execution flow of processes.
- `channel`: Defines input/output data channels.

**Example of Blocks:**

.. code-block:: nextflow

    process sayHello {
        script:
        """
        echo "Hello, Nextflow!" > output.txt
        """
    }

    workflow {
        sayHello()
    }

What are Directives?
^^^^^^^^^^^^^^^^^^^^^^

Directives are **configuration instructions** inside a `process` block. They control execution 
behavior, such as input/output handling and resource allocation.

**Common Directives:**

- `input`: Defines input parameters/files.
- `output`: Specifies expected output files or channels.
- `script`: Specifies the execution script.
- `publishDir`: Defines where output files are stored.
- `cpus`: Specifies the number of CPU cores.
- `memory`: Allocates the required memory.

**Example of Directives:**

.. code-block:: nextflow

    process sayHello {
        output:
            path 'output.txt'  // Defines output file

        script:
        """
        echo "Hello, Nextflow!" > output.txt
        """
    }

Key Differences
^^^^^^^^^^^^^^^^^^^^^^


.. list-table:: Blocks vs. Directives in Nextflow
   :widths: 25 35 40
   :header-rows: 1

   * - Feature
     - Blocks
     - Directives
   * - Purpose
     - Define script sections.
     - Configure process execution.
   * - Scope
     - Used at the top level (e.g., `process`, `workflow`).
     - Used inside `process` blocks.
   * - Function
     - Controls execution flow.
     - Controls execution settings.
   * - Example
     - `process`, `workflow`, `channel`.
     - `input`, `output`, `script`, `cpus`, `memory`.

