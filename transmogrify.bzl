load("@bazel_skylib//rules:native_binary.bzl", "native_test")

# - [x] Attribute to point to the transmog binary
# - src attribute is the input file
# - output should be be created by our rule

# TODO:
#  - Create a new rule uses the `//:transmogrify` binary to create a new file, given an input.
#  - Update the macro below to call this rule and then also create a test that runs `//:check_transmogrified`
#    on the new file to check that it has been transmogrified correctly.

# Optionally:
#  - `//:transmogrify` can take an optional `--aux` argument. Update the macro and rule to support this.

# How to run the tools:
#
# Transmogrify:
#    bazel run //:transmogrify -- $(pwd)/hello.txt --output $(pwd)/output.txt
#
# Check Transmogrified:
#    bazel run //:check_transmogrified -- $(pwd)/output.txt --expected "hello.txt"



def _transmog_rule_impl(ctx):
    output_file = ctx.actions.declare_file(ctx.attr.output_file_name)
    args = ctx.actions.args()
    args.add(ctx.file.src)
    args.add("--output", output_file)
    ctx.actions.run(
        mnemonic = "Transmog",
        executable = ctx.executable._binary,
        arguments = [args],
        inputs = ctx.files.src,
        outputs = [output_file],
    )
    return [DefaultInfo(files = depset([output_file]))]

transmog_rule = rule(
    implementation =_transmog_rule_impl,
    attrs = {
        "_binary": attr.label(
            default = Label("//:transmogrify"),
            executable = True,
            cfg = "exec",
        ),
        "src": attr.label( # input file
            allow_single_file = True,
        ),
        "output_file_name": attr.string()
    }
)

def _transmogrify_impl(name, visibility, src):
    transmog_rule(
        name = name,
        src = src,
        visibility = visibility,
        output_file_name = name + ".out",
    )

transmogrify = macro(
    implementation = _transmogrify_impl,
    attrs = {
        "src": attr.label(
            allow_single_file = True,
            configurable = False,
        ),
    },
)
