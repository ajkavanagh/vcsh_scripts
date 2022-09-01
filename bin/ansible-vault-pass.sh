#!/usr/bin/env bash

BW_VAULT_ENTRY_ID="ansible-vault"
if [[ -z "$BW_SESSION" ]]; then
    bw_session="$(bw unlock --raw)"
else
    bw_session="$BW_SESSION"
fi
echo "$(bw get password ${BW_VAULT_ENTRY_ID} --session ${bw_session} --raw)"
