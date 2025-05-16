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
