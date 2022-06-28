FROM ubuntu:20.04

ARG TARGETARCH
ARG DEBIAN_FRONTEND="noninteractive"

RUN set -eux; \
    apt-get -qq update; \
    apt-get -qq -y --no-install-recommends install \
        liblzo2-2 \
        python3.8 \
        libpython3.8 \
        python3-venv \
        openjdk-11-jdk-headless; \
    rm -rf /var/lib/apt/lists/*; \
    python3 -m venv /opt/deephaven-venv; \
    /opt/deephaven-venv/bin/pip install -q --no-cache-dir --upgrade pip setuptools

COPY requirements.txt requirements.txt
RUN set -eux; \
    /opt/deephaven-venv/bin/pip install -q --no-cache-dir -r requirements.txt; \
    rm requirements.txt

# todo: need to install jpy and deephaven wheel

ADD https://github.com/deephaven/deephaven-core/releases/download/v0.13.0/server-jetty-0.13.0.tar .
RUN set -eux; \
    mkdir /opt/deephaven; \
    tar -xf server-jetty-0.13.0.tar -C /opt/deephaven; \
    rm server-jetty-0.13.0.tar
COPY image-bootstrap.properties image-bootstrap.properties 

ENV LANG='en_US.UTF-8' \
   LANGUAGE='en_US:en' \
   LC_ALL='en_US.UTF-8' \
   JAVA_HOME=/usr/lib/jvm/java-11-openjdk-${TARGETARCH}

VOLUME /data
VOLUME /cache

ENTRYPOINT [ "/opt/deephaven/server-jetty-0.13.0/bin/start", "image-bootstrap.properties" ]