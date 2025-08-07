#include <iostream>

int main() {

#ifdef FRIENDLY
  std::cout << "Lovely to see you!" << std::endl;
#else
  std::cout << "" << std::endl;
#endif

  return 0;
}
