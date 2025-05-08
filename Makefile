build:
	find . -regex '.*\.\(cc\|hpp\)' -exec clang-format -i {} +
	bazel mod tidy
	bazel test //...
	bazel run //:buildifier
	bazel run //:gazelle
	bazel run //src/apps:main -- 3 4
	bazel run //src/apps:math -- 1
