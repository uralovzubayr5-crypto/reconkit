#!/usr/bin/env bash
# wrapper so you can run ./recon.sh <target> right after unzipping
exec "$(dirname "$0")/reconkit/recon.sh" "$@"
