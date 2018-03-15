#!/usr/bin/env bash
set -eu

HERE=$(dirname "$0")
$HERE/uwsgi.sh "$@" --daemonize2 uwsgi.log
