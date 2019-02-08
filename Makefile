
.PHONY: all
all: runtime

.PHONY: clean
clean:
	docker rmi -f smizy/bazel:${TAG} || :

.PHONY: runtime
runtime:
	docker build \
		--build-arg BUILD_DATE=${BUILD_DATE} \
		--build-arg VCS_REF=${VCS_REF} \
		--build-arg VERSION=${VERSION} \
		--build-arg EXTRA_BAZEL_ARGS="${EXTRA_BAZEL_ARGS}" \
		--rm -t smizy/bazel:${TAG} .
	docker images | grep bazel

.PHONY: test
test:
	bats test/test_*.bats