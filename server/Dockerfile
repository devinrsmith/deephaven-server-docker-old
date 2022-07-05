# syntax=docker/dockerfile:1.4

ARG UBUNTU_TAG="20.04"

# -------------------------------------

FROM ubuntu:${UBUNTU_TAG} as unpacked
ARG DEEPHAVEN_VERSION="0.14.0"
ADD --link https://github.com/deephaven/deephaven-core/releases/download/v${DEEPHAVEN_VERSION}/server-jetty-${DEEPHAVEN_VERSION}.tar .
RUN set -eux; \
    mkdir /opt/deephaven; \
    tar -xf server-jetty-${DEEPHAVEN_VERSION}.tar -C /opt/deephaven; \
    ln -s /opt/deephaven/server-jetty-${DEEPHAVEN_VERSION} /opt/deephaven/server-jetty

# -------------------------------------

FROM ubuntu:${UBUNTU_TAG} as jetty
ARG TARGETARCH
ARG DEBIAN_FRONTEND="noninteractive"
ARG OPENJDK_VERSION="11"
RUN set -eux; \
    apt-get -qq update; \
    apt-get -qq -y --no-install-recommends install \
        liblzo2-2 \
        openjdk-${OPENJDK_VERSION}-jdk-headless; \
    rm -rf /var/lib/apt/lists/*
ENV LANG="C.UTF-8" \
   JAVA_HOME=/usr/lib/jvm/java-${OPENJDK_VERSION}-openjdk-${TARGETARCH}
COPY --link --from=unpacked /opt/deephaven /opt/deephaven
VOLUME /data
VOLUME /cache
ENTRYPOINT [ "/opt/deephaven/server-jetty/bin/start", "image-bootstrap.properties" ]

# -------------------------------------

FROM jetty as groovy
RUN --mount=type=bind,source=./groovy,target=./groovy set -eux; \
    cp groovy/image-bootstrap.properties .

# -------------------------------------

FROM jetty as python
ARG PYTHON_VERSION="3.8"
RUN set -eux; \
    apt-get -qq update; \
    apt-get -qq -y --no-install-recommends install \
        libpython${PYTHON_VERSION} \
        python${PYTHON_VERSION} \
        python${PYTHON_VERSION}-venv; \
    rm -rf /var/lib/apt/lists/*; \
    python${PYTHON_VERSION} -m venv /opt/deephaven/venv
# TODO: add requirements.txt into .tar, or as separate release artifact?
RUN --mount=type=bind,source=./python,target=./python \
    --mount=type=cache,target=/root/.cache/pip \
    set -eux; \
    /opt/deephaven/venv/bin/pip install -r python/requirements.txt; \
    cp python/image-bootstrap.properties .
ENV VIRTUAL_ENV="/opt/deephaven/venv" \
   PATH="/opt/deephaven/venv/bin:${PATH}"

# -------------------------------------
