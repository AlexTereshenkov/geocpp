def _analyze_aspect_impl(target, ctx):
    outputs = []

    if hasattr(ctx.rule.attr, "srcs"):
        for src in ctx.rule.attr.srcs:
            for f in src.files.to_list():
                output_file = ctx.actions.declare_file("private/analyzed_%s.txt" % f.basename)
                ctx.actions.run(
                    executable = ctx.executable._analyzer,
                    arguments = [f.path, output_file.path],
                    inputs = [f],
                    outputs = [output_file],
                    progress_message = "Analyzing %s" % f.path,
                    mnemonic = "AnalyzeSourceFile",
                )
                outputs.append(output_file)

    return [OutputGroupInfo(paths = depset(outputs))]

analyze_aspect = aspect(
    implementation = _analyze_aspect_impl,
    attr_aspects = ["deps"],
    required_providers = [CcInfo],
    attrs = {
        "_analyzer": attr.label(
            default = Label("//tools:analyzer"),
            allow_files = True,
            executable = True,
            cfg = "exec",
        ),
    },
)
