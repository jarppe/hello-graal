# Simple Clojure HTTP server in 36.6MB docker image with GraalVM

This repo is mainly just a documentation for my self on how to 
use [GraalVM](https://www.graalvm.org) to package a 
[Clojure](https://clojure.org/) app as 
[native image](https://www.graalvm.org/reference-manual/native-image/).


## Setup

For simplicity all work is done in [Docker](https://docker.com/) containers.

The image size is 36.6MB and it starts in about 300ms:

```bash
$ docker pull jarppe/hello-graal:latest
$ echo $(date +%Y-%m-%dT%T.%N) ": starting server" ; docker run --rm jarppe/hello-graal:latest
2021-09-10T09:10:34.074616357 : starting server
2021-09-10T09:10:34.390173 : server starting...
2021-09-10T09:10:34.391045 : server ready
```

The native image itself is 18MB and starts in about 3ms. 

```bash
$ echo $(date +%Y-%m-%dT%T.%N) ": starting server" ; ./app 
2021-09-10T09:59:01.252101422 : starting server
2021-09-10T09:59:01.255403 : server starting...
2021-09-10T09:59:01.255925 : server ready
``` 

The above was tested in [GCP](https://cloud.google.com/) 
[c2-standard-4](https://cloud.google.com/compute/docs/compute-optimized-machines#c2_vms) instance
with 4 Intel Cascade Lake CPU and 16GB RAM.


## Build

```bash
just build-base
just build
```


## Run

```bash
just run
```


# License

Copyright © 2019-2021 Jarppe Länsiö
Available under the terms of the Eclipse Public License 2.0
