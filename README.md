# Simple Clojure HTTP server in 9MB docker image with GraalVM

This branch uses immutant. Unfortunately the native-image creation fails on out-of-memory error.

Demonstration on how to package a simple Clojure HTTP server to 9MB Docker image
that starts pretty fast.

The native image itself starts in 2ms. 

```bash
echo $(TZ=UTC date +%Y-%m-%dT%T.%N) ": starting server" ; /hello_graal_server 
2019-09-28T09:30:16.381392000 : starting server
2019-09-28T09:30:16.382 : server starting...
2019-09-28T09:30:16.383 : server ready
``` 

On Mac with Docker Desktop:

```bash
$ echo $(TZ=UTC gdate +%Y-%m-%dT%T.%N) ": starting server" ; docker run --rm -p 8080:8080 hello-graal
2019-09-28T09:21:31.092295000 : starting server
docker run --rm -i -p 8080:8080 hello-graal
2019-09-28T09:21:31.881 : server starting...
2019-09-28T09:21:31.881 : server ready
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
