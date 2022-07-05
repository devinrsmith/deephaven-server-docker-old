group "default" {
    targets = [
        "groovy",
        "python"
    ]
}

group "release" {
    targets = [
        "groovy-release",
        "python-release"
    ]
}

variable "REPO_PREFIX" {
    default = "ghcr.io/devinrsmith/"
}

variable "CACHE_PREFIX" {
    default = "deephaven-ubuntu-server-"
}

variable "TAG" {
    default = "latest"
}

variable "DEEPHAVEN_VERSION" {
    default = "0.14.0"
}

target "defaults" {
    args = {
        "DEEPHAVEN_VERSION" = "${DEEPHAVEN_VERSION}"
    }
}

target "groovy" {
    inherits = [ "defaults" ]
    context = "ubuntu/"
    tags = [
        "${REPO_PREFIX}deephaven-ubuntu-server-groovy:${TAG}",
        "${REPO_PREFIX}deephaven-ubuntu-server-groovy:${DEEPHAVEN_VERSION}"
    ]
    target = "groovy"
}

target "python" {
    inherits = [ "defaults" ]
    context = "ubuntu/"
    tags = [
        "${REPO_PREFIX}deephaven-ubuntu-server-python:${TAG}",
        "${REPO_PREFIX}deephaven-ubuntu-server-python:${DEEPHAVEN_VERSION}"
    ]
    target = "python"
}

target "groovy-release" {
    inherits = [ "groovy" ]
    cache-from = [ "type=gha,scope=${CACHE_PREFIX}groovy" ]
    cache-to = [ "type=gha,mode=max,scope=${CACHE_PREFIX}groovy" ]
    platforms = [ "linux/amd64", "linux/arm64" ]
}

target "python-release" {
    inherits = [ "python" ]
    cache-from = [ "type=gha,scope=${CACHE_PREFIX}python" ]
    cache-to = [ "type=gha,mode=max,scope=${CACHE_PREFIX}python" ]
    platforms = [ "linux/amd64", "linux/arm64" ]
}
