# deephaven-server-docker

This repository produces [Deephaven](https://deephaven.io/) server images with the [deephaven-core releases](https://github.com/deephaven/deephaven-core/releases).

## Images

The following images are currently being produced:

* `ghcr.io/devinrsmith/deephaven-server:0.14.0-11`
* `ghcr.io/devinrsmith/deephaven-server:0.14.0-17`
* `ghcr.io/devinrsmith/deephaven-server:0.14.0-18`
* `ghcr.io/devinrsmith/deephaven-server:0.14.0-11-38`
* `ghcr.io/devinrsmith/deephaven-server:0.14.0-11-39`
* `ghcr.io/devinrsmith/deephaven-server:0.14.0-11-310`
* `ghcr.io/devinrsmith/deephaven-server:0.14.0-17-38`
* `ghcr.io/devinrsmith/deephaven-server:0.14.0-17-39`
* `ghcr.io/devinrsmith/deephaven-server:0.14.0-17-310`
* `ghcr.io/devinrsmith/deephaven-server:0.14.0-18-38`
* `ghcr.io/devinrsmith/deephaven-server:0.14.0-18-39`
* `ghcr.io/devinrsmith/deephaven-server:0.14.0-18-310`

The tag format is `<Deephaven version>-<JDK version>(-<Python version>)`.

### Linux

Images are produced for the platforms `linux/amd64` and `linux/arm64`. The images are based off of the [ubuntu](https://hub.docker.com/_/ubuntu) Docker image. Depending on the software stack, either `ubuntu:20.04` or `ubuntu:22.04` is used.

### Mac

Both the Intel and M1 architectures are supported with the Linux images.

### Windows

The Linux images can be used with the [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/). Windows native images are not currently being produced, but may be produced in the future.

## Build

### CI

The images are automatically built and deployed by GitHub Actions CI, see [build-ci.yml](.github/workflows/build-ci.yml).

### Local

For a default, local-only build on your system's platform, run:

```
# Build all of the default images:
docker buildx bake

# Build a specific target image:
docker buildx bake python-11-310
```

See [docker-bake.hcl](docker-bake.hcl) for parameterization options.
