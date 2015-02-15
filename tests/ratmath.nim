import unittest, rationals

suite "rational numbers":
  test "math operations":
    let threeSevenths = (3,7)
    let eightThirds = (8,3)
    check (threeSevenths * eightThirds == (8,7))
    check ((3,4) + (7,2) == (17,4))
    check ((4,4) + (1,1) == (2,1))