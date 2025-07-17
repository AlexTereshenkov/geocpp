build:
	find . -regex '.*\.\(cc\|hpp\)' -exec clang-format --verbose -i {} +
	bazel mod tidy
	bazel test //...
	bazel run //:buildifier
	bazel run //:gazelle
	bazel run //src/apps:release.app -- 3 4
	bazel run //src/apps:math -- 1
	bazel run //src/apps:genheader

oclint:
	bazel clean
	bazel build //generated:header-generated-genrule
	bazel run @hedron_compile_commands//:refresh_all
	bazel build --config=oclint //src/...
	find bazel-bin/src/**/oclint-analysis/** -name 'analyzed*.txt' -exec cat {} +
	find bazel-bin/src/**/oclint-analysis/** -name 'metadata.json' -exec cat {} +
