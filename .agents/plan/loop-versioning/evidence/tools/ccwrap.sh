#!/bin/sh
# Logs the exact argv spinel hands its C compiler (one per line) and keeps a
# copy of the C source it compiles, then runs cc with the same argv.
: "${CCWRAP_LOG:?set CCWRAP_LOG}"
printf '%s\n' "$@" > "$CCWRAP_LOG"
for a in "$@"; do case "$a" in *.c) cp "$a" "$CCWRAP_LOG.c" ;; esac; done
exec cc "$@"
