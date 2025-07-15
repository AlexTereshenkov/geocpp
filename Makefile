build:
	find . -regex '.*\.\(cc\|hpp\)' -exec clang-format --verbose -i {} +
	bazel mod tidy
	bazel test //...
	bazel run //:buildifier
	bazel run //:gazelle
	bazel run //src/apps:release.app -- 3 4
	bazel run //src/apps:math -- 1
	bazel run //src/apps:genheader

sa:
	bazel clean
	bazel build --config=sa //src/...
	find bazel-bin/src/**/private/** -name 'analyzed*.txt' -exec cat {} + | sort | uniq
