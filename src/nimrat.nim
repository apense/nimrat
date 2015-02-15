## :Author: Jonathan Edwards
##
## This module implements some very basical rational arithmetic in Nim.
##
## Example
##
## .. code:: nim
##    import nimrat
##
##    var
##      myFrac: Rational = (3,4) # the fraction 3/4
##      myFrac2: Rational = (7,8) # the fraction 7/8
##
##    echo myFrac + myFrac2
##    # Prints "13 / 8"
##    echo myFrac * myFrac2
##    # Prints "21 / 32"
##    echo myFrac / myFrac2
##    # Prints "6 / 7"
##    echo simplify((33,44)) # simplify a given fraction
##    # Prints "3 / 4"

import math, unittest

type
  Rational* = tuple[numer, denom: int] ## Rational as integer numerator and denominator

proc gcd(u1, v1: int): int =
  ## just a local binary GCD
  # not exported because we're only using it here
  if (u1 == 0): return v1
  if (v1 == 0): return u1

  var 
    shift = 0
    (u, v) = (u1, v1)

  while ((u mod 2 == 0) and (v mod 2 == 0)):
    u = u shr 1
    v = v shr 1
    shift += 1

  while (u mod 2 == 0):
    u = u shr 1

  while (v != 0):
    while (v mod 2 == 0):
      v = v shr 1

    if (u > v):
      swap(u,v)

    v = v - u

  result = u shl shift

proc lcm(u, v): int =
  ## quick and dirty LCM
  # only local
  result = abs(u*v) div gcd(u,v)

proc toRational*(r: float, bound: int = 10000): Rational =
  ## Convert a given float to a rational number with at most `bound` iterations
  if (r == 0.0):
    result.numer = 0
    result.denom = 1
  elif (r < 0.0):
    result = toRational(-r, bound)
    result.numer = -result.numer
  else:
    var
      best = 1
      bestError = Inf
      err: float
    for i in 1..(bound+1):
      err = abs(float(i)*r - float(round(float(i)*r)))
      if (err < bestError):
        best = i
        bestError = err
    result = (int(round(float(best)*r)), best)

proc toRational*(i: int): Rational =
  ## Convert an integer to rational by putting it over 1.
  result = (i, 1)

proc toFloat*(f: Rational): float =
  ## Convert some rational to a float
  if (f.denom == 0):
    raise (DivByZeroError, "Denominator should be greater than 0")
  result = f.numer / f.denom

proc simple*(f: Rational): Rational =
  ## Simplify a fraction by dividing the numerator and denominator
  ## by the greatest common divisor.
  let gd = gcd(f.numer, f.denom)
  if (f.denom == 0):
    raise newException(DivByZeroError, "Can't divide by zero")
  result.numer = f.numer div gd
  result.denom = f.denom div gd
  if (result == (0,0)):
    result = (1,1)

proc simplify*(f: var Rational) =
  ## Simplify a rational using simple()
  f = simple(f)

proc `*`*(f, g: Rational): Rational =
  ## Multiply two fractions and simplify the result
  result.numer = f.numer * g.numer
  result.denom = f.denom * g.denom
  result.simplify

proc `*=`*(f: var Rational, g: Rational) =
  f = f * g

proc `inverse`*(f: Rational): Rational =
  ## Get the reciprocal of some rational
  result = (f.denom, f.numer)

proc `invert`*(f: var Rational) =
  ## Invert some rational
  f = f.inverse

proc `/`*(f, g: Rational): Rational =
  ## Divide by some fraction
  result = f * inverse(g)

proc `/=`*(f: var Rational, g: Rational) =
  f = f / g

proc `-`*(f: Rational): Rational =
  ## Unary minus. Negate a fraction.
  result.numer = -(f.numer)
  result.denom = (f.denom)

proc `+`*(f, g: Rational): Rational =
  ## Add two fractions
  # Adding is probably the most involved operation here
  # If you do it by hand, you make sure the denominators are
  # equivalent by finding the least common multiple, 
  # then you add the resultant numerators
  let commonDenom = lcm(f.denom, g.denom)
  var
    firstMultiplicand = commonDenom div f.denom
    secondMultiplicand = commonDenom div g.denom
    f1: Rational = (f.numer * firstMultiplicand, f.denom * firstMultiplicand)
    g1: Rational = (g.numer * secondMultiplicand, g.denom * secondMultiplicand)
  result.numer = f1.numer + g1.numer
  result.denom = f1.denom # denominator doesn't add!
  result.simplify

proc `+=`*(f: var Rational, g: Rational) =
  f = f + g

proc `+`*(f: Rational, g: int): Rational =
  ## Add some rational and integer, returning a rational
  let gFrac = g.toRational
  result = f + gFrac

proc `+`*(f: int, g: Rational): Rational =
  ## Addition is commutative :)
  result = g + f

proc `+=`*(f: var Rational, g: int) =
  f = f + g

proc `-`*(f, g: Rational): Rational =
  ## Subtract some rational from another
  result = f + (-g)

proc `-=`*(f: var Rational, g: Rational) =
  f = f - g

proc `-`*(f: Rational, g: int): Rational =
  ## Subtract some integer from a rational, returning a rational
  let gFrac = g.toRational
  result = f - gFrac

proc `-=`*(f: var Rational, g: int) =
  let gFrac = g.toRational
  f = f - gFrac

proc `-`*(f: int, g: Rational): Rational =
  ## Subtract some rational from an integer, returning a rational
  result = f.toRational - g

proc `$`*(f: Rational): string =
  ## Represent a fraction as "n / d"
  result = $f.numer & " / " & $f.denom

proc `isDyadic`*(f: Rational): bool =
  ## Simple check to see if we have a dyadic fraction
  result = (f.denom).isPowerOfTwo

proc `isUnit`*(f: Rational): bool =
  ## Simple check to see if we have a unit fraction
  result = (f.numer == 1)
