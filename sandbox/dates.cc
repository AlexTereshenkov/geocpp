#include <ctime>
#include <string>

namespace dates {

const char *current_date() {
  static std::string date;
  std::time_t now = std::time(nullptr);
  std::tm *tm_info = std::localtime(&now);

  char buffer[11]; // "YYYY-MM-DD" + null terminator
  std::strftime(buffer, sizeof(buffer), "%Y-%m-%d", tm_info);

  date = buffer;
  return date.c_str();
}

} // namespace dates
