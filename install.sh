#!/usr/bin/env bash
set -eu

root="$(dirname "$0")"

if ! [[ -d "$root/.env" ]]; then
    virtualenv "$root/.env" -p "$(which python3)"
fi

source "$root/.env/bin/activate"
pip3 install uWSGI==2.0.14 Werkzeug==0.11.15 toml==0.9.4
