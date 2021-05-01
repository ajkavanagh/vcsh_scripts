#!/bin/bash

BW_VAULT_ENTRY_ID="ansible-vault"
bw_session="$(bw unlock --raw)"
echo "$(bw get password ${BW_VAULT_ENTRY_ID} --session ${bw_session} --raw)"
