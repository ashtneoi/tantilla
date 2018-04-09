#!/usr/bin/env bash
set -eu

if [[ $# < 1 ]]; then
    echo "Usage: $0 DIR [ARG ...]" >&2
    exit 2
fi

here="$(dirname "$0")"
DIR="$1"
shift
"$here/with_env.sh" "$DIR" uwsgi --socket=uwsgi.sock --wsgi-file=main.py "$@"
