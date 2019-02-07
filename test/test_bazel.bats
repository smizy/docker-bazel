@test "bazel is the correct version" {
  run docker run smizy/bazel:${TAG} bazel version
  echo "${output}" 

  [ $status -eq 0 ]

  declare -a version=(${lines[0]})
  [ "${version[2]}" = "0.22.0-" ]
}