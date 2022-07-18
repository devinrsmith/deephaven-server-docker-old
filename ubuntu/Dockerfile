# syntax=docker/dockerfile:1.4

ARG UBUNTU_TAG
ARG OPENJDK_VERSION
ARG OPENJDK_VENDOR

# -------------------------------------
# The following OpenJDK images have a self-contained JDK making it really easy to mixin.
#
# Note: using alias builder stage since we can't use ARG as part of COPY --from flags.
# See https://github.com/docker/cli/issues/3356#issuecomment-957892224
FROM eclipse-temurin:${OPENJDK_VERSION} as eclipse-temurin
# Already has /opt/java/openjdk

# Note: ibm-semeru-runtimes does not currently work with Deephaven - hotspot-impl crashes.
FROM ibm-semeru-runtimes:open-${OPENJDK_VERSION}-jdk as ibm-semeru-runtimes
# Already has /opt/java/openjdk

FROM mcr.microsoft.com/openjdk/jdk:${OPENJDK_VERSION}-ubuntu as microsoft-openjdk
RUN set -eux; \
    mkdir -p /opt/java; \
    mv $JAVA_HOME /opt/java/openjdk

FROM ${OPENJDK_VENDOR} as openjdk

# -------------------------------------

FROM ubuntu:${UBUNTU_TAG} as base
ARG DEBIAN_FRONTEND="noninteractive"
RUN set -eux; \
    apt-get -qq update; \
    apt-get -qq -y --no-install-recommends install \
        liblzo2-2 \
        tzdata \
        ca-certificates \
        locales; \
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen; \
    locale-gen en_US.UTF-8; \
    rm -rf /var/lib/apt/lists/*
ENV LANG='en_US.UTF-8' \
    LANGUAGE='en_US:en' \
    LC_ALL='en_US.UTF-8' \
    JAVA_HOME=/opt/java/openjdk \
    DEEPHAVEN_HOME=/opt/deephaven

# -------------------------------------

FROM base as python-base
ARG DEBIAN_FRONTEND="noninteractive"
ARG PYTHON_VERSION
RUN set -eux; \
    apt-get -qq update; \
    apt-get -qq -y --no-install-recommends install \
        libpython${PYTHON_VERSION} \
        python${PYTHON_VERSION} \
        python${PYTHON_VERSION}-venv; \
    rm -rf /var/lib/apt/lists/*
RUN --mount=type=bind,source=./python,target=./python \
    set -eux; \
    python${PYTHON_VERSION} -m venv /opt/deephaven/venv; \
    /opt/deephaven/venv/bin/pip install --no-cache-dir -r ./python/requirements.txt
ENV VIRTUAL_ENV="/opt/deephaven/venv" \
    PATH="/opt/deephaven/venv/bin:${PATH}"
# TODO: add requirements.txt into .tar, or as separate release artifact?

# -------------------------------------

FROM base as groovy
COPY --link --from=openjdk ${JAVA_HOME} ${JAVA_HOME}
COPY --link --from=deephaven-scratch ${DEEPHAVEN_HOME} ${DEEPHAVEN_HOME}
COPY --link --from=groovy-config ${DEEPHAVEN_HOME}/config ${DEEPHAVEN_HOME}/config
VOLUME /data
VOLUME /cache
EXPOSE 10000
ENTRYPOINT [ "/opt/deephaven/server-jetty/bin/start", "/opt/deephaven/config/image-bootstrap.properties" ]

# -------------------------------------

FROM python-base as python
COPY --link --from=openjdk ${JAVA_HOME} ${JAVA_HOME}
COPY --link --from=deephaven-scratch ${DEEPHAVEN_HOME} ${DEEPHAVEN_HOME}
COPY --link --from=python-config ${DEEPHAVEN_HOME}/config ${DEEPHAVEN_HOME}/config
VOLUME /data
VOLUME /cache
EXPOSE 10000
ENTRYPOINT [ "/opt/deephaven/server-jetty/bin/start", "/opt/deephaven/config/image-bootstrap.properties" ]
