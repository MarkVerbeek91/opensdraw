### Summary ###
This folder contains the modules that define the lcad language. This is a [prefix](http://en.wikipedia.org/wiki/Polish_notation) notation language similar to [Scheme](http://en.wikipedia.org/wiki/Scheme_%28programming_language%29).

### Files ###
* chain.py - A function for creating chains, tracks, ..
* comparisonFunctions.py - >, <, = , ..
* coreFunctions.py - The basic functions in OpenLDraw.
* curve.py - A function for creating curves (cubic splines).
* functions.py - The LCadFunction and UserFunction classes.
* geometryFunctions.py - Rotate, Translate, ..
* interpreter.py - The lcad language interpreter.
* lcadExceptions.py - Lcad language specific exceptions.
* lexerParser.py - The lexer/parser for the lcad language.
* logicFunctions.py - And, Or, Not.
* mathFunctions.py - /, *, +, -, ..
* parts.py - The Part object.
* randomNumberFunctions.py - Random number generating functions.

### Directories ###
* test - Nose tests.