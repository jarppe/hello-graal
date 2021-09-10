#
# Base image with GraalVM with native-image, LLVM toolchain and NodeJS support.
#


FROM debian:bullseye-slim


#
# Install base tools:
#


RUN apt update                            && \
    apt upgrade -qy                       && \
    apt install -qy curl                  \
                    build-essential       \
                    libz-dev              \
                    zlib1g-dev            \
                    musl                  \
                    musl-dev              \
                    musl-tools


#
# Install GraalVM:
#


# See available releases at https://github.com/graalvm/graalvm-ce-builds/releases
ARG GRAAL_VERSION=21.2.0
# Available Java versions are 8, 11 and experimental 16 (as of 2021-09-09)
ARG JAVA_VERSION=11

ARG GRAAL_DOWNLOAD_URL=https://github.com/graalvm/graalvm-ce-builds/releases/download
ARG GRAAL_TAR_URL=${GRAAL_DOWNLOAD_URL}/vm-${GRAAL_VERSION}/graalvm-ce-java${JAVA_VERSION}-linux-amd64-${GRAAL_VERSION}.tar.gz
ENV GRAAL_HOME=/usr/local/graalvm

RUN mkdir ${GRAAL_HOME}                   && \
    curl -fsL ${GRAAL_TAR_URL}            \
      | tar --strip-components=1          \
            -C ${GRAAL_HOME}              \
            -xzf -

ENV JAVA_HOME=${GRAAL_HOME}
ENV PATH=${JAVA_HOME}/bin:$PATH
ENV LLVM_TOOLCHAIN=${GRAAL_HOME}/languages/llvm/native/bin


#
# Install GraalVM utilities:
#


RUN gu install native-image              && \
    gu install llvm-toolchain            && \
    gu install nodejs
