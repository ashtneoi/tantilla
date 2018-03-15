#!/usr/bin/env bash
set -eu

nginx -p $PWD -g "error_log error.log;" -c nginx.conf $*
