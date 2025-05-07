// implementation is stored in sandbox/dates.cpp file;
// to compile into an .so file, run:
// $ g++ -fPIC -shared -s -Wl,--strip-all -o compiled/dates.so sandbox/dates.cc
// $ strip --strip-all compiled/dates.so

#ifndef DATES_HPP
#define DATES_HPP

namespace dates {
const char *current_date();
}

#endif // DATES_HPP
