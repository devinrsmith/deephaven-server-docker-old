# syntax=docker/dockerfile:1.4

ARG GENERIC_JAVA_BASE
FROM $GENERIC_JAVA_BASE
ENV DEEPHAVEN_HOME=/opt/deephaven
COPY --link --from=deephaven-scratch ${DEEPHAVEN_HOME} ${DEEPHAVEN_HOME}
COPY --link --from=groovy-config ${DEEPHAVEN_HOME}/config ${DEEPHAVEN_HOME}/config
VOLUME /data
VOLUME /cache
EXPOSE 10000
ENTRYPOINT [ "/opt/deephaven/server-jetty/bin/start", "/opt/deephaven/config/image-bootstrap.properties" ]
