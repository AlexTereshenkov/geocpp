def _static_analysis_impl(ctx):
    outputs = []

    for src in ctx.attr.srcs:
        files = src[DefaultInfo].files.to_list()
        for file in files:
            print(file)

            # File properties
            # ["basename", "dirname", "extension", "is_directory", "is_source", "is_symlink",
            # "owner", "path", "root", "short_path", "tree_relative_path"]
            out = ctx.actions.declare_file(ctx.label.name + "_" + file.basename + ".analysis.txt")
            ctx.actions.run(
                inputs = [file],
                outputs = [out],
                executable = ctx.executable.analyzer,
                arguments = [file.path, out.path],
                mnemonic = "StaticAnalysis",
                progress_message = "Analyzing {}".format(file.basename),
            )
            outputs.append(out)

    return DefaultInfo(files = depset(outputs))

static_analysis = rule(
    implementation = _static_analysis_impl,
    attrs = {
        "srcs": attr.label_list(allow_files = True),
        "analyzer": attr.label(
            executable = True,
            cfg = "exec",
            allow_files = True,
            doc = "The analysis binary to run. It must accept input and output paths as arguments.",
        ),
    },
)
