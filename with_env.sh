#!/usr/bin/env bash
set -eu

if [[ $# < 2 ]]; then
    echo >&2 "Usage: $0 DIR PROG [ARG...]"
    exit 2
fi

here="$(dirname "$0")"
DIR="$1"
shift
source "$here/.env/bin/activate" && \
    cd "$DIR" && \
    PYTHONPATH="${PYTHONPATH:-}":"$(realpath "$here")" "$@"
