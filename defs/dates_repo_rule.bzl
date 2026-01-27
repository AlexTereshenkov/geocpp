def _dates_repo_rule_impl(ctx):
    # This will search PATH for "get-date.sh"; run with
    # `bazel build //:save-the-date-genrule --repo_env=PATH=%bazel_workspace%/tools:$PATH`
    result = ctx.execute(["get-date.sh"])
    if result.return_code != 0:
        fail("Tool failed: " + result.stderr)

    ctx.file("BUILD.bazel", 'exports_files(["now.json"])')
    ctx.file("now.json", result.stdout)

dates_repo_rule = repository_rule(
    implementation = _dates_repo_rule_impl,
    local = False,
)
