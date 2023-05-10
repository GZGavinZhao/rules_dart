"""This module implements the language-specific toolchain rule.
"""

dartInfo = provider(
    doc = "Information about how to invoke the tool executable.",
    fields = {
        "target_tool_path": "Path to the tool executable for the target platform.",
        "tool_files": """Files required in runfiles to make the tool executable available.

May be empty if the target_tool_path points to a locally installed tool binary.""",
    },
)

# Avoid using non-normalized paths (workspace/../other_workspace/path)
def _to_manifest_path(ctx, file):
    if file.short_path.startswith("../"):
        return "external/" + file.short_path[3:]
    else:
        return ctx.workspace_name + "/" + file.short_path

def _dart_toolchain_impl(ctx):
    tool_files = ctx.attr.target_tool.files.to_list()
    target_tool_path = _to_manifest_path(ctx, tool_files[0])

    # Make the $(tool_EXE) variable available in places like genrules.
    # See https://docs.bazel.build/versions/main/be/make-variables.html#custom_variables
    template_variables = platform_common.TemplateVariableInfo({
        "dart_EXE": target_tool_path,
    })
    default = DefaultInfo(
        files = depset(tool_files),
        runfiles = ctx.runfiles(files = tool_files),
    )
    dartinfo = dartInfo(
        target_tool_path = target_tool_path,
        tool_files = tool_files,
    )

    # Export all the providers inside our ToolchainInfo
    # so the resolved_toolchain rule can grab and re-export them.
    toolchain_info = platform_common.ToolchainInfo(
        dartinfo = dartinfo,
        template_variables = template_variables,
        default = default,
    )
    return [
        default,
        toolchain_info,
        template_variables,
    ]

dart_toolchain = rule(
    implementation = _dart_toolchain_impl,
    attrs = {
        "dart_exe": attr.label(
            doc = "The `dart` command-line executable.",
            mandatory = True,
            executable = True,
            allow_single_file = True,
        ),
        "dartaotruntime": attr.label(
            doc = "Runtime for Dart AOT snapshots.",
            mandatory = False,
            executable = True,
            allow_single_file = True,
        ),
    },
    doc = """Defines a dart compiler/runtime toolchain.

For usage see https://docs.bazel.build/versions/main/toolchains.html#defining-toolchains.
""",
)
