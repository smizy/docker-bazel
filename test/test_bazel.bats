@test "bazel is the correct version" {
  run docker run smizy/bazel:${TAG} bazel version
  echo "${output}" 

  [ $status -eq 0 ]

  n=$(( ${#lines[*]} -1 ))
  for i in $(seq 0 $n); do
    echo "$i:******** ${lines[$i]}"
  done

  declare -a version=(${lines[2]})
  [ "${version[2]}" = "0.22.0-" ]
}