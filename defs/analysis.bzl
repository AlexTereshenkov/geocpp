def _static_analysis_impl(ctx):
    intermediate_outputs = []
    input_files = []

    for src in ctx.attr.srcs:
        files = src[DefaultInfo].files.to_list()
        for file in files:
            input_files.append(file)

            tmp_output = ctx.actions.declare_file(
                "private/" + ctx.label.name + "_" + file.basename + ".tmp_analysis.txt",
            )

            ctx.actions.run(
                inputs = [file],
                outputs = [tmp_output],
                executable = ctx.executable.analyzer,
                arguments = [file.path, tmp_output.path],
                tools = [ctx.executable.analyzer],
                mnemonic = "StaticAnalysisSingle",
                progress_message = "Analyzing {}".format(file.short_path),
            )

            intermediate_outputs.append(tmp_output)

    # Final merged output
    final_output = ctx.actions.declare_file(ctx.label.name + ".results.txt")

    merge_command = "cat {} > {}".format(
        " ".join([f.path for f in intermediate_outputs]),
        final_output.path,
    )

    ctx.actions.run_shell(
        inputs = intermediate_outputs,
        outputs = [final_output],
        command = merge_command,
        mnemonic = "StaticAnalysisMerge",
        progress_message = "Merging analyzer outputs",
        use_default_shell_env = True,
    )

    return DefaultInfo(files = depset([final_output]))

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
