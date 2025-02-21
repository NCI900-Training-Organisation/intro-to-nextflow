Reading CSV Files
-------------------------

.. admonition:: Overview
   :class: Overview

    * **Tutorial:** 15 min

        **Objectives:**
            - Learn how to read CSV files.



To process multiple inputs, the input values can be stored in a file.


.. code-block:: nextflow
    :linenos:

    params.message = 'data_message.csv'

    workflow {
        message_ch = Channel.fromPath(params.message)
                     .view { "Before splitCsv: $it" }
                     .splitCsv()
                     .view { "After splitCsv: $it" }
                     .map { item -> item[0] }
                     .view { "After map: $it" }

        sayHello(message_ch)
    }

.. admonition:: Explanation
   :class: attention

   The `splitCsv` operator parses CSV-formatted text from a source channel, splitting each line into an array where each comma-separated value becomes 
   an element. 

.. admonition:: Explanation
   :class: attention

   The `map()` operator is a versatile tool for transforming channel contents. Here, it is used to extract a specific element from each line of the 
   input file.
   

Run the following workflow:

.. code-block:: bash
    :linenos:

    nextflow run 9_csv.nf -ansi-log false



Exercise
^^^^^^^^^

- What happens when you use `flatten()` instead of `splitCsv`?
- What happens when you dont use `map`?


.. admonition:: Key Points  
   :class: hint  

   #. Input values can be stored in a file and processed using `Channel.fromPath()`.  
   #. The `splitCsv()` operator splits CSV-formatted text into an array of values per line.  
   #. The `map()` operator extracts specific elements from each row for further processing.  
   
