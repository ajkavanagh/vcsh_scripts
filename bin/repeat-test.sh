#/bin/bash

set -ex

while [ 1 ]; do
	juju destroy-environment testing -y
	tox -e func27-smoke
done

