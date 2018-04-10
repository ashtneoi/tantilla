#!/usr/bin/env bash
set -eu

root="$(dirname "$0")"
"$root/uwsgi.sh" "$@" --daemonize2 uwsgi.log
