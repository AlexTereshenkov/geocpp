load("@rules_cc//cc/common:cc_info.bzl", "CcInfo")

def _analyze_aspect_impl(target, ctx):
    outputs = []

    # "hdrs" are not of interest as OCLint analyze the .cpp files that include those headers
    if hasattr(ctx.rule.attr, "srcs"):
        for src in ctx.rule.attr.srcs:
            for file in src.files.to_list():
                output_file = ctx.actions.declare_file("oclint-analysis/analyzed_%s.txt" % file.basename)
                ctx.actions.run(
                    executable = ctx.executable._analyzer,
                    # arguments passed to a Shell script (input file to analyze and where to write report)
                    arguments = [file.path, output_file.path],
                    inputs = [file],
                    outputs = [output_file],
                    progress_message = "Oclint: analyzing %s" % file.path,
                    mnemonic = "OclintAnalyzeSourceFile",
                )
                outputs.append(output_file)

    # materialize file by requesting "--output_groups=metadata" when enabling aspect on the command line
    metadata_file = ctx.actions.declare_file("oclint-analysis/metadata.json")
    ctx.actions.run(
        executable = ctx.executable._analyzer_metadata,
        arguments = [metadata_file.path],
        inputs = [],
        outputs = [metadata_file],
        progress_message = "Oclint: getting metadata",
        mnemonic = "OclintMetadata",
    )

    # this "paths" will be requested in "--output_groups=paths" when enabling aspect on the command line
    # https://bazel.build/reference/command-line-reference#build-flag--output_groups
    # https://bazel.build/extending/rules#requesting_output_files
    return [OutputGroupInfo(
        paths = depset(outputs),
        metadata = depset([metadata_file]),
    )]

analyze_aspect = aspect(
    implementation = _analyze_aspect_impl,
    attr_aspects = ["deps"],
    required_providers = [CcInfo],
    attrs = {
        "_analyzer": attr.label(
            default = Label("//tools:oclint"),
            allow_files = True,
            executable = True,
            cfg = "exec",
        ),
        "_analyzer_metadata": attr.label(
            default = Label("//tools:oclint_metadata"),
            allow_files = True,
            executable = True,
            cfg = "exec",
        ),
    },
)
