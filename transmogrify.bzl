load("@bazel_skylib//rules:native_binary.bzl", "native_test")

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

def _transmogrify_impl(name, visibility, src):
    pass

transmogrify = macro(
    implementation = _transmogrify_impl,
    attrs = {
        "src": attr.label(
            allow_single_file = True,
            configurable = False,
        ),
    },
)
