#include "circle.hpp"

namespace geometry {

double calculateCircleArea(const double radius) {
  constexpr double pi = 3.141592653589793;
  return pi * radius * radius;
}

} // namespace geometry
