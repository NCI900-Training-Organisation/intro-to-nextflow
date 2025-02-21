Modules
-------------------------

.. admonition:: Overview
   :class: Overview

    * **Tutorial:** 15 min

        **Objectives:**
            - Learn how to divide the workflows into different modules.



This section explains how to structure your workflow using modules for better development, maintenance, and scalability.

The best practice is to store modules in a dedicated directory, typically named `modules` by convention. In this example we have move the process
to `modules/sayHello.nf`. This process is the included in the root file using the include `diretive`.


.. code-block:: nextflow
    :linenos:

    include { sayHello } from './modules/sayHello.nf'



.. admonition:: Explanation
   :class: attention

   `include { <MODULE_NAME> } from <path_to_module>` is the syntax we use to include modules. 
   `sayHello` is the name of the module and modules/sayHello.nf is the path where the module is defined. 


Run the following workflow:

.. code-block:: bash
    :linenos:

    nextflow run 15_modules.nf


Exercise
^^^^^^^^^

- Create a new module for `convertToUpper`.


.. admonition:: Key Points  
   :class: hint  

   #. We can divide the NextFlow script into modules. 
   #. This makes it more maintainable and scalable. 
   
