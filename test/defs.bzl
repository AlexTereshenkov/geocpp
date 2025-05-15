load("@rules_cc//cc:cc_test.bzl", "cc_test")

def cc_test_custom(name, srcs, deps, linkstatic):
    for mode in linkstatic:
        cc_test(
            name = name + "-linkstatic-" + str(mode),
            srcs = srcs,
            deps = deps,
            linkstatic = mode,
            tags = ["static" if mode else "dynamic"],
        )
