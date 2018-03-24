#!/usr/bin/env bash
set -eu

if [[ $# < 1 ]]; then
    echo "Usage: $0 DIR [ARG ...]" >&2
    exit 2
fi

HERE=$(dirname "$0")
DIR=$1
shift
source $HERE/.env/bin/activate && \
    PYTHONPATH="${PYTHONPATH:-}":$(realpath "$HERE") uwsgi \
    --chdir=$HERE/example.com --socket=uwsgi.sock --wsgi-file=main.py "$@"
