Operators
-------------------------

.. admonition:: Overview
   :class: Overview

    * **Tutorial:** 15 min

        **Objectives:**
            - Learn how to use Operators in NextFlow.



`Operators` are methods that consume and produce channels. Because channels are asynchronous, operators are necessary to manipulate the values in a 
channel, without using a process. As a result, operators are useful for implementing the operational logic between processes.


flatten() Operator
^^^^^^^^^^^^^^^^^^^^

.. code-block:: nextflow
    :linenos:

    workflow {

        // declare an array of input greetings
        message_array = ['Hello','Bonjour','Holà']

        message_ch = Channel.of(message_array)
                         .flatten()

        sayHello(message_ch)
    }

.. admonition:: Explanation
   :class: attention

   The `flatten` operator flattens each item from a source channel that is a list or other collection, such that each element in each collection is 
   emitted separately.
   

Run the following workflow:

.. code-block:: bash
    :linenos:

    nextflow run 7_operator_flatten.nf -ansi-log false


view() Directive
^^^^^^^^^^^^^^^^^^^^

`view()` directive allow us to inspect the contents of a channel.

.. code-block:: nextflow
    :linenos:

    // create a channel for inputs
    greeting_ch = Channel.of(greetings_array)
                         .view { "Before flatten: $it" }
                         .flatten()
                         .view { "After flatten: $it" }


.. admonition:: Explanation
   :class: attention

    Here `$it` is an implicit variable that represents each individual item loaded in a channel.


Run the following workflow:

.. code-block:: bash
    :linenos:

    nextflow run 8_view.nf -ansi-log false

Exercise
^^^^^^^^^

- What happens when you use `flatten()`?


.. admonition:: Key Points
   :class: hint

    #. A `channel` enables asynchronous data transfer between processes, supporting parallel execution.  
    #. `Channel.of` allows workflows to accept multiple inputs dynamically.  
    #. Using `-ansi-log false` prevents log overwriting and displays all process logs separately.  
    #. Unique filenames in `publishDir` prevent output overwrites in the `results/` directory. 
    #. Using `.view()` helps inspect data at different stages of processing.  
