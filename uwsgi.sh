#!/usr/bin/env bash
set -eu

if [[ $# != 1 ]]; then
    echo "Usage: $0 DIR" >&2
    exit 2
fi

source .env/bin/activate && uwsgi --yaml "$1/uwsgi.yaml" "$@"
