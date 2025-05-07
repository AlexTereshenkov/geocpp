build:
	find . -regex '.*\.\(cc\|hpp\)' -exec clang-format -i {} +
	bazel mod tidy
	bazel run //:buildifier
	bazel run //:gazelle
	bazel run //src/apps:main -- 3 4

