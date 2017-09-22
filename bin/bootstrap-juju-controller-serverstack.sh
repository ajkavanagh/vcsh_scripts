#!/bin/bash

set -e

NETWORK_NAME=ajkavanagh_admin_net

_OS_REGION_NAME=$(env | grep OS_REGION_NAME | cut -d "=" -f 2)
# exit if this isn't running against serverstack
if [[ "xxx$_OS_REGION_NAME" != "xxxserverstack" ]]; then
	echo "OS_* vars aren't for serverstack ... exiting"
	exit 1
fi

if [[ ! -z $(juju controllers 2>/dev/null | grep serverstack) ]]; then
	echo "serverstack is already bootstrapped"
	exit 1
fi

NETWORK=$(openstack network list -f value | grep $NETWORK_NAME | cut -d " " -f 1)

juju bootstrap serverstack serverstack \
	--config network=$NETWORK \
	--bootstrap-constraints virt-type=kvm \
	--constraints "mem=4G virt-type=kvm"

sleep 2

juju model-defaults image-stream=daily
juju model-defaults test-mode=true
juju model-defaults transmit-vendor-metrics=false
juju model-defaults enable-os-refresh-update=false
juju model-defaults enable-os-upgrade=false
juju model-defaults automatically-retry-hooks=false
juju model-defaults network=$NETWORK
