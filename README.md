# geocpp

A computational geometry project written in C++ and built with Bazel.

## Build

Using https://github.com/uber/hermetic_cc_toolchain:

```
$ bazel test \
    --action_env BAZEL_DO_NOT_DETECT_CPP_TOOLCHAIN=1 \
    --toolchain_resolution_debug=".*" \
    --config=hermetic-linux-amd64 \
    --test_tag_filters="static" \
    //...
```
