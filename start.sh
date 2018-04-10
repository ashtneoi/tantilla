#!/usr/bin/env bash
set -eu

if [[ $# != 1 ]]; then
    echo >&2 "Usage: start.sh NAME"
    exit 2
fi

here="$(dirname "$0")"
NAME="$1"

"$here/gen_config.sh" "$NAME"
echo "    vvvvvvvvvvvvvvvvvvv"
echo ">>> Reload nginx please <<<"
echo "    ^^^^^^^^^^^^^^^^^^^"
echo
"$here/uwsgi.sh" "$NAME"
