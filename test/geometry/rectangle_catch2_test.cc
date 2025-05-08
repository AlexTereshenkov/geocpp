#include "catch2/catch_test_macros.hpp"
#include "src/geometry/include/rectangle.hpp"

TEST_CASE("Test rectangle", "[area]") {
  REQUIRE(geometry::calculateRectangleArea(4, 3) == 12);
}

TEST_CASE("Test rectangle", "[area-if-squared]") {
  REQUIRE(geometry::calculateRectangleArea(5, 5) == 25);
}
