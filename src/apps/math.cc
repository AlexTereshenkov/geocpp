#include <iostream>

// this comes from a third-party library: https://github.com/kthohr/gcem
#include "gcem.hpp"

int main(int argc, char *argv[]) {
  double value = std::stod(argv[1]);
  double result = gcem::cos(value);
  std::cout << "The cos of " << value << " is: " << result << std::endl;
  return 0;
}
