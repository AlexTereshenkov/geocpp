#include "src/geometry/include/rectangle.hpp"
#include <iostream>
#include <stdexcept>
#include <string>

int main(int argc, char *argv[]) {
  double width = std::stod(argv[1]);
  double height = std::stod(argv[2]);

  if (width <= 0 || height <= 0) {
    std::cerr << "Error: width and height must be positive numbers"
              << std::endl;
    return 1;
  }
  double square = geometry::calculateRectangleArea(width, height);
  std::cout << "The area of the rectangle of size " << width << "x" << height
            << " is: " << square << std::endl;
  return 0;
}
