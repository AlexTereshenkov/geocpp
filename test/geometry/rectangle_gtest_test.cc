#include "src/geometry/include/rectangle.hpp"
#include "gtest/gtest.h"

TEST(RectangleTest, GetRectangleArea) {
  EXPECT_EQ(geometry::calculateRectangleArea(4, 3), 12);
}

TEST(RectangleTest, GetRectangleAreaIfIsASquare) {
  EXPECT_EQ(geometry::calculateRectangleArea(5, 5), 25);
}
