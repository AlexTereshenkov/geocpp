#include "src/geometry/include/rectangle.hpp"
#include <iostream>
#include <stdexcept>
#include <string>
// this comes from a header associated with a pre-compiled shared library
#include "compiled/dates.hpp"

int main(int argc, char *argv[]) {
  std::cout << "Date: " << dates::current_date() << std::endl;

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
