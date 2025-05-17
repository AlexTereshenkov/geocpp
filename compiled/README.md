`dates.so` file was created on a `linux-amd64` device and cannot be linked when cross-compiling an `linux-arm64` binary:

```
...
ERROR: /home/user/code/geocpp/src/apps/BUILD.bazel:3:10: Linking src/apps/main failed: (Exit 1): c++ failed: error executing CppLink command (from target //src/apps:main) 
ld.lld: error: bazel-out/k8-fastbuild/bin/_solib_k8/_U_S_Scompiled_Cdates___Ucompiled/dates.so is incompatible with aarch64linux

# on x86_64 device
$ readelf -h compiled/dates.so | grep Machine
  Machine:                           Advanced Micro Devices X86-64
```
