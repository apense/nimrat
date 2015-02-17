import unittest, math, nimrat

suite "rational numbers":
  test "Conversions":
    check (toRational(0.750000000, 1000000) == (3, 4))
    check (toRational(0.518518) == (14, 27))
    check (toRational(0.9054054) == (67, 74))
    check (toRational(Pi) == (355, 113))
    check (toRational(8) == (8,1))
    check (toFloat((3,4)) == 0.75)
  test "reduce":
    let toSimplify = (42,22)
    let toSimplify2 = (55,33)
    let toSimplify3 = (7,6)
    let toSimplify4 = (-4,2)
    check reduced(toSimplify) == (21,11)
    check reduced(toSimplify2) == (5,3)
    check reduced(toSimplify3) == (7,6)
    check reduced(toSimplify4) == (-2,1)
    var toSimplify5 = (6,8)
    toSimplify5.reduce
    check toSimplify5 == (3,4)