#!/bin/bash

# This is used for watching the .tex-file that is specified by the FILENAME
# ENV var, or the default value 'main'. This solution uses polling, instead
# of inotifywatch since Docker (or rather NFS and inotifywatch) does not
# support inotify syscalls to get through to the container, e.g. mounted
# volumes.

# Fallback to default filename if FILENAME is not set.
if [ -z "${FILENAME}" ]; then
    FILENAME='main'
fi

FILE_TO_WATCH="/tex-files/$FILENAME"

echo $FILE_TO_WATCH

# Set the start time diff for the file.
PREVIOUS=`stat -c %Z $FILE_TO_WATCH.tex`

# Poll the file every 2 seconds to check for file changes. If it has changed,
# execute the LaTeX compiler.
while true
do
  CURRENT=`stat -c %Z $FILE_TO_WATCH.tex`

  if [[ "$CURRENT" != "$PREVIOUS" ]]
  then
    lualatex $FILE_TO_WATCH.tex
    # Remove intermediate files.
    rm $FILE_TO_WATCH.aux $FILE_TO_WATCH.log $FILE_TO_WATCH.out
    PREVIOUS=$CURRENT
  fi

  # Wait 2 seconds before next poll
  sleep 2
done
