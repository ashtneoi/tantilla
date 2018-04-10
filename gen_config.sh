#!/usr/bin/env bash
set -eu

if [[ $# != 1 ]]; then
    echo >&2 "Usage: gen_config.sh NAME"
    exit 2
fi

here="$(dirname "$0")"
NAME="$1"
config="$here/$NAME/config.toml"
server_name="$(shtoml "$config" server_name)"
mount_point="$(shtoml "$config" mount_point)"

mint "$NAME/nginx.conf.tmpl" server_name="$server_name" \
    mount_point="$mount_point" >"$NAME/nginx.conf"
