#!/usr/bin/env bash
set -eu

if [[ $# < 1 ]]; then
    echo >&2 "Usage: start.sh NAME [UWSGIARG...]"
    exit 2
fi

root="$(dirname "$0")"
NAME="$1"
shift

"$root/gen_config.sh" "$NAME"
echo "    vvvvvvvvvvvvvvvvvvv"
echo ">>> Reload nginx please <<<"
echo "    ^^^^^^^^^^^^^^^^^^^"
echo
"$root/uwsgi.sh" "$NAME" "$@"
