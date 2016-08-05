#!/bin/bash

# Default our ENV vars
if [ -z "$ZOOKEEPER_HOST" ]; then export ZOOKEEPER_HOST=zookeeper; fi
if [ -z "$ZOOKEEPER_PORT" ]; then export ZOOKEEPER_PORT=2181; fi

# Run docker templating
dockerize \
    -template=/app/templates/server.properties.tmpl:/app/${KAFKA_NAME}/config/server.properties \
    -template=/app/templates/log4j.properties.tmpl:/app/${KAFKA_NAME}/config/log4j.properties

# Exec our CMD
exec "$@"
