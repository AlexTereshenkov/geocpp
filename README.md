# geocpp

A computational geometry project written in C++ and built with Bazel.

## Build

### `uber/hermetic_cc_toolchain`

Using https://github.com/uber/hermetic_cc_toolchain.

On host.

```shell
$ bazel test \
    --action_env BAZEL_DO_NOT_DETECT_CPP_TOOLCHAIN=1 \
    --toolchain_resolution_debug=".*" \
    --config=hermetic-linux-amd64 \
    --test_tag_filters="static" \
    //...
```

In a Docker container; note multiple uses of `--config` that are accumulated.

```shell
# debian:stable-slim won't have any c++ compilers, but hermetic toolchain
# should still succeed as it's going to bring everything with itself
bazel test \
    --action_env BAZEL_DO_NOT_DETECT_CPP_TOOLCHAIN=1 \
    --config=hermetic-linux-amd64 \
    --config=docker-debian \
    --test_tag_filters="static" \
    //...

# this will fail because there's no GCC compiler in the Docker image
bazel test \
    --config=docker-debian \
    --test_tag_filters="static" \
    //...
```

## Cross-compile

Using [uber/hermetic_cc_toolchain`](https://github.com/uber/hermetic_cc_toolchain), one can cross-compile a target
such as a binary executable.

Build a `linux-arm64` binary on `linux-amd64` device:

```shell
$ bazel build \                             
    --action_env BAZEL_DO_NOT_DETECT_CPP_TOOLCHAIN=1 \
    --config=hermetic-linux-arm64 \
    //src/apps:math-arm64

$ readelf -h bazel-bin/src/apps/math-arm64 | grep Machine
  Machine:                           AArch64
```

After copying the binary executable to a `linux-arm64` device:

```
$ uname -m
aarch64

$ ldd math-arm64
        linux-vdso.so.1 (0x0000e13e71e20000)
        libpthread.so.0 => /lib/aarch64-linux-gnu/libpthread.so.0 (0x0000e13e71dc0000)
        libc.so.6 => /lib/aarch64-linux-gnu/libc.so.6 (0x0000e13e71c00000)
        libdl.so.2 => /lib/aarch64-linux-gnu/libdl.so.2 (0x0000e13e71bd0000)
        /lib/ld-linux-aarch64.so.1 (0x0000e13e71de3000)
```

Using Docker to emulate the `linux-arm64` target platform with QEMU:

```
$ docker build -t ubuntu-arm64 --platform linux/arm64 -f platforms/emulation/Dockerfile --load .
$ docker run --rm -it -v ./release:/home/release --platform linux/arm64 ubuntu-arm64:latest
# /home/release/math-arm64 1
The cos of 1 is: 0.540302
```
