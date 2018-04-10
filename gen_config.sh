#!/usr/bin/env bash
set -eu

if [[ $# != 1 ]]; then
    echo >&2 "Usage: gen_config.sh NAME"
    exit 2
fi

root="$(dirname "$0")"
NAME="$1"
config="$root/$NAME/config.toml"
server_name="$(shtoml "$config" server_name)"
mount_point="$(shtoml "$config" mount_point)"

mint "$root/$NAME/nginx.app.conf.tmpl" server_name="$server_name" \
    mount_point="$mount_point" >"$root/$NAME/nginx.app.conf"
