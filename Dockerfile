FROM oracle/graalvm-ce:latest AS build

# Install native-image builder:
RUN gu install native-image


# Install clj-tools:
RUN curl -O https://download.clojure.org/install/linux-install-1.10.1.469.sh && \
    chmod +x linux-install-1.10.1.469.sh && \
    ./linux-install-1.10.1.469.sh

# Install tini:
ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini-static /tini
RUN chmod +x /tini

# Download deps:
# - this is done in separate layer to speed up image build when dependencies have not changed.

WORKDIR /app
COPY deps.edn /app/deps.edn
RUN clojure -Spath > /dev/null

#
# Build:
#

COPY src/ /app/src/

# NOTE: This should not need --initialize-at-build-time and -H:+ReportUnsupportedElementsAtRuntime flags,
#       but for now they are required. See https://github.com/oracle/graal/issues/1266 and
RUN mkdir classes && \
    clojure \
      -J-Dclojure.compiler.direct-linking=true \
      -J-Dclojure.spec.skip-macros=true \
      -e "(compile 'hello-graal.server)" && \
    native-image \
      -J-Dclojure.compiler.direct-linking=true \
      -J-Dclojure.spec.skip-macros=true \
      --initialize-at-build-time \
      --initialize-at-run-time=java.lang.Math\$RandomNumberGeneratorHolder \
      --no-fallback \
      --static \
      --enable-http \
      --no-server \
      -H:+ReportUnsupportedElementsAtRuntime \
      -H:+ReportExceptionStackTraces \
      -cp ./classes:$(clojure -Spath) \
      hello_graal.server


#
# Final image:
#


FROM scratch

COPY --from=build /tini /tini
COPY --from=build /app/hello_graal.server /hello_graal_server

ENTRYPOINT ["/tini", "-g", "-e", "143", "--"]
CMD ["/hello_graal_server"]
