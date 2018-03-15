#!/usr/bin/env bash
set -eu

if [[ $# < 1 ]]; then
    echo "Usage: $0 DIR [ARG ...]" >&2
    exit 2
fi

DIR=$1
shift
source .env/bin/activate && uwsgi --yaml "$DIR/uwsgi.yaml" "$@"
