#/usr/bin/env bash
# clean up sync conflicts brought about by Syncthing

find . -name '*.sync-conflict-*'

read -r -p "Are you sure you want to delete the sync-conflicts? [y/N] " response
response=${response,,}    # tolower
if [[ "$response" =~ ^(yes|y)$ ]]; then
	find . -name '*sync-conflict*' -prune -exec rm -rf "{}" \;
	echo "Done!"
else
	echo "Doing nothing."
fi
