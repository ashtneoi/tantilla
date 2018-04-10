#!/usr/bin/env bash
set -eu

if [[ $# < 1 ]]; then
    echo "Usage: $0 NAME [ARG ...]" >&2
    exit 2
fi

here="$(dirname "$0")"
NAME="$1"
shift
"$here/with_env.sh" "$here/$NAME" \
    uwsgi --socket=uwsgi.sock --wsgi-file=main.py "$@"
