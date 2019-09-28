# Simple Clojure HTTP server in 9MB docker image with GraalVM

This branch uses immutant. Unfortunately the native-image creation fails on out-of-memory error.

Demonstration on how to package a simple Clojure HTTP server to 9MB Docker image
that starts pretty fast.

Docker container starts under 700ms:

```bash
$ docker pull jarppe/hello-graal:latest
$ echo $(date +%Y-%m-%dT%T.%N) ": starting server" ; docker run --rm jarppe/hello-graal:latest
2019-09-28T10:12:00.282285800 : starting server
2019-09-28T10:12:00.969 : server starting...
2019-09-28T10:12:00.969 : server ready
```

The native image itself starts in 2ms. 

```bash
$ echo $(date +%Y-%m-%dT%T.%N) ": starting server" ; /hello_graal_server 
2019-09-28T09:30:16.381392000 : starting server
2019-09-28T09:30:16.382 : server starting...
2019-09-28T09:30:16.383 : server ready
``` 

The above was tested 


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

## Bonus, test the native image with more tooling

The image `jarppe/hello-graal:latest` contains just the `tini` and `hello_graal_server`
binaries, nothing else. If you would like to play around with the native image in a
container with more tools, you can create a new image with the `hello_graal_server`.

The `Dockerfile-test` does just that.

```dockerfile
FROM jarppe/hello-graal:latest AS base
FROM debian:10-slim
COPY --from=base /hello_graal_server /hello_graal_server
CMD ["bash"]
```

Build and run it:

```bash
$ docker build -t hello-graal-test -f Dockerfile-test .
$ docker run --rm -it hello-graal-test
root@e0e5a275ea24:/# PS1="$ "
$ ls -l /hello_graal_server
-rwxr-xr-x 1 root root 8146160 Sep 28 10:23 /hello_graal_server
$ echo $(date +%Y-%m-%dT%T.%N) ": starting server" ; /hello_graal_server 
2019-09-28T10:47:18.055150800 : starting server
2019-09-28T10:47:18.057 : server starting...
2019-09-28T10:47:18.057 : server ready
^C
$ 
```


# License

Copyright © 2019 Jarppe Länsiö
