FROM alpine:3.8

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
ARG EXTRA_BAZEL_ARGS

LABEL \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.docker.dockerfile="/Dockerfile" \
    org.label-schema.license="Apache License 2.0" \
    org.label-schema.name="smizy/bazel" \
    org.label-schema.url="https://gitlab.com/smizy" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-type="Git" \
    org.label-schema.version=$VERSION \
    org.label-schema.vcs-url="https://gitlab.com/smizy/docker-bazel"

ENV BAZEL_VERSION     $VERSION
ENV EXTRA_BAZEL_ARGS  $EXTRA_BAZEL_ARGS

ENV JAVA_HOME  /usr/lib/jvm/default-jvm


RUN set -x \
    && apk update \
    ## bazel
    && apk --no-cache add \
        g++ \
        libstdc++ \
        openjdk8-jre \
    && apk --no-cache add --virtual .builddeps \
        bash \
        build-base \
        linux-headers \
        openjdk8 \
        python3-dev \
        wget \
        zip \
    && mkdir /tmp/bazel \
    && wget -q -O /tmp/bazel-dist.zip https://github.com/bazelbuild/bazel/releases/download/${BAZEL_VERSION}/bazel-${BAZEL_VERSION}-dist.zip \
    && unzip -q -d /tmp/bazel /tmp/bazel-dist.zip \
    && cd /tmp/bazel \
    # add -fpermissive compiler option to avoid compilation failure 
    && sed -i -e '/"-std=c++0x"/{h;s//"-fpermissive"/;x;G}' tools/cpp/cc_configure.bzl \
    # add '#include <sys/stat.h>' to avoid mode_t type error 
    && sed -i -e '/#endif  \/\/ COMPILER_MSVC/{h;s//#else/;G;s//#include <sys\/stat.h>/;G;}' third_party/ijar/common.h \
    && cd /tmp/bazel \
    && ln -s /usr/bin/python3 /usr/bin/python \
    # # add jvm opts for circleci
    # && sed -i -E 's/(jvm_opts.*\[)/\1 "-Xmx1024m",/g' src/java_tools/buildjar/BUILD \
    && bash compile.sh \
    ## install
    && cp output/bazel /usr/local/bin/ \
    ## cleanup 
    && apk del .builddeps \
    && cd / \
    && rm -rf /tmp/bazel*