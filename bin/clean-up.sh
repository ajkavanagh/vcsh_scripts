#/usr/bin/env bash
# clean up python runtime, .tox, .venv, etc.

find . -name '.tox' -prune -exec rm -rf "{}" \;
find . -iname '.venv*' -prune -exec rm -rf "{}" \;
find . -name '.testrepository' -prune -exec rm -rf "{}" \;
find . -name '__pycache__' -prune -exec rm -rf "{}" \;
find . -iname '*.pyc' -delete
find . -name 'func-results.json' -delete

# cleanup rust targets
# 1. rust directory is above the current directory
pwd | egrep "/rust(/|$)" && find -name 'target' -type d -prune -exec rm -rf "{}" \;
# 2. rust directory is below the current directory
find -name 'target' -type d | egrep "/rust/" | xargs rm -rf
