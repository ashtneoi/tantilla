#!/usr/bin/env bash
set -eu

if [[ $# < 1 ]]; then
    echo >&2 "Usage: startd.sh NAME [UWSGIARG...]"
    exit 2
fi

root="$(dirname "$0")"
NAME="$1"
shift

"$root/start.sh" "$NAME" --daemonize2 "$root/$NAME/uwsgi.log" "$@"
