#!/bin/bash

set -e

# first check if we're passing flags, if so
# prepend with sentry
if [ "${1:0:1}" = '-' ]; then
	set -- sentry "$@"
fi

case "$1" in
	celery|cleanup|config|createuser|devserver|django|exec|export|help|import|init|plugins|queues|repair|run|shell|start|tsdb|upgrade)
		set -- sentry "$@"
	;;
esac

if [ "$1" = 'sentry' ]; then
	set -- tini -- "$@"
	if [ "$(id -u)" = '0' ]; then
		mkdir -p "$SENTRY_FILESTORE_DIR"
		chown -R sentry "$SENTRY_FILESTORE_DIR"
		set -- gosu sentry "$@"
	fi
fi

CHAMBER_VERSION="2.1.0"
CHAMBER_URL="https://github.com/segmentio/chamber/releases/download/v${CHAMBER_VERSION}/chamber-v${CHAMBER_VERSION}-linux-amd64"

if [ ! -f "/usr/local/bin/chamber" ]; then
  echo "Downloading chamber from $CHAMBER_URL"
  curl -L $CHAMBER_URL -o /usr/local/bin/chamber
  chmod +x /usr/local/bin/chamber
fi

chamber exec sentry "$@"