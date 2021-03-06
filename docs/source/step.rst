Build Steps Example
===================

How to add build step information to your model using OpenSDraw.

Step 1
------

Import the *ldu* conversion library. ::

  (import ldu :local)

Step 2
------

Create the .lcad file. ::

  (for (i 20)
   (rotate (list 0 (* i (/ 360.0 20)) 0)
    (translate (list (bw 6.3) (if (= (% i 2) 0) 0 (bw 1)) 0)
     (part "32523" 14 i)))

   (rotate (list 0 (+ (* i (/ 360.0 20)) (* 0.5 (/ 360.0 20))) 0)
    (translate (list (bw 6.4) (bw 0.5) 0)
     (rotate (list 0 0 90)
      (part "3673" "black" i)))))

.. note::

   The **part()** function takes an optional third argument which is the build step number.

.. note::

   The step number does not have to be an integer, floating point numbers are also ok. Steps are ordered using the Python **sorted()** function.

.. note::

   We don't use the *locate* library functions **sbs()** or **tbs()** because we want to translate first, then rotate.

Step 3
------
Convert the .lcad file to a .mpd file using *lcad_to_ldraw.py*. ::
  
  cd opensdraw/opensdraw/examples
  python ../scripts/lcad_to_ldraw.py steps.lcad

Step 4
------
Load the .mpd file with your favorite viewer (LDView renderings shown here).

.. figure:: step8.png
   :align: center

   Step 8

.. figure:: step20.png
   :align: center

   Step 20

.. note::

   The complete code is in the examples folder (steps.lcad).

.. note::

   There is also a global *step-offset* symbol, see examples/auto-step.lcad for an example of how to use this.
