def _my_repo_impl(ctx):
    # This will search PATH for "my_tool.sh"
    # Run with `bazel build //:use_repo_genrule
    # --repo_env=PATH=%bazel_workspace%/tools:$PATH`
    result = ctx.execute(["my_tool.sh"])
    if result.return_code != 0:
        fail("Tool failed: " + result.stderr)

    ctx.file("BUILD.bazel", 'exports_files(["output.txt"])')
    ctx.file("output.txt", result.stdout)

my_repo = repository_rule(
    implementation = _my_repo_impl,
    local = False,
)