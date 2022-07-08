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

group "generics" {
    targets = [
        "eclipse-temurin-17",
        "eclipse-temurin-11",
        "amazoncorretto-17",
        "amazoncorretto-11",
        "graal-jdk-ol8-17",
        "graal-jdk-ol8-11",
        "graal-jdk-ol7-17",
        "graal-jdk-ol7-11",
        // "ibm-semeru-runtimes-17",
        // "ibm-semeru-runtimes-11",
        "sapmachine-17",
        "sapmachine-11"
    ]
}

group "all" {
    targets = [
        "default",
        "generics"
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
    default = ""
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

variable "DEEPHAVEN_SHA256SUM" {
    default = "d358b0f0945a7cd183f045a9fd72ff5c7dcb94e485c190f65b981ae65c4044ce"
}

target "ubuntu-context" {
    context = "ubuntu/"
    args = {
        "DEEPHAVEN_VERSION" = "${DEEPHAVEN_VERSION}"
        "DEEPHAVEN_SHA256SUM" = "${DEEPHAVEN_SHA256SUM}"
        "OPENJDK_VENDOR" = "eclipse-temurin"
    }
}

target "deephaven-app" {
    context = "deephaven-app/"
    target = "deephaven-app"
    args = {
        "DEEPHAVEN_VERSION" = "${DEEPHAVEN_VERSION}"
        "DEEPHAVEN_SHA256SUM" = "${DEEPHAVEN_SHA256SUM}"
    }
}

target "groovy-config" {
    context = "deephaven-app/"
    target = "groovy-config"
}

target "python-config" {
    context = "deephaven-app/"
    target = "python-config"
}

target "groovy-contexts" {
    contexts = {
        deephaven-app = "target:deephaven-app"
        groovy-config = "target:groovy-config"
    }
}

target "python-contexts" {
    contexts = {
        deephaven-app = "target:deephaven-app"
        python-config = "target:python-config"
    }
}

target "groovy-11" {
    inherits = [ "ubuntu-context", "groovy-contexts" ]
    tags = [
        "${REPO_PREFIX}deephaven-server:${DEEPHAVEN_VERSION}-11"
    ]
    target = "groovy"
    args = {
        "UBUNTU_TAG" = "22.04"
        "OPENJDK_VERSION" = "11"
    }
}

target "groovy-17" {
    inherits = [ "ubuntu-context", "groovy-contexts" ]
    tags = [
        "${REPO_PREFIX}deephaven-server:${DEEPHAVEN_VERSION}-17"
    ]
    target = "groovy"
    args = {
        "UBUNTU_TAG" = "22.04"
        "OPENJDK_VERSION" = "17"
    }
}

target "python-11-38" {
    inherits = [ "ubuntu-context", "python-contexts" ]
    tags = [
        "${REPO_PREFIX}deephaven-server:${DEEPHAVEN_VERSION}-11-38"
    ]
    target = "python"
    args = {
        "UBUNTU_TAG" = "20.04"
        "OPENJDK_VERSION" = "11"
        "PYTHON_VERSION" = "3.8"
    }
}

target "python-11-39" {
    inherits = [ "ubuntu-context", "python-contexts" ]
    tags = [
        "${REPO_PREFIX}deephaven-server:${DEEPHAVEN_VERSION}-11-39"
    ]
    target = "python"
    args = {
        "UBUNTU_TAG" = "20.04"
        "OPENJDK_VERSION" = "11"
        "PYTHON_VERSION" = "3.9"
    }
}

target "python-11-310" {
    inherits = [ "ubuntu-context", "python-contexts" ]
    tags = [
        "${REPO_PREFIX}deephaven-server:${DEEPHAVEN_VERSION}-11-310"
    ]
    target = "python"
    args = {
        "UBUNTU_TAG" = "22.04"
        "OPENJDK_VERSION" = "11"
        "PYTHON_VERSION" = "3.10"
    }
}

target "python-17-38" {
    inherits = [ "ubuntu-context", "python-contexts" ]
    tags = [
        "${REPO_PREFIX}deephaven-server:${DEEPHAVEN_VERSION}-17-38"
    ]
    target = "python"
    args = {
        "UBUNTU_TAG" = "20.04"
        "OPENJDK_VERSION" = "17"
        "PYTHON_VERSION" = "3.8"
    }
}

target "python-17-39" {
    inherits = [ "ubuntu-context", "python-contexts" ]
    tags = [
        "${REPO_PREFIX}deephaven-server:${DEEPHAVEN_VERSION}-17-39"
    ]
    target = "python"
    args = {
        "UBUNTU_TAG" = "20.04"
        "OPENJDK_VERSION" = "17"
        "PYTHON_VERSION" = "3.9"
    }
}

target "python-17-310" {
    inherits = [ "ubuntu-context", "python-contexts" ]
    tags = [
        "${REPO_PREFIX}deephaven-server:${DEEPHAVEN_VERSION}-17-310"
    ]
    target = "python"
    args = {
        "UBUNTU_TAG" = "22.04"
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

// GENERICS

target "generic-context" {
    inherits = [ "groovy-contexts" ]
    context = "generic/"
}

target "eclipse-temurin-17" {
    inherits = [ "generic-context" ]
    tags = [
        "${REPO_PREFIX}deephaven-server:${DEEPHAVEN_VERSION}-eclipse-temurin",
        "${REPO_PREFIX}deephaven-server:${DEEPHAVEN_VERSION}-eclipse-temurin-17"
    ]
    args = {
        "GENERIC_JAVA_BASE" = "eclipse-temurin:17"
    }
}

target "eclipse-temurin-11" {
    inherits = [ "generic-context" ]
    tags = [
        "${REPO_PREFIX}deephaven-server:${DEEPHAVEN_VERSION}-eclipse-temurin-11"
    ]
    args = {
        "GENERIC_JAVA_BASE" = "eclipse-temurin:11"
    }
}

target "amazoncorretto-17" {
    inherits = [ "generic-context" ]
    tags = [
        "${REPO_PREFIX}deephaven-server:${DEEPHAVEN_VERSION}-amazoncorretto",
        "${REPO_PREFIX}deephaven-server:${DEEPHAVEN_VERSION}-amazoncorretto-17"
    ]
    args = {
        "GENERIC_JAVA_BASE" = "amazoncorretto:17"
    }
}

target "amazoncorretto-11" {
    inherits = [ "generic-context" ]
    tags = [
        "${REPO_PREFIX}deephaven-server:${DEEPHAVEN_VERSION}-amazoncorretto-11"
    ]
    args = {
        "GENERIC_JAVA_BASE" = "amazoncorretto:11"
    }
}

target "graal-jdk-ol8-17" {
    inherits = [ "generic-context" ]
    tags = [
        "${REPO_PREFIX}deephaven-server:${DEEPHAVEN_VERSION}-graal",
        "${REPO_PREFIX}deephaven-server:${DEEPHAVEN_VERSION}-graal-17",
        "${REPO_PREFIX}deephaven-server:${DEEPHAVEN_VERSION}-graal-jdk-ol8-17"
    ]
    args = {
        "GENERIC_JAVA_BASE" = "ghcr.io/graalvm/jdk:ol8-java17"
    }
}

target "graal-jdk-ol8-11" {
    inherits = [ "generic-context" ]
    tags = [
        "${REPO_PREFIX}deephaven-server:${DEEPHAVEN_VERSION}-graal-11",
        "${REPO_PREFIX}deephaven-server:${DEEPHAVEN_VERSION}-graal-jdk-ol8-11"
    ]
    args = {
        "GENERIC_JAVA_BASE" = "ghcr.io/graalvm/jdk:ol8-java11"
    }
}

target "graal-jdk-ol7-17" {
    inherits = [ "generic-context" ]
    tags = [
        "${REPO_PREFIX}deephaven-server:${DEEPHAVEN_VERSION}-graal-jdk-ol7-17"
    ]
    args = {
        "GENERIC_JAVA_BASE" = "ghcr.io/graalvm/jdk:ol7-java17"
    }
}

target "graal-jdk-ol7-11" {
    inherits = [ "generic-context" ]
    tags = [
        "${REPO_PREFIX}deephaven-server:${DEEPHAVEN_VERSION}-graal-jdk-ol7-11"
    ]
    args = {
        "GENERIC_JAVA_BASE" = "ghcr.io/graalvm/jdk:ol7-java11"
    }
}

// Note: ibm-semeru does not currently work with Deephaven - hotspot-impl crashes.
// target "ibm-semeru-runtimes-17" {
//     inherits = [ "generic-context" ]
//     tags = [
//         "${REPO_PREFIX}deephaven-server:${DEEPHAVEN_VERSION}-ibm-semeru-runtimes",
//         "${REPO_PREFIX}deephaven-server:${DEEPHAVEN_VERSION}-ibm-semeru-runtimes-17"
//     ]
//     args = {
//         "GENERIC_JAVA_BASE" = "ibm-semeru-runtimes:open-17-jdk"
//     }
// }

// target "ibm-semeru-runtimes-11" {
//     inherits = [ "generic-context" ]
//     tags = [
//         "${REPO_PREFIX}deephaven-server:${DEEPHAVEN_VERSION}-ibm-semeru-runtimes-11"
//     ]
//     args = {
//         "GENERIC_JAVA_BASE" = "ibm-semeru-runtimes:open-11-jdk"
//     }
// }

target "sapmachine-17" {
    inherits = [ "generic-context" ]
    tags = [
        "${REPO_PREFIX}deephaven-server:${DEEPHAVEN_VERSION}-sapmachine",
        "${REPO_PREFIX}deephaven-server:${DEEPHAVEN_VERSION}-sapmachine-17"
    ]
    args = {
        "GENERIC_JAVA_BASE" = "sapmachine:17"
    }
}

target "sapmachine-11" {
    inherits = [ "generic-context" ]
    tags = [
        "${REPO_PREFIX}deephaven-server:${DEEPHAVEN_VERSION}-sapmachine-11"
    ]
    args = {
        "GENERIC_JAVA_BASE" = "sapmachine:11"
    }
}
