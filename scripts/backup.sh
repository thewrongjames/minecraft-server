#!/bin/sh

# Designed to be run inside a docker container. This should not be invoked
# directly, but should instead be run through `make backup`.

# In a script so that I could use bash variables, as every line of a makefile is
# executed in a new sub-shell.

if [ "$#" != "2" ]
then
  echo Backs up the current server files and then changes them to be owned by \
    the given user ID and group ID. Backups are timestamped in UTC.
  echo Usage: backup user-ID group-ID
fi

ARCHIVE_PATH="/backups/`date --utc +%Y%m%d%H%M%S`.tar.gz"

tar czvf $ARCHIVE_PATH /server-files
chown $1:$2 $ARCHIVE_PATH