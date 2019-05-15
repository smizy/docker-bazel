@test "bazel is the correct version" {
  run docker run smizy/bazel:${TAG} bazel version
  echo "${output}" 

  [ $status -eq 0 ]

  n=$(( ${#lines[*]} -1 ))
  for i in $(seq 0 $n); do
    echo "$i:******** ${lines[$i]}"
  done

  for i in $(seq 0 $n); do
    if [ "${lines[$i]:0:12}" = "Build label:" ]; then
      ver="$(IFS=' '; set -- ${lines[$i]}; echo $3)"
      [ "$ver" = "${VERSION}-" ]
      break
    fi
  done
}