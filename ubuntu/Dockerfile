# syntax=docker/dockerfile:1.4

ARG UBUNTU_TAG
ARG OPENJDK_VERSION

# -------------------------------------

# Using alias builder stage since we can't use ARG as part of COPY --from flags.
# See https://github.com/docker/cli/issues/3356#issuecomment-957892224
FROM eclipse-temurin:${OPENJDK_VERSION} AS java

# -------------------------------------

FROM ubuntu:${UBUNTU_TAG} as deephaven-app
ARG DEEPHAVEN_VERSION
ARG DEEPHAVEN_SHA256SUM
ADD --link https://github.com/deephaven/deephaven-core/releases/download/v${DEEPHAVEN_VERSION}/server-jetty-${DEEPHAVEN_VERSION}.tar .
RUN set -eux; \
    echo "${DEEPHAVEN_SHA256SUM} server-jetty-${DEEPHAVEN_VERSION}.tar" | sha256sum -c -; \
    mkdir /opt/deephaven; \
    tar -xf server-jetty-${DEEPHAVEN_VERSION}.tar -C /opt/deephaven; \
    ln -s /opt/deephaven/server-jetty-${DEEPHAVEN_VERSION} /opt/deephaven/server-jetty

# -------------------------------------

FROM ubuntu:${UBUNTU_TAG} as jetty
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
COPY --link --from=java ${JAVA_HOME} ${JAVA_HOME}
COPY --link --from=deephaven-app ${DEEPHAVEN_HOME} ${DEEPHAVEN_HOME}
VOLUME /data
VOLUME /cache
EXPOSE 10000
ENTRYPOINT [ "/opt/deephaven/server-jetty/bin/start", "image-bootstrap.properties" ]

# -------------------------------------

FROM jetty as groovy
RUN --mount=type=bind,source=./groovy,target=./groovy set -eux; \
    cp groovy/image-bootstrap.properties .

# -------------------------------------

FROM jetty as python
ARG PYTHON_VERSION
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
    set -eux; \
    /opt/deephaven/venv/bin/pip install --no-cache-dir -r python/requirements.txt; \
    cp python/image-bootstrap.properties .
ENV VIRTUAL_ENV="/opt/deephaven/venv" \
   PATH="/opt/deephaven/venv/bin:${PATH}"

# -------------------------------------
