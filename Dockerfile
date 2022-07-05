# syntax=docker/dockerfile:1.4

FROM ubuntu:20.04

ARG TARGETARCH
ARG DEBIAN_FRONTEND="noninteractive"
ARG DEEPHAVEN_VERSION="0.14.0"

RUN set -eux; \
    apt-get -qq update; \
    apt-get -qq -y --no-install-recommends install \
        liblzo2-2 \
        openjdk-11-jdk-headless; \
    rm -rf /var/lib/apt/lists/*

ADD https://github.com/deephaven/deephaven-core/releases/download/v${DEEPHAVEN_VERSION}/server-jetty-${DEEPHAVEN_VERSION}.tar .
RUN set -eux; \
    mkdir /opt/deephaven; \
    tar -xf server-jetty-${DEEPHAVEN_VERSION}.tar -C /opt/deephaven; \
    rm server-jetty-${DEEPHAVEN_VERSION}.tar; \
    ln -s /opt/deephaven/server-jetty-${DEEPHAVEN_VERSION} /opt/deephaven/server-jetty
COPY image-bootstrap.properties image-bootstrap.properties 

ENV LANG='C.UTF-8' \
   JAVA_HOME=/usr/lib/jvm/java-11-openjdk-${TARGETARCH}

VOLUME /data
VOLUME /cache

ENTRYPOINT [ "/opt/deephaven/server-jetty/bin/start", "image-bootstrap.properties" ]
