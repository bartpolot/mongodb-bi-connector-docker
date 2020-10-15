#!/bin/bash
/mongosqld/bin/mongodrdl --uri "mongodb://$MONGODB_HOST:$MONGODB__PORT/$DATABASE?connect=direct" -c "$COLLECTION" > /tmp/src.drdl
/tmp/aggregate.py
# without sh -c mongosqld complains about missing syslog, despite using a file as log
sh -c "/mongosqld/bin/mongosqld --logPath /tmp/mongosqld.log --mongo-uri mongodb://$MONGODB_HOST:$MONGODB__PORT/?connect=direct --addr 0.0.0.0:$LISTEN_PORT --schema /tmp/dst.drdl"
