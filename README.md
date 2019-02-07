# docker-bazel

Bazel docker image based on alpine

```
$ docker build \
    --build-arg="EXTRA_BAZEL_ARGS=--local_resources 3072,1.0,1.0 --host_javabase=@local_jdk//:jdk" \
    --build-arg="VERSION=0.22.0" \
    -t local/bazel .

$ docker run -it --rm local/bazel bazel help
WARNING: --batch mode is deprecated. Please instead explicitly shut down your Bazel server using the command "bazel shutdown".
INFO: Invocation ID: 9be5fe07-335f-4f40-963a-09c8ee65c42f
                                              [bazel release 0.22.0- (@non-git)]
Usage: bazel <command> <options> ...

Available commands:
  analyze-profile     Analyzes build profile data.
  aquery              Analyzes the given targets and queries the action graph.
  build               Builds the specified targets.
  canonicalize-flags  Canonicalizes a list of bazel options.
  clean               Removes output files and optionally stops the server.
  coverage            Generates code coverage report for specified test targets.
  cquery              Loads, analyzes, and queries the specified targets w/ configurations.
  dump                Dumps the internal state of the bazel server process.
  fetch               Fetches external repositories that are prerequisites to the targets.
  help                Prints help for commands, or the index.
  info                Displays runtime info about the bazel server.
  license             Prints the license of this software.
  mobile-install      Installs targets to mobile devices.
  print_action        Prints the command line args for compiling a file.
  query               Executes a dependency graph query.
  run                 Runs the specified target.
  shutdown            Stops the bazel server.
  sync                Syncs all repositories specified in the workspace file
  test                Builds and runs the specified test targets.
  version             Prints version information for bazel.

Getting more help:
  bazel help <command>
                   Prints help and options for <command>.
  bazel help startup_options
                   Options for the JVM hosting bazel.
  bazel help target-syntax
                   Explains the syntax for specifying targets.
  bazel help info-keys
                   Displays a list of keys used by the info command.

```