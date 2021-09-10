help:
  @just --list


# Build base images
build-base:
  docker build -t eu.gcr.io/devz-325114/graalvm-base:latest ./graalvm-base
  docker build -t eu.gcr.io/devz-325114/graalvm-clojure:latest ./graalvm-clojure


# Build image
build:
  docker build -t eu.gcr.io/devz-325114/graalvm-test:latest .
  docker image ls | grep graalvm-test


# Push images:
push:
  docker push eu.gcr.io/devz-325114/graalvm-base:latest
  docker push eu.gcr.io/devz-325114/graalvm-clojure:latest
  docker push eu.gcr.io/devz-325114/graalvm-test:latest


# Run server container:
run:
  @echo $(TZ=UTC date +"%Y-%m-%dT%T.%N") ": starting server"
  @docker run --rm -p 127.0.0.1:8080:8080 eu.gcr.io/devz-325114/graalvm-test:latest


# Start unison
unison:
  ssh dev mkdir -p ./hello-graal
  unison -watch                          \
         -repeat watch                   \
         -auto                           \
         -batch                          \
         -ignore "Path .idea"            \
         -ignore "Path hello-graal.iml"  \
         -ignore "Path .git"             \
         -ignore "Path .nrepl-port"      \
         -ignore "Path .cpcache"         \
         . ssh://dev/hello-graal

# Release:
release:
  docker tag eu.gcr.io/devz-325114/graalvm-test:latest jarppe/hello-graal:latest
  docker push jarppe/hello-graal:latest


# Open shell:
sh:
  @ssh -t dev 'cd hello-graal; exec $SHELL'
