#!/usr/bin/env bash

_ifs=IFS
IFS='
'
for x in $(find -type f); do
	md5sum "$x"
done
IFS=$_ifs
