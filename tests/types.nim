import unittest, nimrat

suite "rational numbers":
  test "rational type checks":
    check ((1,4).isDyadic == true)
    check ((4,3).isDyadic == false)
    check ((1,4).isUnit == true)
    check ((3,4).isUnit == false)