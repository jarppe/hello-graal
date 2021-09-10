FROM eu.gcr.io/devz-325114/graalvm-clojure:latest AS base


#
# Install tini:
#


ARG TINI_VERSION=v0.19.0
ARG TINI_DOWNLOAD_URL=https://github.com/krallin/tini/releases/download

RUN curl -sfL ${TINI_DOWNLOAD_URL}/${TINI_VERSION}/tini-static -o /tini    && \
    chmod +x /tini


#
# Download deps:
# - this is done in separate layer to speed up image build when dependencies have not changed.
#


WORKDIR /app
COPY deps.edn /app/deps.edn
RUN clojure -A:uberjar -Spath


#
# Build:
#


COPY src/ /app/src/

# Compile clojure to JVM bytecode
RUN clojure -X:uberjar :jar app.jar

# NOTE: This should not need --initialize-at-build-time and -H:+ReportUnsupportedElementsAtRuntime flags,
#       but for now they are required. See https://github.com/oracle/graal/issues/1266 and
RUN native-image                                      \
      -cp app.jar                                     \
      -jar app.jar                                    \
      -H:Name=app                                     \
      -H:+ReportExceptionStackTraces                  \
      -J-Dclojure.spec.skip.macros=true               \
      -J-Dclojure.compiler.direct-linking=true        \
      -J-Xmx12G                                       \
      --initialize-at-build-time=                     \
      --verbose                                       \
      --enable-http                                   \
      --no-fallback                                   \
      --no-server                                     \
      -H:+StaticExecutableWithDynamicLibC             \
      -H:CCompilerOption=-pipe                        \
      --report-unsupported-elements-at-runtime        \
      --native-image-info                             \
      --allow-incomplete-classpath                    \
      --enable-url-protocols=http                     \
      --enable-all-security-services                  \
      --install-exit-handlers                         && \
    echo "Build native image"                         && \
    ls -Flh ./app


#
# Final image:
#


# FROM debian:bullseye-slim
# FROM gcr.io/distroless/static-debian10 AS dist
# FROM gcr.io/distroless/base-debian10 AS dist
FROM gcr.io/distroless/base:latest AS dist

COPY --from=base /tini     /tini
COPY --from=base /app/app  /app

ENTRYPOINT ["/tini", "-g", "-e", "143", "--"]
CMD ["/app"]
