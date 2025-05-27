/*
Implementation is stored in sandbox/dates.cpp file.

To compile into an .so file (shared library), run:
$ g++ -fPIC -shared -s -Wl,--strip-all -o compiled/dates.so sandbox/dates.cc
$ strip --strip-all compiled/dates.so

To compile into an .a file (static library), run:
$ g++ -c -o compiled/dates.o sandbox/dates.cc
$ ar rcs compiled/libdates.a compiled/dates.o
$ strip --strip-debug compiled/libdates.a
$ rm compiled/dates.o

Keep in mind that it's necessary to use the same compiler
Bazel uses (the host or the toolchain) and the same flags.
*/

#ifndef DATES_HPP
#define DATES_HPP

namespace dates {
const char *current_date();
}

#endif // DATES_HPP
