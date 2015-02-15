import unittest, math, rationals

suite "rational numbers":
  test "Conversions":
    check ($toRational(0.750000000, 1000000) == "3 / 4")
    check ($toRational(0.518518) == "14 / 27")
    check ($toRational(0.9054054) == "67 / 74")
    check ($toRational(Pi) == "355 / 113")
    check (toRational(8) == (8,1))
    check (toFloat((3,4)) == 0.75)
  test "simplify":
    var toSimplify = (42,22)
    var toSimplify2 = (55,33)
    var toSimplify3 = (7,6)
    check simplify(toSimplify) == (21,11)
    check simplify(toSimplify2) == (5,3)
    check simplify(toSimplify3) == (7,6)