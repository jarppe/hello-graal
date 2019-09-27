help:
  @just --list


# Build image
build:
  docker build -t hello-graal .


# Run server container
run:
  docker run --rm -p 7000:8080 hello-graal
