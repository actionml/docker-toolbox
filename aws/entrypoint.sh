#!/bin/sh
if [ "$1" = /bin/bash ] || [ "$1" = bash ]; then
    # ignore profile load, since passing through HOME volume can cause problems
    shift; exec /bin/bash --noprofile "$@"
fi

[ -n "$*" ] && exec "$@" || exec /bin/bash --noprofile
