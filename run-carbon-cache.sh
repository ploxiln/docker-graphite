#!/bin/sh
set -eu

# fix restarts
rm -rf /tmp/my.pid
# --debug makes it "run in the foreground, log to stdout"
exec /opt/graphite/bin/carbon-cache.py --pidfile=/tmp/my.pid --debug start
