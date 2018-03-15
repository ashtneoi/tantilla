#!/usr/bin/env bash

set -o errexit
shopt -s nullglob

if ! [[ -d .env ]]; then
    virtualenv .env -p $(which python3)
fi

source .env/bin/activate

pip3 install uWSGI==2.0.14 Werkzeug==0.11.15
