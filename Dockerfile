FROM debian:8
MAINTAINER Pierce Lopez <pierce.lopez@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get --assume-yes --quiet update && \
    apt-get --assume-yes --quiet install --no-install-recommends \
        gcc                 \
        binutils            \
        sqlite3             \
        python-cairocffi    \
        uwsgi               \
        uwsgi-plugin-python \
        fonts-dejavu        \
        ca-certificates     \
        python-dev          \
        python-setuptools

RUN easy_install pip && \
    pip install --no-binary :all: \
        pytz                  \
        python-memcached      \
        django==1.7.11        \
        django-tagging==0.3.6 \
        whisper==0.9.15       \
        carbon==0.9.15        \
        graphite-web==0.9.15

# for graphite-web:  map /conf and it must contain local_settings.py
# for carbon-cache:  map /conf and it must contain carbon.conf and storage-schemas.conf
# also map the carbon/whisper data volume, specified in the config file
VOLUME ["/log", "/data"]

# for carbon-cache
ENV GRAPHITE_CONF_DIR=/conf
EXPOSE 2003 2004 7002

# for graphite-web
RUN ln -s /conf/local_settings.py /opt/graphite/webapp/graphite/local_settings.py
ENV PYTHONPATH=/conf PROCS=2 THREADS=2 PORT=9090
EXPOSE 9090

COPY run-graphite-web.sh run-carbon-cache.sh /
RUN useradd --base-dir /home --create-home --uid 1900 graphite

USER graphite
CMD ["/run-graphite-web.sh"]
# or /run-carbon-cache.sh
