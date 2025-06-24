load("@rules_cc//cc:cc_binary.bzl", "cc_binary")

def release_application(name, srcs, deps):
    cc_binary(
        name = name + ".app",
        srcs = srcs,
        deps = deps,
    )
    native.genrule(
        name = name + ".config",
        srcs = [":" + name + ".app"],
        outs = [name + ".json"],
        # location is a Bazel "make variable" that expands to the file path of a target
        cmd = "$(location //src/apps:release_metadata) $(location {}) > $@".format(name + ".app"),
        tools = ["//src/apps:release_metadata"],
    )

    # this is to be able to refer to a single convenience build target
    # (instead of explicitly doing `bazel build //src/apps:release.app //src/apps:release.config`)
    native.filegroup(
        name = name,
        srcs = [":" + name + ".app", ":" + name + ".config"],
    )
