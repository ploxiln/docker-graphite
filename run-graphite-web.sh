#!/bin/sh
set -eu

exec /usr/bin/uwsgi_python \
    --http-socket :$PORT   \
    --processes   $PROCS   \
    --threads     $THREADS \
    --master               \
    --need-app             \
    --die-on-term          \
    --wsgi-file /opt/graphite/conf/graphite.wsgi.example
