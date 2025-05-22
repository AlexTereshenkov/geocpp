#include <ctime>
#include <string>

namespace dates {

const char *current_date() {
  static char buffer[11];
  std::time_t now = std::time(nullptr);
  std::tm *tm_info = std::localtime(&now);
  std::strftime(buffer, sizeof(buffer), "%Y-%m-%d", tm_info);
  return buffer;
}

} // namespace dates
