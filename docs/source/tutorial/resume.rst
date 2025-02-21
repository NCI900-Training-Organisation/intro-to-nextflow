Resume Workflow
-------------------------

.. admonition:: Overview
   :class: Overview

    * **Tutorial:** 10 min

        **Objectives:**
            - Learn how to resume a workflow.



Sometimes, you may need to re-run a previously executed pipeline without repeating steps that were 
successfully completed. Nextflow provides the `-resume` option to achieve this. When enabled, it 
skips processes that have already been executed with the same code, settings, and inputs. Only new, 
modified, or reconfigured processes will be re-run, ensuring efficient and incremental execution.

.. code-block:: bash
    :linenos:

    nextflow run 2_publish_dir.nf -resume


.. admonition:: Key Points
   :class: hint

    - With `resume` Nextflow will only run processes that you've added or modified since the last run.
