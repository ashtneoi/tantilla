#!/usr/bin/env bash
set -eu

if [[ $# < 1 ]]; then
    echo "Usage: $0 NAME [ARG ...]" >&2
    exit 2
fi

root="$(dirname "$0")"
NAME="$1"
shift
"$root/with_env.sh" "$root/$NAME" \
    uwsgi --socket=uwsgi.sock --wsgi-file=main.py "$@"
