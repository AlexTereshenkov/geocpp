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

Using [uber/hermetic_cc_toolchain](https://github.com/uber/hermetic_cc_toolchain), one can cross-compile a target
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

```shell
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

```shell
$ docker build -t ubuntu-arm64 --platform linux/arm64 -f platforms/emulation/Dockerfile --load .
$ docker run --rm -it -v ./release:/home/release --platform linux/arm64 ubuntu-arm64:latest
# /home/release/math-arm64 1
The cos of 1 is: 0.540302
```

## Cross compile an application with a static library

```shell
# building for x86
bazel build \
    --action_env BAZEL_DO_NOT_DETECT_CPP_TOOLCHAIN=1 \
    --config=hermetic-linux-amd64 \
    --define buildenv=x86 //src/apps:main

# building for arm64
bazel build \
    --action_env BAZEL_DO_NOT_DETECT_CPP_TOOLCHAIN=1 \
    --config=hermetic-linux-arm64 \
    --define buildenv=arm64 //src/apps:main

# fallback to x86 with no explicit configuration passed
bazel build \
    --action_env BAZEL_DO_NOT_DETECT_CPP_TOOLCHAIN=1 \
    --config=hermetic-linux-amd64 \
    //src/apps:main
```

# Use `clangd` for IDE integration

Run this to generate the `compile_commands.json` file in the root of the workspace.

```
bazel run @hedron_compile_commands//:refresh_all
```

This lets the IDE to understand the source code of a Bazel project.

## Run clang tools

Depending on the runtime environment, you might need to install `libinfo5`:

```
wget http://security.ubuntu.com/ubuntu/pool/universe/n/ncurses/libtinfo5_6.3-2ubuntu0.1_amd64.deb
dpkg -i libtinfo5_6.3-2ubuntu0.1_amd64.deb
```

If arguments can be passed to a `native_binary`, then `native_binary` could be used

```
load("@bazel_skylib//rules:native_binary.bzl", "native_binary")
native_binary(
    name = "clang_format",
    src = "@llvm_toolchain//:bin/clang-format",
    out = "clang_format",
)
```

Otherwise, a `genrule` can be used.
