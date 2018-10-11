#!/bin/sh

# Check default variables
if [ -z "${BACKEND_HOST}" ]
then
  echo "BACKEND_HOST env var is needed in order to start."
  exit 1
fi

BACKEND_PORT=${BACKEND_PORT:-80}

# Setup config
sed -i "s/__BACKEND_HOST__/${BACKEND_HOST}/g" /etc/varnish/default.vcl
sed -i "s/__BACKEND_PORT__/${BACKEND_PORT}/g" /etc/varnish/default.vcl

# Start service
exec "$@"
