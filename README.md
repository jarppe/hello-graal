# Simple Clojure HTTP server in 8.63MB docker image with GraalVM

Demonstration on how to package a simple Clojure HTTP server to 8.63MB Docker image
that starts pretty much instantly.

```bash
$ time docker run --rm -d -p 8080:8080 hello-graal
0.04s user 0.02s system 8% cpu 0.697 total
```

## Build

```bash
docker build -t hello-graal .
```

## Run

```bash
docker run --rm -p 8080:8080 hello-graal
```

## Test

```bash
curl http://localhost:8080/
```

# License

Copyright © 2019 Jarppe Länsiö
