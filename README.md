# nimrat [![Build Status](https://circleci.com/gh/apense/nimrat.png)](https://circleci.com/gh/apense/nimrat)

This module implements some very basic rational arithmetic in Nim.

Example:

```nim
import nimrat

var 
  myFrac: Rational = (3,4) # the fraction 3/4
  myFrac2: Rational = (7,8) # the fraction 7/8
    
echo myFrac + myFrac2
# Prints "13 / 8"
echo myFrac * myFrac2
# Prints "21 / 32"
echo myFrac / myFrac2
# Prints "6 / 7"
echo simple((33,44)) # reduced form of a given fraction
# Prints "3 / 4"
# Note, to actually simplify, do:
var unSimple = (4,8)
unSimple.simplify # actually modifies the rational
echo unSimple
# Prints (1,2)
```