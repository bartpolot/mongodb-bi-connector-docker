#!/bin/sh
set -x
service rsyslog start
/mongosqld/bin/mongodrdl  --uri "mongodb://$MONGODB_HOST:$MONGODB_PORT/apt?connect=direct" -c quotes > /tmp/src.drdl
/tmp/aggregate.py
/mongosqld/bin/mongosqld --logPath /var/log/mongosqld_aggregated.log --mongo-uri mongodb://$MONGODB_HOST:$MONGODB_PORT/?connect=direct --addr 0.0.0.0:$LISTEN_PORT --schema /tmp/dst.drdl
sleep 3600
