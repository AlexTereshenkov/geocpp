#include "src/geometry/circle.hpp"
#include "gtest/gtest.h"
#include <cmath>

TEST(CircleTest, GetCircleArea) {
  EXPECT_EQ(std::round(geometry::calculateCircleArea(4) * 100.0) / 100.0,
            50.27);
}

TEST(CircleTest, GetCircleAreaIfEmpty) {
  EXPECT_EQ(geometry::calculateCircleArea(0), 0);
}
