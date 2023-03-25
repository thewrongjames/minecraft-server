#!/bin/sh

# Designed to be run inside a docker container. This should not be invoked
# directly, but should instead be run through `make restore`.

rm -rf /serverfiles/*

tar xzvf "backups/`ls backups -t --width=1 | head -n 1`"