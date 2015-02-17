import unittest, math, nimrat

suite "rational numbers":
  test "Output":
    let myFrac = (3,4)
    check ($myFrac == "3 / 4")
    check ($reduced((8,6)) == "4 / 3")