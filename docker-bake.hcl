group "default" {
    targets = [
        "groovy-11",
        "groovy-17",
        "python-11-38",
        "python-11-39",
        "python-11-310",
        "python-17-38",
        "python-17-39",
        "python-17-310"
    ]
}

group "release" {
    targets = [
        "groovy-11-release",
        "groovy-17-release",
        "python-11-38-release",
        "python-11-39-release",
        "python-11-310-release",
        "python-17-38-release",
        "python-17-39-release",
        "python-17-310-release"
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

# Note: when updating DEEPHAVEN_VERSION, we should update requirements.txt.
variable "DEEPHAVEN_VERSION" {
    default = "0.14.0"
}

target "defaults" {
    args = {
        "DEEPHAVEN_VERSION" = "${DEEPHAVEN_VERSION}"
    }
}

target "groovy-11" {
    inherits = [ "defaults" ]
    context = "ubuntu/"
    tags = [
        "${REPO_PREFIX}deephaven-server:${DEEPHAVEN_VERSION}-11"
    ]
    target = "groovy"
    args = {
        "UBUNTU_TAG" = "22.04",
        "OPENJDK_VERSION" = "11"
    }
}

target "groovy-17" {
    inherits = [ "defaults" ]
    context = "ubuntu/"
    tags = [
        "${REPO_PREFIX}deephaven-server:${DEEPHAVEN_VERSION}-17"
    ]
    target = "groovy"
    args = {
        "UBUNTU_TAG" = "22.04",
        "OPENJDK_VERSION" = "17"
    }
}

target "python-11-38" {
    inherits = [ "defaults" ]
    context = "ubuntu/"
    tags = [
        "${REPO_PREFIX}deephaven-server:${DEEPHAVEN_VERSION}-11-38"
    ]
    target = "python"
    args = {
        "UBUNTU_TAG" = "20.04",
        "OPENJDK_VERSION" = "11"
        "PYTHON_VERSION" = "3.8"
    }
}

target "python-11-39" {
    inherits = [ "defaults" ]
    context = "ubuntu/"
    tags = [
        "${REPO_PREFIX}deephaven-server:${DEEPHAVEN_VERSION}-11-39"
    ]
    target = "python"
    args = {
        "UBUNTU_TAG" = "20.04",
        "OPENJDK_VERSION" = "11"
        "PYTHON_VERSION" = "3.9"
    }
}

target "python-11-310" {
    inherits = [ "defaults" ]
    context = "ubuntu/"
    tags = [
        "${REPO_PREFIX}deephaven-server:${DEEPHAVEN_VERSION}-11-310"
    ]
    target = "python"
    args = {
        "UBUNTU_TAG" = "22.04",
        "OPENJDK_VERSION" = "11"
        "PYTHON_VERSION" = "3.10"
    }
}

target "python-17-38" {
    inherits = [ "defaults" ]
    context = "ubuntu/"
    tags = [
        "${REPO_PREFIX}deephaven-server:${DEEPHAVEN_VERSION}-17-38"
    ]
    target = "python"
    args = {
        "UBUNTU_TAG" = "20.04",
        "OPENJDK_VERSION" = "17"
        "PYTHON_VERSION" = "3.8"
    }
}

target "python-17-39" {
    inherits = [ "defaults" ]
    context = "ubuntu/"
    tags = [
        "${REPO_PREFIX}deephaven-server:${DEEPHAVEN_VERSION}-17-39"
    ]
    target = "python"
    args = {
        "UBUNTU_TAG" = "20.04",
        "OPENJDK_VERSION" = "17"
        "PYTHON_VERSION" = "3.9"
    }
}

target "python-17-310" {
    inherits = [ "defaults" ]
    context = "ubuntu/"
    tags = [
        "${REPO_PREFIX}deephaven-server:${DEEPHAVEN_VERSION}-17-310"
    ]
    target = "python"
    args = {
        "UBUNTU_TAG" = "22.04",
        "OPENJDK_VERSION" = "17"
        "PYTHON_VERSION" = "3.10"
    }
}

target "groovy-11-release" {
    inherits = [ "groovy-11" ]
    cache-from = [ "type=gha,scope=${CACHE_PREFIX}groovy-11" ]
    cache-to = [ "type=gha,mode=max,scope=${CACHE_PREFIX}groovy-11" ]
    platforms = [ "linux/amd64", "linux/arm64" ]
}

target "groovy-17-release" {
    inherits = [ "groovy-17" ]
    cache-from = [ "type=gha,scope=${CACHE_PREFIX}groovy-17" ]
    cache-to = [ "type=gha,mode=max,scope=${CACHE_PREFIX}groovy-17" ]
    platforms = [ "linux/amd64", "linux/arm64" ]
}

target "python-11-38-release" {
    inherits = [ "python-11-38" ]
    cache-from = [ "type=gha,scope=${CACHE_PREFIX}python-11-38" ]
    cache-to = [ "type=gha,mode=max,scope=${CACHE_PREFIX}python-11-38" ]
    platforms = [ "linux/amd64", "linux/arm64" ]
}

target "python-11-39-release" {
    inherits = [ "python-11-39" ]
    cache-from = [ "type=gha,scope=${CACHE_PREFIX}python-11-39" ]
    cache-to = [ "type=gha,mode=max,scope=${CACHE_PREFIX}python-11-39" ]
    platforms = [ "linux/amd64", "linux/arm64" ]
}

target "python-11-310-release" {
    inherits = [ "python-11-310" ]
    cache-from = [ "type=gha,scope=${CACHE_PREFIX}python-11-310" ]
    cache-to = [ "type=gha,mode=max,scope=${CACHE_PREFIX}python-11-310" ]
    platforms = [ "linux/amd64", "linux/arm64" ]
}

target "python-17-38-release" {
    inherits = [ "python-17-38" ]
    cache-from = [ "type=gha,scope=${CACHE_PREFIX}python-17-38" ]
    cache-to = [ "type=gha,mode=max,scope=${CACHE_PREFIX}python-17-38" ]
    platforms = [ "linux/amd64", "linux/arm64" ]
}

target "python-17-39-release" {
    inherits = [ "python-17-39" ]
    cache-from = [ "type=gha,scope=${CACHE_PREFIX}python-17-39" ]
    cache-to = [ "type=gha,mode=max,scope=${CACHE_PREFIX}python-17-39" ]
    platforms = [ "linux/amd64", "linux/arm64" ]
}

target "python-17-310-release" {
    inherits = [ "python-17-310" ]
    cache-from = [ "type=gha,scope=${CACHE_PREFIX}python-17-310" ]
    cache-to = [ "type=gha,mode=max,scope=${CACHE_PREFIX}python-17-310" ]
    platforms = [ "linux/amd64", "linux/arm64" ]
}
