# syntax=docker/dockerfile:1.4

FROM busybox as deephaven-app
ARG DEEPHAVEN_VERSION
ARG DEEPHAVEN_SHA256SUM
ADD --link https://github.com/deephaven/deephaven-core/releases/download/v${DEEPHAVEN_VERSION}/server-jetty-${DEEPHAVEN_VERSION}.tar .
RUN set -eux; \
    echo "${DEEPHAVEN_SHA256SUM}  server-jetty-${DEEPHAVEN_VERSION}.tar" | sha256sum -c -; \
    mkdir -p /opt/deephaven; \
    tar -xf server-jetty-${DEEPHAVEN_VERSION}.tar -C /opt/deephaven; \
    ln -s /opt/deephaven/server-jetty-${DEEPHAVEN_VERSION} /opt/deephaven/server-jetty

FROM scratch as groovy-config
COPY --link groovy/ /opt/deephaven/config/

FROM scratch as python-config
COPY --link python/ /opt/deephaven/config/
