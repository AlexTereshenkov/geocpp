import unittest
from cartesian import Point
import math


class TestBasic(unittest.TestCase):

    def test_cartesian_points(self):
        self.assertEqual(Point(10, 20), Point(10, 20))
        self.assertTrue(math.isnan(Point(10, 20).z))

        p1 = Point(10, 20)
        p2 = Point(20, 30)
        self.assertEqual(p1.distanceTo(p2), math.sqrt(200))

        p1 = Point(50, 60, 45)
        p2 = Point(50, 60, 75)
        self.assertEqual(p1.distanceTo(p2, in3D=True), 30.0)


if __name__ == "__main__":
    unittest.main()
